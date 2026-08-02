package com.taxpilot.dto.response;

import com.taxpilot.domain.enums.ExpenseCategory;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@Builder
public class ExpenseResponse {
    private UUID id;
    private String financialYear;
    private LocalDate entryDate;
    private BigDecimal amount;
    private ExpenseCategory category;
    private String description;
    private Boolean isTaxDeductible;
    private String vendorName;
    private String receiptUrl;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
}
