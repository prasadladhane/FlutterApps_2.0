package com.taxpilot.config;

import com.github.vladimir_bukhtoyarov.bucket4j.Bandwidth;
import com.github.vladimir_bukhtoyarov.bucket4j.Bucket;
import com.github.vladimir_bukhtoyarov.bucket4j.Bucket4j;
import com.github.vladimir_bukhtoyarov.bucket4j.Refill;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Per-user rate limiter using Bucket4j token bucket algorithm.
 * Each user gets an independent bucket — 100 requests/minute.
 *
 * For 30K users: buckets are created lazily and stored in a ConcurrentHashMap.
 * At ~200 bytes per bucket, 30K buckets ≈ 6MB — well within heap limits.
 *
 * Scale-out note: For multi-instance deployments, replace with
 * Bucket4j + Redis/Hazelcast distributed buckets (Java 17+ only via Bucket4j 8.x).
 * For now, in-memory is sufficient for a single-instance deployment.
 */
@Component
public class RateLimitConfig {

    private static final int CAPACITY        = 100;   // max tokens
    private static final int REFILL_TOKENS   = 100;   // refill amount
    private static final int REFILL_SECONDS  = 60;    // refill period

    // userId → Bucket
    private final Map<UUID, Bucket> buckets = new ConcurrentHashMap<>();

    public Bucket resolveBucket(UUID userId) {
        return buckets.computeIfAbsent(userId, this::newBucket);
    }

    private Bucket newBucket(UUID userId) {
        Bandwidth limit = Bandwidth.classic(
                CAPACITY,
                Refill.greedy(REFILL_TOKENS, Duration.ofSeconds(REFILL_SECONDS)));
        return Bucket4j.builder().addLimit(limit).build();
    }

    /**
     * Check if user has available tokens.
     * Returns true if request is allowed, false if rate limited.
     */
    public boolean tryConsume(UUID userId) {
        return resolveBucket(userId).tryConsume(1);
    }

    /**
     * Returns remaining tokens for the user — useful for response headers.
     */
    public long getAvailableTokens(UUID userId) {
        return resolveBucket(userId).getAvailableTokens();
    }
}
