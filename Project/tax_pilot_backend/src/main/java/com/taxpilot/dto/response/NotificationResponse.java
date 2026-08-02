package com.taxpilot.dto.response;

import com.taxpilot.domain.enums.NotificationType;
import lombok.Builder;
import lombok.Data;

import java.time.OffsetDateTime;
import java.util.UUID;

@Data
@Builder
public class NotificationResponse {
    private UUID id;
    private NotificationType type;
    private String title;
    private String body;
    private String metadata;  // raw JSON string — Flutter parses it
    private Boolean isRead;
    private OffsetDateTime scheduledFor;
    private OffsetDateTime sentAt;
    private OffsetDateTime createdAt;
}
