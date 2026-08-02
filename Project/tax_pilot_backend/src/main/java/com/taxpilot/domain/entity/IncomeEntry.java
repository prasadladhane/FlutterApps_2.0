package com.taxpilot.domain.entity;

import com.taxpilot.domain.enums.IncomeCategory;
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
@Table(name = "income_entries")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class IncomeEntry {

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

    @Column(name = "entry_date", nullable = false)
    private LocalDate entryDate;

    @Column(name = "amount", nullable = false, precision = 15, scale = 2)
    private BigDecimal amount;

    @Enumerated(EnumType.STRING)
    @Column(name = "category", nullable = false)
    private IncomeCategory category;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "client_name", length = 255)
    private String clientName;

    @Column(name = "invoice_number", length = 100)
    private String invoiceNumber;

    @Column(name = "tds_deducted", nullable = false, precision = 15, scale = 2)
    @Builder.Default
    private BigDecimal tdsDeducted = BigDecimal.ZERO;

    @Column(name = "is_recurring", nullable = false)
    @Builder.Default
    private Boolean isRecurring = false;

    @Column(name = "receipt_url", columnDefinition = "TEXT")
    private String receiptUrl;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private OffsetDateTime updatedAt;
}
