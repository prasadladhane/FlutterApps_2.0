package com.taxpilot.repository;

import com.taxpilot.domain.entity.Notification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, UUID> {

    // Paginated notifications for user — newest first
    Page<Notification> findByUserIdOrderByCreatedAtDesc(UUID userId, Pageable pageable);

    // Unread count — for badge in Flutter UI
    long countByUserIdAndIsReadFalse(UUID userId);

    // Mark all as read
    @Modifying
    @Query("UPDATE Notification n SET n.isRead = true " +
           "WHERE n.user.id = :userId AND n.isRead = false")
    int markAllReadByUser(@Param("userId") UUID userId);

    // Notifications due for sending — called by scheduler
    @Query("SELECT n FROM Notification n " +
           "WHERE n.sentAt IS NULL " +
           "AND (n.scheduledFor IS NULL OR n.scheduledFor <= :now)")
    List<Notification> findPendingToSend(@Param("now") OffsetDateTime now);

    // Mark as sent
    @Modifying
    @Query("UPDATE Notification n SET n.sentAt = :now WHERE n.id = :id")
    void markSent(@Param("id") UUID id, @Param("now") OffsetDateTime now);
}
