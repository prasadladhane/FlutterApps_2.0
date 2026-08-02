package com.taxpilot.service;

import com.taxpilot.config.CacheConfig;
import com.taxpilot.domain.entity.Deduction;
import com.taxpilot.domain.entity.User;
import com.taxpilot.dto.request.DeductionRequest;
import com.taxpilot.dto.response.DeductionResponse;
import com.taxpilot.exception.BadRequestException;
import com.taxpilot.exception.ResourceNotFoundException;
import com.taxpilot.repository.DeductionRepository;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class DeductionService {

    // Section limits for old regime (FY 2024-25) — matches deduction_limits table
    private static final Map<String, BigDecimal> SECTION_LIMITS = new java.util.HashMap<>();
    static {
        SECTION_LIMITS.put("80C",              new BigDecimal("150000"));
        SECTION_LIMITS.put("80CCD1B",          new BigDecimal("50000"));
        SECTION_LIMITS.put("80D",              new BigDecimal("25000"));
        SECTION_LIMITS.put("80TTA",            new BigDecimal("10000"));
        SECTION_LIMITS.put("80TTB",            new BigDecimal("50000"));
        SECTION_LIMITS.put("24B",              new BigDecimal("200000"));
        SECTION_LIMITS.put("standard_deduction", new BigDecimal("75000"));
        // 80E, 80G, HRA, LTA — no fixed cap, null means unlimited
    }

    private final DeductionRepository deductionRepo;
    private final UserService userService;
    private final TaxService taxService;

    public DeductionService(DeductionRepository deductionRepo,
                            UserService userService,
                            TaxService taxService) {
        this.deductionRepo = deductionRepo;
        this.userService   = userService;
        this.taxService    = taxService;
    }

    // ----------------------------------------------------------------
    // Save or update a deduction (upsert by section)
    // ----------------------------------------------------------------
    @CacheEvict(value = {CacheConfig.CACHE_DASHBOARD, CacheConfig.CACHE_TAX_ESTIMATE},
                key = "#userId")
    public DeductionResponse saveDeduction(UUID userId, DeductionRequest req) {
        User user = userService.findById(userId);
        String sectionDb = req.getSection().toDbValue();

        // Validate amount against section limit
        BigDecimal limit  = SECTION_LIMITS.get(sectionDb);
        BigDecimal amount = req.getAmount();
        if (limit != null && amount.compareTo(limit) > 0) {
            throw new BadRequestException(
                "Amount ₹" + amount + " exceeds the maximum limit of ₹" + limit
                + " for section " + sectionDb + ".");
        }

        // Upsert — one entry per section per FY
        Deduction deduction = deductionRepo
                .findByUserIdAndFinancialYearAndSection(
                        userId, req.getFinancialYear(), sectionDb)
                .orElse(Deduction.builder()
                        .user(user)
                        .financialYear(req.getFinancialYear())
                        .section(sectionDb)
                        .build());

        deduction.setAmount(amount);
        deduction.setDescription(req.getDescription());
        deduction.setProofUrl(req.getProofUrl());

        Deduction saved = deductionRepo.save(deduction);
        refreshTaxAsync(userId, req.getFinancialYear());
        return toResponse(saved);
    }

    // ----------------------------------------------------------------
    // Delete a deduction
    // ----------------------------------------------------------------
    @CacheEvict(value = {CacheConfig.CACHE_DASHBOARD, CacheConfig.CACHE_TAX_ESTIMATE},
                key = "#userId")
    public void deleteDeduction(UUID userId, UUID deductionId) {
        Deduction d = deductionRepo.findById(deductionId)
                .orElseThrow(() -> new ResourceNotFoundException("Deduction", deductionId));
        if (!d.getUser().getId().equals(userId)) {
            throw new ResourceNotFoundException("Deduction", deductionId);
        }
        String fy = d.getFinancialYear();
        deductionRepo.delete(d);
        refreshTaxAsync(userId, fy);
    }

    // ----------------------------------------------------------------
    // List all deductions for a FY
    // ----------------------------------------------------------------
    @Transactional(readOnly = true)
    public List<DeductionResponse> listDeductions(UUID userId, String financialYear) {
        return deductionRepo.findByUserIdAndFinancialYear(userId, financialYear)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Async
    public void refreshTaxAsync(UUID userId, String financialYear) {
        taxService.refreshEstimate(userId, financialYear);
    }

    public DeductionResponse toResponse(Deduction d) {
        BigDecimal limit  = SECTION_LIMITS.get(d.getSection());
        BigDecimal capped = (limit != null && d.getAmount().compareTo(limit) > 0)
                ? limit : d.getAmount();

        return DeductionResponse.builder()
                .id(d.getId())
                .financialYear(d.getFinancialYear())
                .section(d.getSection())
                .amount(d.getAmount())
                .cappedAmount(capped)
                .description(d.getDescription())
                .proofUrl(d.getProofUrl())
                .createdAt(d.getCreatedAt())
                .updatedAt(d.getUpdatedAt())
                .build();
    }
}
