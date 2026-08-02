package com.taxpilot.repository;

import com.taxpilot.domain.entity.ExpenseEntry;
import com.taxpilot.domain.enums.ExpenseCategory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Repository
public interface ExpenseEntryRepository extends JpaRepository<ExpenseEntry, UUID> {

    Page<ExpenseEntry> findByUserIdAndFinancialYearOrderByEntryDateDesc(
            UUID userId, String financialYear, Pageable pageable);

    List<ExpenseEntry> findByUserIdAndFinancialYear(UUID userId, String financialYear);

    // Total deductible expenses for FY
    @Query("SELECT COALESCE(SUM(e.amount), 0) FROM ExpenseEntry e " +
           "WHERE e.user.id = :userId AND e.financialYear = :fy " +
           "AND e.isTaxDeductible = true")
    BigDecimal sumDeductibleByUserAndFy(@Param("userId") UUID userId, @Param("fy") String financialYear);

    // Total all expenses (for reporting)
    @Query("SELECT COALESCE(SUM(e.amount), 0) FROM ExpenseEntry e " +
           "WHERE e.user.id = :userId AND e.financialYear = :fy")
    BigDecimal sumAllByUserAndFy(@Param("userId") UUID userId, @Param("fy") String financialYear);

    // By category
    Page<ExpenseEntry> findByUserIdAndFinancialYearAndCategoryOrderByEntryDateDesc(
            UUID userId, String financialYear, ExpenseCategory category, Pageable pageable);

    // Category-wise breakdown for reports
    @Query("SELECT e.category, COALESCE(SUM(e.amount), 0) FROM ExpenseEntry e " +
           "WHERE e.user.id = :userId AND e.financialYear = :fy " +
           "GROUP BY e.category ORDER BY SUM(e.amount) DESC")
    List<Object[]> getCategoryBreakdown(@Param("userId") UUID userId, @Param("fy") String financialYear);

    void deleteByUserIdAndId(UUID userId, UUID id);
}
