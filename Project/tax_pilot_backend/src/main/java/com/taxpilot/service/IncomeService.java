package com.taxpilot.service;

import com.taxpilot.config.CacheConfig;
import com.taxpilot.domain.entity.IncomeEntry;
import com.taxpilot.domain.entity.User;
import com.taxpilot.dto.request.IncomeRequest;
import com.taxpilot.dto.response.IncomeResponse;
import com.taxpilot.dto.response.PageResponse;
import com.taxpilot.exception.ResourceNotFoundException;
import com.taxpilot.repository.IncomeEntryRepository;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@Transactional
public class IncomeService {

    private final IncomeEntryRepository incomeRepo;
    private final UserService userService;
    private final TaxService taxService;

    public IncomeService(IncomeEntryRepository incomeRepo,
                         UserService userService,
                         TaxService taxService) {
        this.incomeRepo  = incomeRepo;
        this.userService = userService;
        this.taxService  = taxService;
    }

    // ----------------------------------------------------------------
    // Add income entry
    // ----------------------------------------------------------------
    @CacheEvict(value = {CacheConfig.CACHE_DASHBOARD, CacheConfig.CACHE_TAX_ESTIMATE},
                key = "#userId")
    public IncomeResponse addIncome(UUID userId, IncomeRequest req) {
        User user = userService.findById(userId);

        IncomeEntry entry = IncomeEntry.builder()
                .user(user)
                .financialYear(req.getFinancialYear())
                .entryDate(req.getEntryDate())
                .amount(req.getAmount())
                .category(req.getCategory())
                .description(req.getDescription())
                .clientName(req.getClientName())
                .invoiceNumber(req.getInvoiceNumber())
                .tdsDeducted(req.getTdsDeducted())
                .isRecurring(req.getIsRecurring())
                .receiptUrl(req.getReceiptUrl())
                .build();

        IncomeEntry saved = incomeRepo.save(entry);

        // Recalculate tax estimate asynchronously — don't block the response
        refreshTaxAsync(userId, req.getFinancialYear());

        return toResponse(saved);
    }

    // ----------------------------------------------------------------
    // Update income entry
    // ----------------------------------------------------------------
    @CacheEvict(value = {CacheConfig.CACHE_DASHBOARD, CacheConfig.CACHE_TAX_ESTIMATE},
                key = "#userId")
    public IncomeResponse updateIncome(UUID userId, UUID entryId, IncomeRequest req) {
        IncomeEntry entry = findEntry(userId, entryId);

        entry.setEntryDate(req.getEntryDate());
        entry.setAmount(req.getAmount());
        entry.setCategory(req.getCategory());
        entry.setDescription(req.getDescription());
        entry.setClientName(req.getClientName());
        entry.setInvoiceNumber(req.getInvoiceNumber());
        entry.setTdsDeducted(req.getTdsDeducted());
        entry.setIsRecurring(req.getIsRecurring());
        entry.setReceiptUrl(req.getReceiptUrl());

        IncomeEntry saved = incomeRepo.save(entry);
        refreshTaxAsync(userId, req.getFinancialYear());
        return toResponse(saved);
    }

    // ----------------------------------------------------------------
    // Delete income entry
    // ----------------------------------------------------------------
    @CacheEvict(value = {CacheConfig.CACHE_DASHBOARD, CacheConfig.CACHE_TAX_ESTIMATE},
                key = "#userId")
    public void deleteIncome(UUID userId, UUID entryId) {
        IncomeEntry entry = findEntry(userId, entryId);
        String fy = entry.getFinancialYear();
        incomeRepo.delete(entry);
        refreshTaxAsync(userId, fy);
    }

    // ----------------------------------------------------------------
    // List income entries (paginated)
    // ----------------------------------------------------------------
    @Transactional(readOnly = true)
    public PageResponse<IncomeResponse> listIncome(UUID userId,
                                                    String financialYear,
                                                    Pageable pageable) {
        Page<IncomeEntry> page = incomeRepo
                .findByUserIdAndFinancialYearOrderByEntryDateDesc(
                        userId, financialYear, pageable);
        return PageResponse.from(page.map(this::toResponse));
    }

    // ----------------------------------------------------------------
    // Get single income entry
    // ----------------------------------------------------------------
    @Transactional(readOnly = true)
    public IncomeResponse getIncome(UUID userId, UUID entryId) {
        return toResponse(findEntry(userId, entryId));
    }

    // ----------------------------------------------------------------
    // Internal helpers
    // ----------------------------------------------------------------
    private IncomeEntry findEntry(UUID userId, UUID entryId) {
        IncomeEntry entry = incomeRepo.findById(entryId)
                .orElseThrow(() -> new ResourceNotFoundException("Income entry", entryId));
        if (!entry.getUser().getId().equals(userId)) {
            throw new ResourceNotFoundException("Income entry", entryId);
        }
        return entry;
    }

    @Async
    public void refreshTaxAsync(UUID userId, String financialYear) {
        try {
            taxService.refreshEstimate(userId, financialYear);
        } catch (Exception e) {
            // Log handled by AsyncConfig uncaught exception handler
            throw e;
        }
    }

    public IncomeResponse toResponse(IncomeEntry e) {
        return IncomeResponse.builder()
                .id(e.getId())
                .financialYear(e.getFinancialYear())
                .entryDate(e.getEntryDate())
                .amount(e.getAmount())
                .category(e.getCategory())
                .description(e.getDescription())
                .clientName(e.getClientName())
                .invoiceNumber(e.getInvoiceNumber())
                .tdsDeducted(e.getTdsDeducted())
                .isRecurring(e.getIsRecurring())
                .receiptUrl(e.getReceiptUrl())
                .createdAt(e.getCreatedAt())
                .updatedAt(e.getUpdatedAt())
                .build();
    }
}
