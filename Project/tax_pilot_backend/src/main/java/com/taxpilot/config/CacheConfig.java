package com.taxpilot.config;

import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.cache.CacheManager;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

@Configuration
public class CacheConfig {

    public static final String CACHE_DASHBOARD      = "dashboard";
    public static final String CACHE_TAX_ESTIMATE   = "tax-estimate";
    public static final String CACHE_USER_PROFILE   = "user-profile";
    public static final String CACHE_TAX_SLABS      = "tax-slabs";

    @Bean
    public CacheManager cacheManager() {
        CaffeineCacheManager manager = new CaffeineCacheManager();

        // Each cache has its own TTL tuned for how frequently data changes
        manager.registerCustomCache(CACHE_DASHBOARD,
                Caffeine.newBuilder()
                        .maximumSize(10_000)
                        .expireAfterWrite(5, TimeUnit.MINUTES)
                        .recordStats()
                        .build());

        manager.registerCustomCache(CACHE_TAX_ESTIMATE,
                Caffeine.newBuilder()
                        .maximumSize(10_000)
                        .expireAfterWrite(10, TimeUnit.MINUTES)
                        .recordStats()
                        .build());

        manager.registerCustomCache(CACHE_USER_PROFILE,
                Caffeine.newBuilder()
                        .maximumSize(10_000)
                        .expireAfterWrite(30, TimeUnit.MINUTES)
                        .recordStats()
                        .build());

        // Tax slabs are reference data — change only once a year
        manager.registerCustomCache(CACHE_TAX_SLABS,
                Caffeine.newBuilder()
                        .maximumSize(100)
                        .expireAfterWrite(24, TimeUnit.HOURS)
                        .recordStats()
                        .build());

        return manager;
    }
}
