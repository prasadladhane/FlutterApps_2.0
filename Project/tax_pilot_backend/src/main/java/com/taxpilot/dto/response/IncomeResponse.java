package com.taxpilot.dto.response;

import com.taxpilot.domain.enums.IncomeCategory;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@Builder
public class IncomeResponse {
    private UUID id;
    private String financialYear;
    private LocalDate entryDate;
    private BigDecimal amount;
    private IncomeCategory category;
    private String description;
    private String clientName;
    private String invoiceNumber;
    private BigDecimal tdsDeducted;
    private Boolean isRecurring;
    private String receiptUrl;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
}
