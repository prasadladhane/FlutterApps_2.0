package com.taxpilot.service;

import com.taxpilot.config.CacheConfig;
import com.taxpilot.domain.entity.TaxEstimate;
import com.taxpilot.domain.entity.User;
import com.taxpilot.domain.enums.TaxRegime;
import com.taxpilot.dto.response.TaxEstimateResponse;
import com.taxpilot.exception.ResourceNotFoundException;
import com.taxpilot.repository.AdvanceTaxRepository;
import com.taxpilot.repository.DeductionRepository;
import com.taxpilot.repository.ExpenseEntryRepository;
import com.taxpilot.repository.IncomeEntryRepository;
import com.taxpilot.repository.TaxEstimateRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.OffsetDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
@Transactional
public class TaxService {

    private static final Logger log = LoggerFactory.getLogger(TaxService.class);

    // FY 2024-25 New Regime slabs (Budget 2024)
    private static final BigDecimal[][] NEW_SLABS = {
        {new BigDecimal("0"),       new BigDecimal("300000"),  new BigDecimal("0")},
        {new BigDecimal("300001"),  new BigDecimal("700000"),  new BigDecimal("5")},
        {new BigDecimal("700001"),  new BigDecimal("1000000"), new BigDecimal("10")},
        {new BigDecimal("1000001"), new BigDecimal("1200000"), new BigDecimal("15")},
        {new BigDecimal("1200001"), new BigDecimal("1500000"), new BigDecimal("20")},
        {new BigDecimal("1500001"), null,                      new BigDecimal("30")},
    };

    // FY 2024-25 Old Regime slabs (individual below 60)
    private static final BigDecimal[][] OLD_SLABS = {
        {new BigDecimal("0"),       new BigDecimal("250000"),  new BigDecimal("0")},
        {new BigDecimal("250001"),  new BigDecimal("500000"),  new BigDecimal("5")},
        {new BigDecimal("500001"),  new BigDecimal("1000000"), new BigDecimal("20")},
        {new BigDecimal("1000001"), null,                      new BigDecimal("30")},
    };

    // Old Regime — Senior Citizen (60-79)
    private static final BigDecimal[][] OLD_SLABS_SENIOR = {
        {new BigDecimal("0"),       new BigDecimal("300000"),  new BigDecimal("0")},
        {new BigDecimal("300001"),  new BigDecimal("500000"),  new BigDecimal("5")},
        {new BigDecimal("500001"),  new BigDecimal("1000000"), new BigDecimal("20")},
        {new BigDecimal("1000001"), null,                      new BigDecimal("30")},
    };

    // Old Regime — Super Senior (80+)
    private static final BigDecimal[][] OLD_SLABS_SUPER = {
        {new BigDecimal("0"),       new BigDecimal("500000"),  new BigDecimal("0")},
        {new BigDecimal("500001"),  new BigDecimal("1000000"), new BigDecimal("20")},
        {new BigDecimal("1000001"), null,                      new BigDecimal("30")},
    };

    private static final BigDecimal STD_DEDUCTION_NEW = new BigDecimal("75000");
    private static final BigDecimal STD_DEDUCTION_OLD = new BigDecimal("50000");
    private static final BigDecimal CESS_RATE         = new BigDecimal("0.04");
    private static final BigDecimal SECTION_44ADA_LIMIT = new BigDecimal("7500000");
    private static final BigDecimal SECTION_44ADA_RATE  = new BigDecimal("0.5");

    // Section limits for capping old regime deductions
    private static final Map<String, BigDecimal> DEDUCTION_LIMITS = new HashMap<>();
    static {
        DEDUCTION_LIMITS.put("80C",    new BigDecimal("150000"));
        DEDUCTION_LIMITS.put("80CCD1B", new BigDecimal("50000"));
        DEDUCTION_LIMITS.put("80D",    new BigDecimal("25000"));
        DEDUCTION_LIMITS.put("80TTA",  new BigDecimal("10000"));
        DEDUCTION_LIMITS.put("80TTB",  new BigDecimal("50000"));
        DEDUCTION_LIMITS.put("24B",    new BigDecimal("200000"));
    }

    private final TaxEstimateRepository taxEstimateRepo;
    private final IncomeEntryRepository incomeRepo;
    private final ExpenseEntryRepository expenseRepo;
    private final DeductionRepository deductionRepo;
    private final AdvanceTaxRepository advanceTaxRepo;
    private final UserService userService;

