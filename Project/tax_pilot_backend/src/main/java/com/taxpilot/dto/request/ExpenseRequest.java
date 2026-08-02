package com.taxpilot.dto.request;

import com.taxpilot.domain.enums.ExpenseCategory;
import lombok.Data;

import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ExpenseRequest {

    @NotNull(message = "Entry date is required")
    @PastOrPresent(message = "Entry date cannot be in the future")
    private LocalDate entryDate;

    @NotNull(message = "Amount is required")
    @DecimalMin(value = "0.01", message = "Amount must be greater than 0")
    @Digits(integer = 13, fraction = 2)
    private BigDecimal amount;

    @NotNull(message = "Category is required")
    private ExpenseCategory category;

    @Size(max = 1000)
    private String description;

    private Boolean isTaxDeductible = true;

    @Size(max = 255)
    private String vendorName;

    private String receiptUrl;

    @NotBlank(message = "Financial year is required")
    @Pattern(regexp = "\\d{4}-\\d{2}")
    private String financialYear;
}
