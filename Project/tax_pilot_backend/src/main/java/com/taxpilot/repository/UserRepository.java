package com.taxpilot.repository;

import com.taxpilot.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {

    Optional<User> findByFirebaseUid(String firebaseUid);

    Optional<User> findByEmail(String email);

    boolean existsByFirebaseUid(String firebaseUid);

    boolean existsByEmail(String email);

    // Fetch user with existence check — used in auth filter
    @Query("SELECT u FROM User u WHERE u.firebaseUid = :uid AND u.profileComplete = true")
    Optional<User> findActiveByFirebaseUid(@Param("uid") String firebaseUid);
}
