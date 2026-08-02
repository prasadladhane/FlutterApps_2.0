package com.taxpilot.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;

import javax.annotation.PostConstruct;
import java.io.IOException;

@Configuration
public class FirebaseConfig {

    private static final Logger log = LoggerFactory.getLogger(FirebaseConfig.class);

    @Value("${firebase.service-account-path}")
    private Resource serviceAccountResource;

    @Value("${firebase.project-id}")
    private String projectId;

    @PostConstruct
    public void initialize() {
        if (FirebaseApp.getApps().isEmpty()) {
            try {
                FirebaseOptions options = FirebaseOptions.builder()
                        .setCredentials(GoogleCredentials.fromStream(
                                serviceAccountResource.getInputStream()))
                        .setProjectId(projectId)
                        .build();

                FirebaseApp.initializeApp(options);
                log.info("Firebase initialized successfully for project: {}", projectId);

            } catch (IOException e) {
                log.error("Failed to initialize Firebase: {}", e.getMessage());
                throw new RuntimeException("Firebase initialization failed. " +
                        "Check firebase-service-account.json in resources.", e);
            }
        }
    }
}
