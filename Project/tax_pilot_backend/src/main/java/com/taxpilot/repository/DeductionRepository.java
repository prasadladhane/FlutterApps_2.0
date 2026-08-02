package com.taxpilot.repository;

import com.taxpilot.domain.entity.Deduction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface DeductionRepository extends JpaRepository<Deduction, UUID> {

    List<Deduction> findByUserIdAndFinancialYear(UUID userId, String financialYear);

    Optional<Deduction> findByUserIdAndFinancialYearAndSection(
            UUID userId, String financialYear, String section);

    boolean existsByUserIdAndFinancialYearAndSection(
            UUID userId, String financialYear, String section);

    // Total deductions for old regime (capped at limits — cap enforced in service)
    @Query("SELECT COALESCE(SUM(d.amount), 0) FROM Deduction d " +
           "WHERE d.user.id = :userId AND d.financialYear = :fy")
    BigDecimal sumByUserAndFy(@Param("userId") UUID userId, @Param("fy") String financialYear);

    void deleteByUserIdAndId(UUID userId, UUID id);
}
