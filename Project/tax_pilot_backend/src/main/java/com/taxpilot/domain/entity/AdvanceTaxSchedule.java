package com.taxpilot.domain.entity;

import com.taxpilot.domain.enums.AdvanceTaxInstallment;
import com.taxpilot.domain.enums.PaymentStatus;
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
@Table(name = "advance_tax_schedule",
        uniqueConstraints = @UniqueConstraint(
                columnNames = {"user_id", "financial_year", "installment"}))
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdvanceTaxSchedule {

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

    @Enumerated(EnumType.STRING)
    @Column(name = "installment", nullable = false)
    private AdvanceTaxInstallment installment;

    @Column(name = "due_date", nullable = false)
    private LocalDate dueDate;

    @Column(name = "cumulative_percent", nullable = false)
    private Short cumulativePercent;

    @Column(name = "estimated_amount", nullable = false, precision = 15, scale = 2)
    @Builder.Default
    private BigDecimal estimatedAmount = BigDecimal.ZERO;

    @Column(name = "amount_paid", nullable = false, precision = 15, scale = 2)
    @Builder.Default
    private BigDecimal amountPaid = BigDecimal.ZERO;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    @Builder.Default
    private PaymentStatus status = PaymentStatus.pending;

    @Column(name = "paid_on")
    private LocalDate paidOn;

    @Column(name = "challan_number", length = 100)
    private String challanNumber;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private OffsetDateTime updatedAt;
}
