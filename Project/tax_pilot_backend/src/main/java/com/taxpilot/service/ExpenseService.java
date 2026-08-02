package com.taxpilot.service;

import com.taxpilot.config.CacheConfig;
import com.taxpilot.domain.entity.ExpenseEntry;
import com.taxpilot.domain.entity.User;
import com.taxpilot.dto.request.ExpenseRequest;
import com.taxpilot.dto.response.ExpenseResponse;
import com.taxpilot.dto.response.PageResponse;
import com.taxpilot.exception.ResourceNotFoundException;
import com.taxpilot.repository.ExpenseEntryRepository;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@Transactional
public class ExpenseService {

    private final ExpenseEntryRepository expenseRepo;
    private final UserService userService;
    private final TaxService taxService;

    public ExpenseService(ExpenseEntryRepository expenseRepo,
                          UserService userService,
                          TaxService taxService) {
        this.expenseRepo = expenseRepo;
        this.userService = userService;
        this.taxService  = taxService;
    }

    @CacheEvict(value = {CacheConfig.CACHE_DASHBOARD, CacheConfig.CACHE_TAX_ESTIMATE},
                key = "#userId")
    public ExpenseResponse addExpense(UUID userId, ExpenseRequest req) {
        User user = userService.findById(userId);

        ExpenseEntry entry = ExpenseEntry.builder()
                .user(user)
                .financialYear(req.getFinancialYear())
                .entryDate(req.getEntryDate())
                .amount(req.getAmount())
                .category(req.getCategory())
                .description(req.getDescription())
                .isTaxDeductible(req.getIsTaxDeductible())
                .vendorName(req.getVendorName())
                .receiptUrl(req.getReceiptUrl())
                .build();

        ExpenseEntry saved = expenseRepo.save(entry);
        refreshTaxAsync(userId, req.getFinancialYear());
        return toResponse(saved);
    }

    @CacheEvict(value = {CacheConfig.CACHE_DASHBOARD, CacheConfig.CACHE_TAX_ESTIMATE},
                key = "#userId")
    public ExpenseResponse updateExpense(UUID userId, UUID entryId, ExpenseRequest req) {
        ExpenseEntry entry = findEntry(userId, entryId);

        entry.setEntryDate(req.getEntryDate());
        entry.setAmount(req.getAmount());
        entry.setCategory(req.getCategory());
        entry.setDescription(req.getDescription());
        entry.setIsTaxDeductible(req.getIsTaxDeductible());
        entry.setVendorName(req.getVendorName());
        entry.setReceiptUrl(req.getReceiptUrl());

        ExpenseEntry saved = expenseRepo.save(entry);
        refreshTaxAsync(userId, req.getFinancialYear());
        return toResponse(saved);
    }

    @CacheEvict(value = {CacheConfig.CACHE_DASHBOARD, CacheConfig.CACHE_TAX_ESTIMATE},
                key = "#userId")
    public void deleteExpense(UUID userId, UUID entryId) {
        ExpenseEntry entry = findEntry(userId, entryId);
        String fy = entry.getFinancialYear();
        expenseRepo.delete(entry);
        refreshTaxAsync(userId, fy);
    }

    @Transactional(readOnly = true)
    public PageResponse<ExpenseResponse> listExpenses(UUID userId,
                                                       String financialYear,
                                                       Pageable pageable) {
        Page<ExpenseEntry> page = expenseRepo
                .findByUserIdAndFinancialYearOrderByEntryDateDesc(
                        userId, financialYear, pageable);
        return PageResponse.from(page.map(this::toResponse));
    }

    @Transactional(readOnly = true)
    public ExpenseResponse getExpense(UUID userId, UUID entryId) {
        return toResponse(findEntry(userId, entryId));
    }

    private ExpenseEntry findEntry(UUID userId, UUID entryId) {
        ExpenseEntry entry = expenseRepo.findById(entryId)
                .orElseThrow(() -> new ResourceNotFoundException("Expense entry", entryId));
        if (!entry.getUser().getId().equals(userId)) {
            throw new ResourceNotFoundException("Expense entry", entryId);
        }
        return entry;
    }

    @Async
    public void refreshTaxAsync(UUID userId, String financialYear) {
        taxService.refreshEstimate(userId, financialYear);
    }

    public ExpenseResponse toResponse(ExpenseEntry e) {
        return ExpenseResponse.builder()
                .id(e.getId())
                .financialYear(e.getFinancialYear())
                .entryDate(e.getEntryDate())
                .amount(e.getAmount())
                .category(e.getCategory())
                .description(e.getDescription())
                .isTaxDeductible(e.getIsTaxDeductible())
                .vendorName(e.getVendorName())
                .receiptUrl(e.getReceiptUrl())
                .createdAt(e.getCreatedAt())
                .updatedAt(e.getUpdatedAt())
                .build();
    }
}
