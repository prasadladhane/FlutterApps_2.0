package com.taxpilot.repository;

import com.taxpilot.domain.entity.Report;
import com.taxpilot.domain.enums.ReportType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ReportRepository extends JpaRepository<Report, UUID> {

    Page<Report> findByUserIdAndFinancialYearOrderByGeneratedAtDesc(
            UUID userId, String financialYear, Pageable pageable);

    List<Report> findByUserIdAndIsFavoriteTrueOrderByGeneratedAtDesc(UUID userId);

    Optional<Report> findByIdAndUserId(UUID id, UUID userId);

    // Toggle favorite
    @Modifying
    @Query("UPDATE Report r SET r.isFavorite = :fav WHERE r.id = :id AND r.user.id = :userId")
    int toggleFavorite(@Param("id") UUID id, @Param("userId") UUID userId, @Param("fav") boolean fav);

    // Latest report of a given type for a user/FY
    @Query("SELECT r FROM Report r WHERE r.user.id = :userId " +
           "AND r.financialYear = :fy AND r.reportType = :type " +
           "ORDER BY r.generatedAt DESC")
    Page<Report> findLatestByType(
            @Param("userId") UUID userId,
            @Param("fy") String financialYear,
            @Param("type") ReportType type,
            Pageable pageable);
}
