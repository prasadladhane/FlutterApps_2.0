package com.taxpilot.dto.response;

import com.taxpilot.domain.enums.AdvanceTaxInstallment;
import com.taxpilot.domain.enums.PaymentStatus;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

@Data
@Builder
public class AdvanceTaxResponse {
    private UUID id;
    private String financialYear;
    private AdvanceTaxInstallment installment;
    private LocalDate dueDate;
    private Short cumulativePercent;
    private BigDecimal estimatedAmount;
    private BigDecimal amountPaid;
    private BigDecimal balanceDue;
    private PaymentStatus status;
    private LocalDate paidOn;
    private String challanNumber;
    private long daysUntilDue;  // negative = overdue
}
