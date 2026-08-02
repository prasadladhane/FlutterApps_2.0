package com.taxpilot.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final FirebaseAuthFilter firebaseAuthFilter;

    public SecurityConfig(FirebaseAuthFilter firebaseAuthFilter) {
        this.firebaseAuthFilter = firebaseAuthFilter;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            // Disable CSRF — stateless REST API with Firebase JWT, no sessions
            .csrf().disable()

            // CORS — allow Flutter web + mobile origins
            .cors().configurationSource(corsConfigurationSource())

            .and()

            // Stateless — no HTTP sessions, every request carries Firebase JWT
            .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)

            .and()

            // Authorization rules
            .authorizeRequests()
                // Public — registration endpoint (Firebase token valid but user not in DB yet)
                .antMatchers(HttpMethod.POST, "/auth/register").permitAll()

                // Public — health check
                .antMatchers("/actuator/health", "/api/health").permitAll()

                // Everything else requires authentication
                .anyRequest().authenticated()

            .and()

            // Return 401 JSON instead of redirect for unauthenticated requests
            .exceptionHandling()
                .authenticationEntryPoint((req, res, ex) -> {
                    res.setContentType("application/json");
                    res.setStatus(401);
                    res.getWriter().write(
                        "{\"success\":false,\"message\":\"Authentication required. " +
                        "Provide a valid Firebase token in the Authorization header.\"}");
                })
                .accessDeniedHandler((req, res, ex) -> {
                    res.setContentType("application/json");
                    res.setStatus(403);
                    res.getWriter().write(
                        "{\"success\":false,\"message\":\"Access denied.\"}");
                });

        // Add Firebase filter before Spring's default auth filter
        http.addFilterBefore(firebaseAuthFilter,
                UsernamePasswordAuthenticationFilter.class);
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();

        // Allow Flutter web app and local dev
        config.setAllowedOriginPatterns(Arrays.asList(
                "http://localhost:*",
                "https://localhost:*",
                "https://*.taxpilot.app"   // Replace with your production domain
        ));

        config.setAllowedMethods(Arrays.asList(
                "GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));

        config.setAllowedHeaders(Arrays.asList(
                "Authorization", "Content-Type", "Accept",
                "X-Requested-With", "Origin"));

        config.setExposedHeaders(Collections.singletonList("X-Total-Count"));
        config.setAllowCredentials(true);
        config.setMaxAge(3600L);  // Cache preflight for 1 hour

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }
}
