package com.taxpilot.domain.entity;

import com.taxpilot.domain.enums.DeductionSection;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "deductions",
        uniqueConstraints = @UniqueConstraint(
                columnNames = {"user_id", "financial_year", "section"}))
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Deduction {

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

    // Custom string mapping because DB stores '80C', Java enum uses _80C
    @Column(name = "section", nullable = false)
    private String section;

    @Column(name = "amount", nullable = false, precision = 15, scale = 2)
    private BigDecimal amount;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "proof_url", columnDefinition = "TEXT")
    private String proofUrl;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private OffsetDateTime updatedAt;

    // Convenience methods for enum conversion
    @Transient
    public DeductionSection getSectionEnum() {
        return DeductionSection.fromDbValue(this.section);
    }

    public void setSectionEnum(DeductionSection sectionEnum) {
        this.section = sectionEnum.toDbValue();
    }
}
