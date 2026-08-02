package com.taxpilot.service;

import com.taxpilot.domain.entity.AdvanceTaxSchedule;
import com.taxpilot.domain.entity.TaxEstimate;
import com.taxpilot.domain.entity.User;
import com.taxpilot.domain.enums.AdvanceTaxInstallment;
import com.taxpilot.domain.enums.PaymentStatus;
import com.taxpilot.domain.enums.TaxRegime;
import com.taxpilot.dto.request.AdvanceTaxPaymentRequest;
import com.taxpilot.dto.response.AdvanceTaxResponse;
import com.taxpilot.exception.BadRequestException;
import com.taxpilot.exception.ResourceNotFoundException;
import com.taxpilot.repository.AdvanceTaxRepository;
import com.taxpilot.repository.TaxEstimateRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class AdvanceTaxService {

    // Fixed installment schedule: installment, due date, cumulative %
    private static final Object[][] SCHEDULE = {
        {AdvanceTaxInstallment.jun_15, "2024-06-15", (short) 15},
        {AdvanceTaxInstallment.sep_15, "2024-09-15", (short) 45},
        {AdvanceTaxInstallment.dec_15, "2024-12-15", (short) 75},
        {AdvanceTaxInstallment.mar_15, "2025-03-15", (short) 100},
    };

    private static final BigDecimal MIN_TAX_FOR_ADVANCE = new BigDecimal("10000");

    private final AdvanceTaxRepository advanceTaxRepo;
    private final TaxEstimateRepository taxEstimateRepo;
    private final UserService userService;
    private final NotificationService notificationService;

    public AdvanceTaxService(AdvanceTaxRepository advanceTaxRepo,
                              TaxEstimateRepository taxEstimateRepo,
                              UserService userService,
                              NotificationService notificationService) {
        this.advanceTaxRepo    = advanceTaxRepo;
        this.taxEstimateRepo   = taxEstimateRepo;
        this.userService       = userService;
        this.notificationService = notificationService;
    }

    // ----------------------------------------------------------------
    // Get advance tax schedule for a user/FY — recalculates from estimate
    // ----------------------------------------------------------------
    public List<AdvanceTaxResponse> getSchedule(UUID userId, String financialYear) {
        buildOrRefreshSchedule(userId, financialYear);
        return advanceTaxRepo
                .findByUserIdAndFinancialYearOrderByDueDate(userId, financialYear)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    // ----------------------------------------------------------------
    // Record a payment
    // ----------------------------------------------------------------
    public AdvanceTaxResponse recordPayment(UUID userId, AdvanceTaxPaymentRequest req) {
        AdvanceTaxSchedule installment = advanceTaxRepo
                .findByUserIdAndFinancialYearAndInstallment(
                        userId, req.getFinancialYear(), req.getInstallment())
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Advance tax installment not found: " + req.getInstallment()));

        if (req.getAmountPaid().compareTo(BigDecimal.ZERO) <= 0) {
            throw new BadRequestException("Payment amount must be greater than zero.");
        }

        installment.setAmountPaid(
                installment.getAmountPaid().add(req.getAmountPaid()));
        installment.setPaidOn(req.getPaidOn());
        installment.setChallanNumber(req.getChallanNumber());

        // Mark paid if cumulative paid >= estimated
        if (installment.getAmountPaid().compareTo(installment.getEstimatedAmount()) >= 0) {
            installment.setStatus(PaymentStatus.paid);
        }

        return toResponse(advanceTaxRepo.save(installment));
    }

    // ----------------------------------------------------------------
    // Build / refresh schedule from current tax estimate
    // ----------------------------------------------------------------
    public void buildOrRefreshSchedule(UUID userId, String financialYear) {
        User user = userService.findById(userId);

        // Get annual tax from estimate
        TaxEstimate est = taxEstimateRepo
                .findByUserIdAndFinancialYear(userId, financialYear)
                .orElse(null);

        BigDecimal annualTax = BigDecimal.ZERO;
        if (est != null) {
            annualTax = user.getPreferredRegime() == TaxRegime.new_regime
                    ? est.getTotalTaxNew() : est.getTotalTaxOld();
        }

        // Advance tax not applicable if annual tax <= ₹10,000
        if (annualTax.compareTo(MIN_TAX_FOR_ADVANCE) <= 0) return;

        BigDecimal prevCumulative = BigDecimal.ZERO;
        for (Object[] row : SCHEDULE) {
            AdvanceTaxInstallment inst = (AdvanceTaxInstallment) row[0];
            LocalDate dueDate          = LocalDate.parse((String) row[1]);
            short cumulativePct        = (short) row[2];

            BigDecimal cumulativeAmount = annualTax
                    .multiply(BigDecimal.valueOf(cumulativePct))
                    .divide(BigDecimal.valueOf(100), 0, RoundingMode.HALF_UP);
            BigDecimal installmentAmount = cumulativeAmount.subtract(prevCumulative);

            AdvanceTaxSchedule schedule = advanceTaxRepo
                    .findByUserIdAndFinancialYearAndInstallment(userId, financialYear, inst)
                    .orElse(AdvanceTaxSchedule.builder()
                            .user(user)
                            .financialYear(financialYear)
                            .installment(inst)
                            .dueDate(dueDate)
                            .cumulativePercent(cumulativePct)
                            .build());

            schedule.setEstimatedAmount(installmentAmount);

            // Auto-update status if not paid
            if (schedule.getStatus() != PaymentStatus.paid) {
                schedule.setStatus(dueDate.isBefore(LocalDate.now())
                        ? PaymentStatus.overdue : PaymentStatus.pending);
            }

            advanceTaxRepo.save(schedule);
            prevCumulative = cumulativeAmount;
        }
    }

    // ----------------------------------------------------------------
    // Scheduled job: mark overdue, send reminders
    // Runs daily at 8 AM IST
    // ----------------------------------------------------------------
    @Scheduled(cron = "0 0 8 * * *", zone = "Asia/Kolkata")
    public void runDailyAdvanceTaxCheck() {
        LocalDate today = LocalDate.now();

        // Mark newly overdue installments
        List<AdvanceTaxSchedule> overdue = advanceTaxRepo.findNewlyOverdue(today);
        for (AdvanceTaxSchedule inst : overdue) {
            inst.setStatus(PaymentStatus.overdue);
            advanceTaxRepo.save(inst);
            notificationService.sendAdvanceTaxOverdueNotification(inst);
        }

        // Send reminders for installments due in 7 days
        List<AdvanceTaxSchedule> upcoming = advanceTaxRepo
                .findUpcoming(today, today.plusDays(7));
        for (AdvanceTaxSchedule inst : upcoming) {
            notificationService.sendAdvanceTaxReminderNotification(inst);
        }
    }

    // ----------------------------------------------------------------
    // Map to response
    // ----------------------------------------------------------------
    public AdvanceTaxResponse toResponse(AdvanceTaxSchedule a) {
        BigDecimal balance = a.getEstimatedAmount().subtract(a.getAmountPaid())
                .max(BigDecimal.ZERO);
        long days = ChronoUnit.DAYS.between(LocalDate.now(), a.getDueDate());

        return AdvanceTaxResponse.builder()
                .id(a.getId())
                .financialYear(a.getFinancialYear())
                .installment(a.getInstallment())
                .dueDate(a.getDueDate())
                .cumulativePercent(a.getCumulativePercent())
                .estimatedAmount(a.getEstimatedAmount())
                .amountPaid(a.getAmountPaid())
                .balanceDue(balance)
                .status(a.getStatus())
                .paidOn(a.getPaidOn())
                .challanNumber(a.getChallanNumber())
                .daysUntilDue(days)
                .build();
    }
}
