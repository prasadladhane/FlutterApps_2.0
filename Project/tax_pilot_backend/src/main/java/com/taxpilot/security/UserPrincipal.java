package com.taxpilot.security;

import com.taxpilot.domain.entity.User;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;
import java.util.UUID;

/**
 * Spring Security principal wrapping our User entity.
 * Stored in the SecurityContext for the duration of each request.
 */
@Getter
public class UserPrincipal implements UserDetails {

    private final UUID userId;
    private final String firebaseUid;
    private final String email;

    public UserPrincipal(User user) {
        this.userId      = user.getId();
        this.firebaseUid = user.getFirebaseUid();
        this.email       = user.getEmail();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"));
    }

    @Override public String getPassword()  { return null; }  // Firebase handles auth
    @Override public String getUsername()  { return firebaseUid; }
    @Override public boolean isAccountNonExpired()    { return true; }
    @Override public boolean isAccountNonLocked()     { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled()              { return true; }
}
