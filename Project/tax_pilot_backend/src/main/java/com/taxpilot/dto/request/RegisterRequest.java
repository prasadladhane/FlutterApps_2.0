package com.taxpilot.dto.request;

import com.taxpilot.domain.enums.ProfessionType;
import com.taxpilot.domain.enums.TaxRegime;
import lombok.Data;

import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class RegisterRequest {

    @NotBlank(message = "Firebase UID is required")
    private String firebaseUid;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;

    @NotBlank(message = "Full name is required")
    @Size(min = 2, max = 255, message = "Name must be between 2 and 255 characters")
    private String fullName;

    @Pattern(regexp = "[A-Z]{5}[0-9]{4}[A-Z]{1}", message = "Invalid PAN format")
    private String panNumber;

    private LocalDate dateOfBirth;

    @Pattern(regexp = "^[6-9]\\d{9}$", message = "Invalid Indian phone number")
    private String phoneNumber;

    @NotNull(message = "Profession type is required")
    private ProfessionType professionType;

    @NotNull(message = "Preferred regime is required")
    private TaxRegime preferredRegime;

    @NotBlank(message = "Financial year is required")
    @Pattern(regexp = "\\d{4}-\\d{2}", message = "Financial year must be in format YYYY-YY, e.g. 2024-25")
    private String financialYear;

    @DecimalMin(value = "0", message = "Income estimate cannot be negative")
    private BigDecimal annualIncomeEstimate;
}
