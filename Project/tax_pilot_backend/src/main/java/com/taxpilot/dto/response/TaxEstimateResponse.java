package com.taxpilot.dto.response;

import com.taxpilot.domain.enums.TaxRegime;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.OffsetDateTime;

@Data
@Builder
public class TaxEstimateResponse {
    private String financialYear;
    private OffsetDateTime computedAt;

    // Income
    private BigDecimal grossIncome;
    private BigDecimal totalDeductibleExpenses;
    private BigDecimal netIncome;

    // 44ADA
    private Boolean is44adaEligible;
    private BigDecimal presumptiveIncome44ada;
    private BigDecimal qualifyingReceipts44ada;

    // Old regime
    private BigDecimal totalDeductionsOld;
    private BigDecimal taxableIncomeOld;
    private BigDecimal taxOldRegime;
    private BigDecimal surchargeOld;
    private BigDecimal cessOld;
    private BigDecimal totalTaxOld;

    // New regime
    private BigDecimal standardDeductionNew;
    private BigDecimal taxableIncomeNew;
    private BigDecimal taxNewRegime;
    private BigDecimal surchargeNew;
    private BigDecimal cessNew;
    private BigDecimal totalTaxNew;

    // Recommendation
    private TaxRegime recommendedRegime;
    private TaxRegime currentRegime;
    private BigDecimal taxSavingBySwitching;
    private Boolean switchRecommended;
    private String switchSummary;

    // Payments
    private BigDecimal totalTdsPaid;
    private BigDecimal advanceTaxPaid;
    private BigDecimal netTaxPayable;   // negative = refund
    private Boolean isRefund;
}
