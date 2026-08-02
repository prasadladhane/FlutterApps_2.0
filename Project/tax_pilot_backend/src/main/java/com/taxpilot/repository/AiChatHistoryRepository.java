package com.taxpilot.repository;

import com.taxpilot.domain.entity.AiChatHistory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface AiChatHistoryRepository extends JpaRepository<AiChatHistory, UUID> {

    // All messages in a session — for Gemini context window
    List<AiChatHistory> findByUserIdAndSessionIdOrderByCreatedAtAsc(
            UUID userId, UUID sessionId);

    // Recent sessions (distinct session IDs) — for chat history list
    @Query(value = "SELECT DISTINCT ON (session_id) id, user_id, session_id, role, " +
                   "message, context_data, created_at FROM ai_chat_history " +
                   "WHERE user_id = :userId ORDER BY session_id, created_at DESC",
           nativeQuery = true)
    List<Object[]> findDistinctSessionsByUser(@Param("userId") UUID userId);

    // Paginated messages for a session
    Page<AiChatHistory> findByUserIdAndSessionIdOrderByCreatedAtDesc(
            UUID userId, UUID sessionId, Pageable pageable);

    // Delete a session
    @Modifying
    @Query("DELETE FROM AiChatHistory c WHERE c.user.id = :userId AND c.sessionId = :sessionId")
    void deleteSession(@Param("userId") UUID userId, @Param("sessionId") UUID sessionId);

    // Message count per session — for Gemini context trimming
    long countByUserIdAndSessionId(UUID userId, UUID sessionId);
}
