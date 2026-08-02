package com.taxpilot.dto.request;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.UUID;

@Data
public class ChatMessageRequest {

    // null = start new session; provided = continue existing session
    private UUID sessionId;

    @NotBlank(message = "Message cannot be empty")
    @Size(max = 4000, message = "Message too long (max 4000 characters)")
    private String message;

    @NotBlank(message = "Financial year is required")
    private String financialYear;
}
