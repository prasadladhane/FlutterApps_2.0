package com.taxpilot.dto.request;

import com.taxpilot.domain.enums.ProfessionType;
import com.taxpilot.domain.enums.TaxRegime;
import lombok.Data;

import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class UpdateProfileRequest {

    @Size(min = 2, max = 255)
    private String fullName;

    @Pattern(regexp = "[A-Z]{5}[0-9]{4}[A-Z]{1}", message = "Invalid PAN format")
    private String panNumber;

    private LocalDate dateOfBirth;

    @Pattern(regexp = "^[6-9]\\d{9}$", message = "Invalid Indian phone number")
    private String phoneNumber;

    private ProfessionType professionType;

    private TaxRegime preferredRegime;

    @DecimalMin(value = "0")
    private BigDecimal annualIncomeEstimate;
}
