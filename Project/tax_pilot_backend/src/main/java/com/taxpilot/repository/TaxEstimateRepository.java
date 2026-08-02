package com.taxpilot.repository;

import com.taxpilot.domain.entity.TaxEstimate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface TaxEstimateRepository extends JpaRepository<TaxEstimate, UUID> {

    Optional<TaxEstimate> findByUserIdAndFinancialYear(UUID userId, String financialYear);

    boolean existsByUserIdAndFinancialYear(UUID userId, String financialYear);

    // Wipe and recompute — called by TaxService after data changes
    @Modifying
    @Query("DELETE FROM TaxEstimate t WHERE t.user.id = :userId AND t.financialYear = :fy")
    void deleteByUserIdAndFinancialYear(@Param("userId") UUID userId, @Param("fy") String financialYear);

    // Call the PostgreSQL stored function directly for compute
    // (native query — bypasses JPA overhead for complex tax logic)
    @Query(value = "SELECT * FROM compute_tax_for_user(:userId::uuid, :fy) WHERE regime = :regime",
           nativeQuery = true)
    Object[] computeForRegime(
            @Param("userId") String userId,
            @Param("fy") String financialYear,
            @Param("regime") String regime);
}
