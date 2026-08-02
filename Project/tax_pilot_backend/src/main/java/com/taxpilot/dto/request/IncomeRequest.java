package com.taxpilot.dto.request;

import com.taxpilot.domain.enums.IncomeCategory;
import lombok.Data;

import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class IncomeRequest {

    @NotNull(message = "Entry date is required")
    @PastOrPresent(message = "Entry date cannot be in the future")
    private LocalDate entryDate;

    @NotNull(message = "Amount is required")
    @DecimalMin(value = "0.01", message = "Amount must be greater than 0")
    @Digits(integer = 13, fraction = 2, message = "Invalid amount format")
    private BigDecimal amount;

    @NotNull(message = "Category is required")
    private IncomeCategory category;

    @Size(max = 1000, message = "Description too long")
    private String description;

    @Size(max = 255)
    private String clientName;

    @Size(max = 100)
    private String invoiceNumber;

    @DecimalMin(value = "0", message = "TDS cannot be negative")
    @Digits(integer = 13, fraction = 2)
    private BigDecimal tdsDeducted = BigDecimal.ZERO;

    private Boolean isRecurring = false;

    private String receiptUrl;

    @NotBlank(message = "Financial year is required")
    @Pattern(regexp = "\\d{4}-\\d{2}")
    private String financialYear;
}
