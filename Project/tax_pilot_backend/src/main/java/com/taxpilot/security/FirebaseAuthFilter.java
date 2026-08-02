package com.taxpilot.security;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.taxpilot.domain.entity.User;
import com.taxpilot.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

/**
 * Intercepts every request, validates the Firebase JWT from the
 * Authorization header, and sets the Spring Security context.
 *
 * Flow:
 *   1. Extract Bearer token from Authorization header
 *   2. Verify token with Firebase Admin SDK (signature + expiry)
 *   3. Look up user by firebase_uid in our DB
 *   4. Set UserPrincipal in SecurityContext
 *
 * If token is missing/invalid, the request continues unauthenticated.
 * SecurityConfig decides which endpoints require authentication.
 */
@Component
public class FirebaseAuthFilter extends OncePerRequestFilter {

    private static final Logger log = LoggerFactory.getLogger(FirebaseAuthFilter.class);
    private static final String BEARER_PREFIX = "Bearer ";

    private final UserRepository userRepository;

    public FirebaseAuthFilter(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        String token = extractToken(request);

        if (token == null) {
            filterChain.doFilter(request, response);
            return;
        }

        try {
            // Verify token with Firebase — throws FirebaseAuthException if invalid/expired
            FirebaseToken decoded = FirebaseAuth.getInstance().verifyIdToken(token);
            String firebaseUid = decoded.getUid();

            // Only set auth if not already set for this request
            if (SecurityContextHolder.getContext().getAuthentication() == null) {
                Optional<User> userOpt = userRepository.findByFirebaseUid(firebaseUid);

                if (userOpt.isPresent()) {
                    UserPrincipal principal = new UserPrincipal(userOpt.get());
                    UsernamePasswordAuthenticationToken auth =
                            new UsernamePasswordAuthenticationToken(
                                    principal, null, principal.getAuthorities());
                    auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(auth);
                } else {
                    // Firebase user exists but not yet registered in our DB.
                    // Store uid in request attribute so AuthController can use it for registration.
                    request.setAttribute("firebaseUid", firebaseUid);
                    request.setAttribute("firebaseEmail", decoded.getEmail());
                    request.setAttribute("firebaseName", decoded.getName());
                }
            }

        } catch (FirebaseAuthException ex) {
            // Token invalid or expired — log at debug level (not error, very common)
            log.debug("Firebase token verification failed: {}", ex.getMessage());
            // Clear security context to be safe
            SecurityContextHolder.clearContext();
        }

        filterChain.doFilter(request, response);
    }

    private String extractToken(HttpServletRequest request) {
        String header = request.getHeader("Authorization");
        if (StringUtils.hasText(header) && header.startsWith(BEARER_PREFIX)) {
            return header.substring(BEARER_PREFIX.length());
        }
        return null;
    }

    // Skip filter for public endpoints to avoid unnecessary Firebase SDK calls
    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        String path = request.getServletPath();
        return path.startsWith("/actuator")
                || path.equals("/api/health");
    }
}
