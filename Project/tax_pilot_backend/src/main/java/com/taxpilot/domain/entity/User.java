package com.taxpilot.domain.entity;

import com.taxpilot.domain.enums.ProfessionType;
import com.taxpilot.domain.enums.TaxRegime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "users")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue
    @Type(type = "pg-uuid")
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "firebase_uid", unique = true, nullable = false, length = 128)
    private String firebaseUid;

    @Column(name = "email", unique = true, nullable = false, length = 255)
    private String email;

    @Column(name = "full_name", nullable = false, length = 255)
    private String fullName;

    @Column(name = "pan_number", length = 10)
    private String panNumber;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @Column(name = "phone_number", length = 15)
    private String phoneNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "profession_type", nullable = false)
    private ProfessionType professionType;

    @Enumerated(EnumType.STRING)
    @Column(name = "preferred_regime", nullable = false)
    private TaxRegime preferredRegime;

    @Column(name = "financial_year", nullable = false, length = 9)
    private String financialYear;

    @Column(name = "is_senior_citizen", nullable = false)
    private Boolean isSeniorCitizen;

    @Column(name = "is_super_senior", nullable = false)
    private Boolean isSuperSenior;

    @Column(name = "annual_income_estimate", precision = 15, scale = 2)
    private BigDecimal annualIncomeEstimate;

    @Column(name = "profile_complete", nullable = false)
    private Boolean profileComplete;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private OffsetDateTime updatedAt;
}