    public TaxService(TaxEstimateRepository taxEstimateRepo,
                      IncomeEntryRepository incomeRepo,
                      ExpenseEntryRepository expenseRepo,
                      DeductionRepository deductionRepo,
                      AdvanceTaxRepository advanceTaxRepo,
                      UserService userService) {
        this.taxEstimateRepo = taxEstimateRepo;
        this.incomeRepo      = incomeRepo;
        this.expenseRepo     = expenseRepo;
        this.deductionRepo   = deductionRepo;
        this.advanceTaxRepo  = advanceTaxRepo;
        this.userService     = userService;
    }

    // ----------------------------------------------------------------
    // Get cached tax estimate — main endpoint call
    // ----------------------------------------------------------------
    @Cacheable(value = CacheConfig.CACHE_TAX_ESTIMATE, key = "#userId + ':' + #financialYear")
    @Transactional(readOnly = true)
    public TaxEstimateResponse getTaxEstimate(UUID userId, String financialYear) {
        TaxEstimate est = taxEstimateRepo.findByUserIdAndFinancialYear(userId, financialYear)
                .orElseGet(() -> compute(userId, financialYear));
        return toResponse(est, userService.findById(userId).getPreferredRegime());
    }

    // ----------------------------------------------------------------
    // Refresh estimate — called async when income/expense/deduction changes
    // ----------------------------------------------------------------
    @CacheEvict(value = {CacheConfig.CACHE_TAX_ESTIMATE, CacheConfig.CACHE_DASHBOARD},
                key = "#userId + ':' + #financialYear")
    public TaxEstimate refreshEstimate(UUID userId, String financialYear) {
        log.debug("Refreshing tax estimate for user {} FY {}", userId, financialYear);
        return compute(userId, financialYear);
    }

    // ----------------------------------------------------------------
    // Core computation — runs in Java (mirrors PostgreSQL functions)
    // ----------------------------------------------------------------
    private TaxEstimate compute(UUID userId, String financialYear) {
        User user = userService.findById(userId);

        // Aggregate income
        BigDecimal grossIncome      = incomeRepo.sumAmountByUserAndFy(userId, financialYear);
        BigDecimal totalTds         = incomeRepo.sumTdsByUserAndFy(userId, financialYear);
        BigDecimal consultingIncome = incomeRepo.sumConsultingReceiptsByUserAndFy(userId, financialYear);
        BigDecimal deductibleExp    = expenseRepo.sumDeductibleByUserAndFy(userId, financialYear);
        BigDecimal advancePaid      = advanceTaxRepo.sumPaidByUserAndFy(userId, financialYear);

        // 44ADA eligibility
        boolean is44ada = is44adaEligible(user, consultingIncome);
        BigDecimal presumptive = is44ada
                ? consultingIncome.multiply(SECTION_44ADA_RATE).setScale(2, RoundingMode.HALF_UP)
                : null;

        // Effective income (business income portion replaced by presumptive)
        BigDecimal effectiveIncome = is44ada
                ? presumptive.add(grossIncome.subtract(consultingIncome))
                : grossIncome;

        // ------ NEW REGIME ------
        BigDecimal taxableNew  = effectiveIncome.subtract(STD_DEDUCTION_NEW).max(BigDecimal.ZERO);
        BigDecimal slabTaxNew  = calcSlabTax(taxableNew, NEW_SLABS);
        BigDecimal rebateNew   = calcRebate87A(taxableNew, slabTaxNew, TaxRegime.new_regime);
        BigDecimal taxAfterNew = slabTaxNew.subtract(rebateNew).max(BigDecimal.ZERO);
        BigDecimal surNew      = calcSurcharge(taxableNew, taxAfterNew, TaxRegime.new_regime);
        BigDecimal cessNew     = taxAfterNew.add(surNew).multiply(CESS_RATE)
                                    .setScale(2, RoundingMode.HALF_UP);
        BigDecimal totalTaxNew = taxAfterNew.add(surNew).add(cessNew);

        // ------ OLD REGIME ------
        BigDecimal chapterVIa   = calcChapterVIaDeductions(userId, financialYear);
        BigDecimal totalDeductOld = STD_DEDUCTION_OLD.add(chapterVIa);
        BigDecimal taxableOld   = effectiveIncome.subtract(totalDeductOld).max(BigDecimal.ZERO);
        BigDecimal[][] oldSlabs = getOldSlabs(user);
        BigDecimal slabTaxOld   = calcSlabTax(taxableOld, oldSlabs);
        BigDecimal rebateOld    = calcRebate87A(taxableOld, slabTaxOld, TaxRegime.old_regime);
        BigDecimal taxAfterOld  = slabTaxOld.subtract(rebateOld).max(BigDecimal.ZERO);
        BigDecimal surOld       = calcSurcharge(taxableOld, taxAfterOld, TaxRegime.old_regime);
        BigDecimal cessOld      = taxAfterOld.add(surOld).multiply(CESS_RATE)
                                    .setScale(2, RoundingMode.HALF_UP);
        BigDecimal totalTaxOld  = taxAfterOld.add(surOld).add(cessOld);

        // Recommendation
        TaxRegime recommended = totalTaxNew.compareTo(totalTaxOld) <= 0
                ? TaxRegime.new_regime : TaxRegime.old_regime;
        BigDecimal saving = totalTaxNew.subtract(totalTaxOld).abs();

        // Preferred regime tax for net payable
        BigDecimal preferredTax = user.getPreferredRegime() == TaxRegime.new_regime
                ? totalTaxNew : totalTaxOld;
        BigDecimal netPayable = preferredTax.subtract(totalTds).subtract(advancePaid);

        TaxEstimate est = TaxEstimate.builder()
                .user(user)
                .financialYear(financialYear)
                .computedAt(OffsetDateTime.now())
                .grossIncome(grossIncome)
                .totalDeductibleExpenses(deductibleExp)
                .netIncome(effectiveIncome)
                .is44adaEligible(is44ada)
                .presumptiveIncome44ada(presumptive)
                // New regime
                .standardDeductionNew(STD_DEDUCTION_NEW)
                .taxableIncomeNew(taxableNew)
                .taxNewRegime(taxAfterNew)
                .surchargeNew(surNew)
                .cessNew(cessNew)
                .totalTaxNew(totalTaxNew)
                // Old regime
                .totalDeductionsOld(totalDeductOld)
                .taxableIncomeOld(taxableOld)
                .taxOldRegime(taxAfterOld)
                .surchargeOld(surOld)
                .cessOld(cessOld)
                .totalTaxOld(totalTaxOld)
                // Recommendation
                .recommendedRegime(recommended)
                .taxSavingBySwitching(saving)
                // Payments
                .totalTdsPaid(totalTds)
                .advanceTaxPaid(advancePaid)
                .netTaxPayable(netPayable)
                .build();

        // Upsert
        taxEstimateRepo.findByUserIdAndFinancialYear(userId, financialYear)
                .ifPresent(existing -> est.setId(existing.getId()));

        return taxEstimateRepo.save(est);
    }

