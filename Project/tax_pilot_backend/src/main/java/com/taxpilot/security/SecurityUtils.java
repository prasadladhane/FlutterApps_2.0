package com.taxpilot.security;

import com.taxpilot.exception.UnauthorizedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.UUID;

/**
 * Utility to extract the current authenticated user from the SecurityContext.
 * Used in service layer to get userId without passing it through every method.
 */
public class SecurityUtils {

    private SecurityUtils() {}

    public static UserPrincipal getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !(auth.getPrincipal() instanceof UserPrincipal)) {
            throw new UnauthorizedException("No authenticated user found in security context.");
        }
        return (UserPrincipal) auth.getPrincipal();
    }

    public static UUID getCurrentUserId() {
        return getCurrentUser().getUserId();
    }

    public static String getCurrentFirebaseUid() {
        return getCurrentUser().getFirebaseUid();
    }
}
