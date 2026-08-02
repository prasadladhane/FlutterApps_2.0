package com.taxpilot.dto.response;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@Builder
public class DeductionResponse {
    private UUID id;
    private String financialYear;
    private String section;       // e.g. "80C", "80D"
    private BigDecimal amount;
    private BigDecimal cappedAmount;  // after applying section limit
    private String description;
    private String proofUrl;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
}