    // ----------------------------------------------------------------
    // Slab tax computation (progressive)
    // ----------------------------------------------------------------
    private BigDecimal calcSlabTax(BigDecimal income, BigDecimal[][] slabs) {
        if (income.compareTo(BigDecimal.ZERO) <= 0) return BigDecimal.ZERO;

        BigDecimal tax = BigDecimal.ZERO;
        for (BigDecimal[] slab : slabs) {
            BigDecimal from = slab[0];
            BigDecimal to   = slab[1];
            BigDecimal rate = slab[2];

            if (income.compareTo(from) < 0) break;

            BigDecimal slabTop  = (to == null) ? income : to;
            BigDecimal taxable  = income.min(slabTop).subtract(from);
            if (taxable.compareTo(BigDecimal.ZERO) > 0) {
                tax = tax.add(taxable.multiply(rate)
                        .divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP));
            }
        }
        return tax.setScale(2, RoundingMode.HALF_UP);
    }

    // ----------------------------------------------------------------
    // Section 87A rebate
    // ----------------------------------------------------------------
    private BigDecimal calcRebate87A(BigDecimal taxableIncome,
                                     BigDecimal baseTax,
                                     TaxRegime regime) {
        BigDecimal limit     = regime == TaxRegime.new_regime
                ? new BigDecimal("25000") : new BigDecimal("12500");
        BigDecimal threshold = regime == TaxRegime.new_regime
                ? new BigDecimal("700000") : new BigDecimal("500000");

        if (taxableIncome.compareTo(threshold) <= 0) {
            return baseTax.min(limit);
        }
        return BigDecimal.ZERO;
    }

    // ----------------------------------------------------------------
    // Surcharge
    // ----------------------------------------------------------------
    private BigDecimal calcSurcharge(BigDecimal income,
                                     BigDecimal tax,
                                     TaxRegime regime) {
        BigDecimal rate;

        if (income.compareTo(new BigDecimal("5000000")) <= 0) {
            rate = BigDecimal.ZERO;
        } else if (income.compareTo(new BigDecimal("10000000")) <= 0) {
            rate = new BigDecimal("10");
        } else if (income.compareTo(new BigDecimal("20000000")) <= 0) {
            rate = new BigDecimal("15");
        } else if (income.compareTo(new BigDecimal("50000000")) <= 0) {
            rate = new BigDecimal("25");
        } else {
            // Old regime: 37%, New regime: capped at 25%
            rate = regime == TaxRegime.old_regime
                    ? new BigDecimal("37") : new BigDecimal("25");
        }

        return tax.multiply(rate)
                .divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);
    }

    // ----------------------------------------------------------------
    // Old regime Chapter VI-A deductions (capped)
    // ----------------------------------------------------------------
    private BigDecimal calcChapterVIaDeductions(UUID userId, String financialYear) {
        return deductionRepo.findByUserIdAndFinancialYear(userId, financialYear)
                .stream()
                .map(d -> {
                    BigDecimal limit = DEDUCTION_LIMITS.get(d.getSection());
                    return (limit != null && d.getAmount().compareTo(limit) > 0)
                            ? limit : d.getAmount();
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    // ----------------------------------------------------------------
    // 44ADA eligibility
    // ----------------------------------------------------------------
    private boolean is44adaEligible(User user, BigDecimal consultingReceipts) {
        boolean eligibleProfession = user.getProfessionType() != null
                && (user.getProfessionType().name().equals("consultant")
                    || user.getProfessionType().name().equals("professional_44ADA"));
        return eligibleProfession
                && consultingReceipts.compareTo(SECTION_44ADA_LIMIT) <= 0;
    }

    // ----------------------------------------------------------------
    // Select correct slab based on user age
    // ----------------------------------------------------------------
    private BigDecimal[][] getOldSlabs(User user) {
        if (Boolean.TRUE.equals(user.getIsSuperSenior())) return OLD_SLABS_SUPER;
        if (Boolean.TRUE.equals(user.getIsSeniorCitizen())) return OLD_SLABS_SENIOR;
        return OLD_SLABS;
    }

    // ----------------------------------------------------------------
    // Map entity to response DTO
    // ----------------------------------------------------------------
    public TaxEstimateResponse toResponse(TaxEstimate e, TaxRegime currentRegime) {
        boolean switchRecommended = e.getRecommendedRegime() != null
                && !e.getRecommendedRegime().equals(currentRegime);

        String switchSummary;
        if (!switchRecommended) {
            switchSummary = "You are already on the optimal regime.";
        } else if (e.getRecommendedRegime() == TaxRegime.new_regime) {
            switchSummary = "Switching to New Regime saves ₹"
                    + e.getTaxSavingBySwitching() + " this year.";
        } else {
            switchSummary = "Switching to Old Regime saves ₹"
                    + e.getTaxSavingBySwitching()
                    + " due to your deductions exceeding the standard benefit.";
        }

        BigDecimal netPayable = e.getNetTaxPayable();
        return TaxEstimateResponse.builder()
                .financialYear(e.getFinancialYear())
                .computedAt(e.getComputedAt())
                .grossIncome(e.getGrossIncome())
                .totalDeductibleExpenses(e.getTotalDeductibleExpenses())
                .netIncome(e.getNetIncome())
                .is44adaEligible(e.getIs44adaEligible())
                .presumptiveIncome44ada(e.getPresumptiveIncome44ada())
                .totalDeductionsOld(e.getTotalDeductionsOld())
                .taxableIncomeOld(e.getTaxableIncomeOld())
                .taxOldRegime(e.getTaxOldRegime())
                .surchargeOld(e.getSurchargeOld())
                .cessOld(e.getCessOld())
                .totalTaxOld(e.getTotalTaxOld())
                .standardDeductionNew(e.getStandardDeductionNew())
                .taxableIncomeNew(e.getTaxableIncomeNew())
                .taxNewRegime(e.getTaxNewRegime())
                .surchargeNew(e.getSurchargeNew())
                .cessNew(e.getCessNew())
                .totalTaxNew(e.getTotalTaxNew())
                .recommendedRegime(e.getRecommendedRegime())
                .currentRegime(currentRegime)
                .taxSavingBySwitching(e.getTaxSavingBySwitching())
                .switchRecommended(switchRecommended)
                .switchSummary(switchSummary)
                .totalTdsPaid(e.getTotalTdsPaid())
                .advanceTaxPaid(e.getAdvanceTaxPaid())
                .netTaxPayable(netPayable)
                .isRefund(netPayable != null && netPayable.compareTo(BigDecimal.ZERO) < 0)
                .build();
    }
}
