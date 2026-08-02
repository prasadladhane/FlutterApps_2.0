package com.taxpilot.repository;

import com.taxpilot.domain.entity.IncomeEntry;
import com.taxpilot.domain.enums.IncomeCategory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Repository
public interface IncomeEntryRepository extends JpaRepository<IncomeEntry, UUID> {

    // Paginated list for a user + FY — main listing endpoint
    Page<IncomeEntry> findByUserIdAndFinancialYearOrderByEntryDateDesc(
            UUID userId, String financialYear, Pageable pageable);

    // All entries for FY — used in tax computation
    List<IncomeEntry> findByUserIdAndFinancialYear(UUID userId, String financialYear);

    // Total gross income for FY
    @Query("SELECT COALESCE(SUM(i.amount), 0) FROM IncomeEntry i " +
           "WHERE i.user.id = :userId AND i.financialYear = :fy")
    BigDecimal sumAmountByUserAndFy(@Param("userId") UUID userId, @Param("fy") String financialYear);

    // Total TDS for FY
    @Query("SELECT COALESCE(SUM(i.tdsDeducted), 0) FROM IncomeEntry i " +
           "WHERE i.user.id = :userId AND i.financialYear = :fy")
    BigDecimal sumTdsByUserAndFy(@Param("userId") UUID userId, @Param("fy") String financialYear);

    // Consulting/freelance receipts only — for 44ADA check
    @Query("SELECT COALESCE(SUM(i.amount), 0) FROM IncomeEntry i " +
           "WHERE i.user.id = :userId AND i.financialYear = :fy " +
           "AND i.category IN ('consulting', 'freelance')")
    BigDecimal sumConsultingReceiptsByUserAndFy(
            @Param("userId") UUID userId, @Param("fy") String financialYear);

    // Monthly breakdown for dashboard chart
    @Query("SELECT FUNCTION('TO_CHAR', i.entryDate, 'Mon YYYY') AS monthLabel, " +
           "MONTH(i.entryDate) AS monthNum, " +
           "SUM(i.amount) AS totalIncome, SUM(i.tdsDeducted) AS totalTds " +
           "FROM IncomeEntry i " +
           "WHERE i.user.id = :userId AND i.financialYear = :fy " +
           "GROUP BY FUNCTION('TO_CHAR', i.entryDate, 'Mon YYYY'), MONTH(i.entryDate) " +
           "ORDER BY MIN(i.entryDate)")
    List<Object[]> getMonthlyBreakdown(@Param("userId") UUID userId, @Param("fy") String financialYear);

    // Filter by category
    Page<IncomeEntry> findByUserIdAndFinancialYearAndCategoryOrderByEntryDateDesc(
            UUID userId, String financialYear, IncomeCategory category, Pageable pageable);

    // Filter by date range
    @Query("SELECT i FROM IncomeEntry i WHERE i.user.id = :userId " +
           "AND i.financialYear = :fy " +
           "AND i.entryDate BETWEEN :from AND :to ORDER BY i.entryDate DESC")
    Page<IncomeEntry> findByUserFyAndDateRange(
            @Param("userId") UUID userId,
            @Param("fy") String financialYear,
            @Param("from") LocalDate from,
            @Param("to") LocalDate to,
            Pageable pageable);

    void deleteByUserIdAndId(UUID userId, UUID id);
}
