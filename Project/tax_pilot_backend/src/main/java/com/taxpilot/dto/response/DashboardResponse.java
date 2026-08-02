package com.taxpilot.dto.response;

import com.taxpilot.domain.enums.AdvanceTaxInstallment;
import com.taxpilot.domain.enums.TaxRegime;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
@Builder
public class DashboardResponse {

    // User summary
    private String fullName;
    private String financialYear;
    private TaxRegime preferredRegime;

    // Income snapshot
    private BigDecimal grossIncome;
    private BigDecimal totalTdsDeducted;
    private BigDecimal advanceTaxPaid;

    // Tax snapshot
    private BigDecimal estimatedTax;      // under preferred regime
    private BigDecimal netTaxPayable;     // negative = refund
    private Boolean isRefund;

    // Regime recommendation
    private TaxRegime recommendedRegime;
    private BigDecimal savingBySwitching;
    private Boolean switchRecommended;

    // 44ADA
    private Boolean is44adaEligible;
    private BigDecimal presumptiveIncome;

    // Next advance tax installment
    private AdvanceTaxInstallment nextInstallment;
    private LocalDate nextDueDate;
    private BigDecimal nextInstallmentAmount;
    private Long daysUntilDue;  // negative = overdue

    // Unread notifications count
    private Long unreadNotifications;

    // Monthly income chart data
    private List<MonthlyData> monthlyIncome;

    @Data
    @Builder
    public static class MonthlyData {
        private String monthLabel;   // "Apr 2024"
        private BigDecimal income;
        private BigDecimal tds;
    }
}
