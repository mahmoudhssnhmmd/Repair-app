package com.example.homefix.dto;

import com.example.homefix.entity.Role;

import java.time.LocalDateTime;

public record UserResponse(
        Long id,
        String email,
        String fullName,
        String phone,
        String address,
        String areaOfService,
        String skills,
        String userSummary,
        String experience,
        String rating,
        Double balancePaymentStatus,
        String nationalId,
        String pastWorkFeedback,
        String profilePhotoUrl,
        Role role,
        LocalDateTime createdAt
) {
}
