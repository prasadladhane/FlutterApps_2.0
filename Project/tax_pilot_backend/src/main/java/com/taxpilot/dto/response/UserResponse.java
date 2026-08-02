package com.taxpilot.dto.response;

import com.taxpilot.domain.enums.ProfessionType;
import com.taxpilot.domain.enums.TaxRegime;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@Builder
public class UserResponse {
    private UUID id;
    private String email;
    private String fullName;
    private String panNumber;       // masked: ABCDE****F
    private LocalDate dateOfBirth;
    private String phoneNumber;
    private ProfessionType professionType;
    private TaxRegime preferredRegime;
    private String financialYear;
    private Boolean isSeniorCitizen;
    private Boolean isSuperSenior;
    private BigDecimal annualIncomeEstimate;
    private Boolean profileComplete;
    private OffsetDateTime createdAt;
}
