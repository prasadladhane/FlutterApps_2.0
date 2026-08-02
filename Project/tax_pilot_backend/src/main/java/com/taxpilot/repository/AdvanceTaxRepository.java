package com.taxpilot.repository;

import com.taxpilot.domain.entity.AdvanceTaxSchedule;
import com.taxpilot.domain.enums.AdvanceTaxInstallment;
import com.taxpilot.domain.enums.PaymentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface AdvanceTaxRepository extends JpaRepository<AdvanceTaxSchedule, UUID> {

    List<AdvanceTaxSchedule> findByUserIdAndFinancialYearOrderByDueDate(
            UUID userId, String financialYear);

    Optional<AdvanceTaxSchedule> findByUserIdAndFinancialYearAndInstallment(
            UUID userId, String financialYear, AdvanceTaxInstallment installment);

    // Next unpaid installment
    @Query("SELECT a FROM AdvanceTaxSchedule a " +
           "WHERE a.user.id = :userId AND a.financialYear = :fy " +
           "AND a.status IN ('pending', 'overdue') ORDER BY a.dueDate ASC")
    List<AdvanceTaxSchedule> findPendingByUserAndFy(
            @Param("userId") UUID userId, @Param("fy") String financialYear);

    // Total advance tax paid
    @Query("SELECT COALESCE(SUM(a.amountPaid), 0) FROM AdvanceTaxSchedule a " +
           "WHERE a.user.id = :userId AND a.financialYear = :fy")
    BigDecimal sumPaidByUserAndFy(@Param("userId") UUID userId, @Param("fy") String financialYear);

    // Overdue installments across all users — used by scheduler
    @Query("SELECT a FROM AdvanceTaxSchedule a " +
           "WHERE a.status = 'pending' AND a.dueDate < :today")
    List<AdvanceTaxSchedule> findNewlyOverdue(@Param("today") LocalDate today);

    // Upcoming installments within N days — used for reminder notifications
    @Query("SELECT a FROM AdvanceTaxSchedule a " +
           "WHERE a.status = 'pending' " +
           "AND a.dueDate BETWEEN :today AND :upToDate")
    List<AdvanceTaxSchedule> findUpcoming(
            @Param("today") LocalDate today,
            @Param("upToDate") LocalDate upToDate);
}
