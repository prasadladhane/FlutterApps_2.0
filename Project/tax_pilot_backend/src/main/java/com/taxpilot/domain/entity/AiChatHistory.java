package com.taxpilot.domain.entity;

import com.taxpilot.domain.enums.ChatRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "ai_chat_history")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AiChatHistory {

    @Id
    @GeneratedValue
    @Type(type = "pg-uuid")
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Type(type = "pg-uuid")
    @Column(name = "session_id", nullable = false)
    private UUID sessionId;

    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private ChatRole role;

    @Column(name = "message", nullable = false, columnDefinition = "TEXT")
    private String message;

    // Financial context snapshot sent to Gemini — stored as JSONB string
    @Column(name = "context_data", columnDefinition = "jsonb")
    private String contextData;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private OffsetDateTime createdAt;
}
