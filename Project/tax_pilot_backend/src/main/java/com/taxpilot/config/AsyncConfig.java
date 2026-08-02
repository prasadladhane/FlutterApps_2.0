package com.taxpilot.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.lang.reflect.Method;
import java.util.concurrent.Executor;

@Configuration
public class AsyncConfig implements AsyncConfigurer {

    private static final Logger log = LoggerFactory.getLogger(AsyncConfig.class);

    /**
     * Thread pool for @Async tasks:
     * - Tax recalculation triggered by data changes
     * - Notification scheduling
     * - Advance tax schedule refresh
     *
     * Tuned for 30K users: enough threads to handle burst without exhausting memory.
     */
    @Bean(name = "taskExecutor")
    @Override
    public Executor getAsyncExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(10);
        executor.setMaxPoolSize(50);
        executor.setQueueCapacity(500);
        executor.setKeepAliveSeconds(60);
        executor.setThreadNamePrefix("taxpilot-async-");
        // Caller-runs policy: if queue is full, calling thread executes — no task dropped
        executor.setRejectedExecutionHandler(
                (r, pool) -> log.warn("Async task queue full — executing on caller thread"));
        executor.initialize();
        return executor;
    }

    // Log uncaught exceptions from @Async methods instead of silently swallowing them
    @Override
    public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
        return new AsyncUncaughtExceptionHandler() {
            @Override
            public void handleUncaughtException(Throwable ex, Method method, Object... params) {
                log.error("Uncaught async exception in method '{}': {}",
                        method.getName(), ex.getMessage(), ex);
            }
        };
    }
}
