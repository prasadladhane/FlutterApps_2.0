package com.taxpilot.dto.request;

import com.taxpilot.domain.enums.AdvanceTaxInstallment;
import lombok.Data;

import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class AdvanceTaxPaymentRequest {

    @NotNull(message = "Installment is required")
    private AdvanceTaxInstallment installment;

    @NotNull(message = "Amount paid is required")
    @DecimalMin(value = "0.01", message = "Amount must be greater than 0")
    @Digits(integer = 13, fraction = 2)
    private BigDecimal amountPaid;

    @NotNull(message = "Payment date is required")
    @PastOrPresent(message = "Payment date cannot be in the future")
    private LocalDate paidOn;

    @Size(max = 100)
    private String challanNumber;

    @NotBlank(message = "Financial year is required")
    @Pattern(regexp = "\\d{4}-\\d{2}")
    private String financialYear;
}
