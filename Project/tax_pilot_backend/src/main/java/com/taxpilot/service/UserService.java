package com.taxpilot.service;

import com.taxpilot.config.CacheConfig;
import com.taxpilot.domain.entity.User;
import com.taxpilot.domain.enums.TaxRegime;
import com.taxpilot.dto.request.RegisterRequest;
import com.taxpilot.dto.request.UpdateProfileRequest;
import com.taxpilot.dto.response.UserResponse;
import com.taxpilot.exception.BadRequestException;
import com.taxpilot.exception.DuplicateEntryException;
import com.taxpilot.exception.ResourceNotFoundException;
import com.taxpilot.repository.UserRepository;
import com.taxpilot.security.SecurityUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.UUID;

@Service
@Transactional
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // ----------------------------------------------------------------
    // Registration — called once after Firebase sign-up
    // ----------------------------------------------------------------
    public UserResponse register(RegisterRequest req) {
        if (userRepository.existsByFirebaseUid(req.getFirebaseUid())) {
            throw new DuplicateEntryException(
                "User already registered with this Firebase account.");
        }
        if (userRepository.existsByEmail(req.getEmail())) {
            throw new DuplicateEntryException(
                "An account with email " + req.getEmail() + " already exists.");
        }

        User user = User.builder()
                .firebaseUid(req.getFirebaseUid())
                .email(req.getEmail())
                .fullName(req.getFullName())
                .panNumber(req.getPanNumber())
                .dateOfBirth(req.getDateOfBirth())
                .phoneNumber(req.getPhoneNumber())
                .professionType(req.getProfessionType())
                .preferredRegime(req.getPreferredRegime())
                .financialYear(req.getFinancialYear())
                .annualIncomeEstimate(req.getAnnualIncomeEstimate())
                .isSeniorCitizen(isSeniorCitizen(req.getDateOfBirth()))
                .isSuperSenior(isSuperSenior(req.getDateOfBirth()))
                .profileComplete(true)
                .build();

        return toResponse(userRepository.save(user));
    }

    // ----------------------------------------------------------------
    // Get current user profile
    // ----------------------------------------------------------------
    @Cacheable(value = CacheConfig.CACHE_USER_PROFILE, key = "#userId")
    @Transactional(readOnly = true)
    public UserResponse getProfile(UUID userId) {
        return toResponse(findById(userId));
    }

    // ----------------------------------------------------------------
    // Update profile
    // ----------------------------------------------------------------
    @CacheEvict(value = {
            CacheConfig.CACHE_USER_PROFILE,
            CacheConfig.CACHE_DASHBOARD,
            CacheConfig.CACHE_TAX_ESTIMATE
    }, key = "#userId")
    public UserResponse updateProfile(UUID userId, UpdateProfileRequest req) {
        User user = findById(userId);

        if (req.getFullName()             != null) user.setFullName(req.getFullName());
        if (req.getPanNumber()            != null) user.setPanNumber(req.getPanNumber());
        if (req.getPhoneNumber()          != null) user.setPhoneNumber(req.getPhoneNumber());
        if (req.getProfessionType()       != null) user.setProfessionType(req.getProfessionType());
        if (req.getAnnualIncomeEstimate() != null) user.setAnnualIncomeEstimate(req.getAnnualIncomeEstimate());

        if (req.getDateOfBirth() != null) {
            user.setDateOfBirth(req.getDateOfBirth());
            user.setIsSeniorCitizen(isSeniorCitizen(req.getDateOfBirth()));
            user.setIsSuperSenior(isSuperSenior(req.getDateOfBirth()));
        }

        if (req.getPreferredRegime() != null) {
            user.setPreferredRegime(req.getPreferredRegime());
        }

        return toResponse(userRepository.save(user));
    }

    // ----------------------------------------------------------------
    // Switch preferred tax regime
    // ----------------------------------------------------------------
    @CacheEvict(value = {
            CacheConfig.CACHE_USER_PROFILE,
            CacheConfig.CACHE_DASHBOARD,
            CacheConfig.CACHE_TAX_ESTIMATE
    }, key = "#userId")
    public UserResponse switchRegime(UUID userId, TaxRegime regime) {
        User user = findById(userId);
        user.setPreferredRegime(regime);
        return toResponse(userRepository.save(user));
    }

    // ----------------------------------------------------------------
    // Internal helpers
    // ----------------------------------------------------------------
    public User findById(UUID userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", userId));
    }

    public User findByFirebaseUid(String uid) {
        return userRepository.findByFirebaseUid(uid)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "User not found for Firebase UID: " + uid));
    }

    private boolean isSeniorCitizen(LocalDate dob) {
        if (dob == null) return false;
        int age = LocalDate.now().getYear() - dob.getYear();
        return age >= 60 && age < 80;
    }

    private boolean isSuperSenior(LocalDate dob) {
        if (dob == null) return false;
        int age = LocalDate.now().getYear() - dob.getYear();
        return age >= 80;
    }

    public UserResponse toResponse(User u) {
        String maskedPan = u.getPanNumber() != null
                ? u.getPanNumber().substring(0, 5) + "****"
                  + u.getPanNumber().charAt(9)
                : null;

        return UserResponse.builder()
                .id(u.getId())
                .email(u.getEmail())
                .fullName(u.getFullName())
                .panNumber(maskedPan)
                .dateOfBirth(u.getDateOfBirth())
                .phoneNumber(u.getPhoneNumber())
                .professionType(u.getProfessionType())
                .preferredRegime(u.getPreferredRegime())
                .financialYear(u.getFinancialYear())
                .isSeniorCitizen(u.getIsSeniorCitizen())
                .isSuperSenior(u.getIsSuperSenior())
                .annualIncomeEstimate(u.getAnnualIncomeEstimate())
                .profileComplete(u.getProfileComplete())
                .createdAt(u.getCreatedAt())
                .build();
    }
}
