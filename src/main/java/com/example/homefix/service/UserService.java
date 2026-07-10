package com.example.homefix.service;

import com.example.homefix.dto.UserRequest;
import com.example.homefix.dto.UserResponse;
import com.example.homefix.entity.User;
import com.example.homefix.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<UserResponse> findAll() {
        return userRepository.findAll()
                .stream()
                .map(this::toResponse)
                .toList();
    }

    public UserResponse findById(Long id) {
        return userRepository.findById(id)
                .map(this::toResponse)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
    }

    public UserResponse create(UserRequest request) {
        validateCreateRequest(request);

        if (userRepository.existsByEmail(request.email())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Email already exists");
        }

        User user = User.builder()
                .email(request.email())
                .password(request.password())
                .fullName(request.fullName())
                .nationalId(request.nationalId())
                .phone(request.phone())
                .address(request.address())
                .areaOfService(request.areaOfService())
                .skills(request.skills())
                .userSummary(request.userSummary())
                .experience(request.experience())
                .rating(request.rating())
                .balancePaymentStatus(request.balancePaymentStatus())
                .pastWorkFeedback(request.pastWorkFeedback())
                .profilePhotoUrl(request.profilePhotoUrl())
                .role(request.role())
                .build();

        return toResponse(userRepository.save(user));
    }

    public UserResponse update(Long id, UserRequest request) {
        validateId(id);
        validateRequestBody(request);

        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        if (StringUtils.hasText(request.email()) && !request.email().equals(user.getEmail())) {
            if (userRepository.existsByEmail(request.email())) {
                throw new ResponseStatusException(HttpStatus.CONFLICT, "Email already exists");
            }
            user.setEmail(request.email());
        }

        if (StringUtils.hasText(request.password())) {
            user.setPassword(request.password());
        }
        if (StringUtils.hasText(request.fullName())) {
            user.setFullName(request.fullName());
        }
        if (request.nationalId() != null) {
            user.setNationalId(request.nationalId());
        }
        if (request.phone() != null) {
            user.setPhone(request.phone());
        }
        if (request.address() != null) {
            user.setAddress(request.address());
        }
        if (request.areaOfService() != null) {
            user.setAreaOfService(request.areaOfService());
        }
        if (request.skills() != null) {
            user.setSkills(request.skills());
        }
        if (request.userSummary() != null) {
            user.setUserSummary(request.userSummary());
        }
        if (request.experience() != null) {
            user.setExperience(request.experience());
        }
        if (request.rating() != null) {
            user.setRating(request.rating());
        }
        if (request.balancePaymentStatus() != null) {
            user.setBalancePaymentStatus(request.balancePaymentStatus());
        }
        if (request.pastWorkFeedback() != null) {
            user.setPastWorkFeedback(request.pastWorkFeedback());
        }
        if (request.profilePhotoUrl() != null) {
            user.setProfilePhotoUrl(request.profilePhotoUrl());
        }
        if (request.role() != null) {
            user.setRole(request.role());
        }

        return toResponse(userRepository.save(user));
    }

    public void delete(Long id) {
        validateId(id);
        if (!userRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }

        userRepository.deleteById(id);
    }

    private void validateCreateRequest(UserRequest request) {
        validateRequestBody(request);

        if (!StringUtils.hasText(request.email())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Email is required");
        }
        if (!StringUtils.hasText(request.password())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Password is required");
        }
        if (!StringUtils.hasText(request.fullName())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Full name is required");
        }
        if (request.role() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Role is required");
        }
    }

    private void validateId(Long id) {
        if (id == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Id is required");
        }
    }

    private UserResponse toResponse(User user) {
        return new UserResponse(
                user.getId(),
                user.getEmail(),
                user.getFullName(),
                user.getNationalId(),
                user.getPhone(),
                user.getAddress(),
                user.getAreaOfService(),
                user.getSkills(),
                user.getUserSummary(),
                user.getExperience(),
                user.getRating(),
                user.getBalancePaymentStatus(),
                user.getPastWorkFeedback(),
                user.getProfilePhotoUrl(),
                user.getRole(),
                user.getCreatedAt()
        );
    }

    private void validateRequestBody(UserRequest request) {
        if (request == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Request body is required");
        }
    }
}
