package com.taxpilot.dto.request;

import com.taxpilot.domain.enums.DeductionSection;
import lombok.Data;

import javax.validation.constraints.*;
import java.math.BigDecimal;

@Data
public class DeductionRequest {

    @NotNull(message = "Section is required")
    private DeductionSection section;

    @NotNull(message = "Amount is required")
    @DecimalMin(value = "0", message = "Amount cannot be negative")
    @Digits(integer = 13, fraction = 2)
    private BigDecimal amount;

    @Size(max = 1000)
    private String description;

    private String proofUrl;

    @NotBlank(message = "Financial year is required")
    @Pattern(regexp = "\\d{4}-\\d{2}")
    private String financialYear;
}
