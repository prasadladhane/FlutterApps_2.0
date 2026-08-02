package com.taxpilot.domain.entity;

import com.taxpilot.domain.enums.TaxRegime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "tax_estimates",
        uniqueConstraints = @UniqueConstraint(
                columnNames = {"user_id", "financial_year"}))
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TaxEstimate {

    @Id
    @GeneratedValue
    @Type(type = "pg-uuid")
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "financial_year", nullable = false, length = 9)
    private String financialYear;

    @Column(name = "computed_at", nullable = false)
    private OffsetDateTime computedAt;

    // Gross figures
    @Column(name = "gross_income", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal grossIncome = BigDecimal.ZERO;

    @Column(name = "total_deductible_expenses", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal totalDeductibleExpenses = BigDecimal.ZERO;

    @Column(name = "net_income", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal netIncome = BigDecimal.ZERO;

    // 44ADA
    @Column(name = "is_44ada_eligible", nullable = false)
    @Builder.Default private Boolean is44adaEligible = false;

    @Column(name = "presumptive_income_44ada", precision = 15, scale = 2)
    private BigDecimal presumptiveIncome44ada;

    // Old regime
    @Column(name = "total_deductions_old", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal totalDeductionsOld = BigDecimal.ZERO;

    @Column(name = "taxable_income_old", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal taxableIncomeOld = BigDecimal.ZERO;

    @Column(name = "tax_old_regime", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal taxOldRegime = BigDecimal.ZERO;

    @Column(name = "surcharge_old", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal surchargeOld = BigDecimal.ZERO;

    @Column(name = "cess_old", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal cessOld = BigDecimal.ZERO;

    @Column(name = "total_tax_old", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal totalTaxOld = BigDecimal.ZERO;

    // New regime
    @Column(name = "standard_deduction_new", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal standardDeductionNew = new BigDecimal("75000");

    @Column(name = "taxable_income_new", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal taxableIncomeNew = BigDecimal.ZERO;

    @Column(name = "tax_new_regime", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal taxNewRegime = BigDecimal.ZERO;

    @Column(name = "surcharge_new", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal surchargeNew = BigDecimal.ZERO;

    @Column(name = "cess_new", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal cessNew = BigDecimal.ZERO;

    @Column(name = "total_tax_new", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal totalTaxNew = BigDecimal.ZERO;

    // Recommendation
    @Enumerated(EnumType.STRING)
    @Column(name = "recommended_regime")
    private TaxRegime recommendedRegime;

    @Column(name = "tax_saving_by_switching", precision = 15, scale = 2)
    private BigDecimal taxSavingBySwitching;

    // Payments
    @Column(name = "total_tds_paid", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal totalTdsPaid = BigDecimal.ZERO;

    @Column(name = "advance_tax_paid", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal advanceTaxPaid = BigDecimal.ZERO;

    @Column(name = "net_tax_payable", nullable = false, precision = 15, scale = 2)
    @Builder.Default private BigDecimal netTaxPayable = BigDecimal.ZERO;
}
