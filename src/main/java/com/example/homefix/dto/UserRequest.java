package com.example.homefix.dto;

import com.example.homefix.entity.Role;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;


public record UserRequest(
        @NotBlank(message = "Email cannot be blank")
        @Email(message = "Invalid email format")
        String email,
        @NotBlank(message = "Password cannot be blank")
        String password,
        @NotBlank(message = "Full name cannot be blank")
        String fullName,
        String nationalId,
        String phone,
        String address,
        String city,
        String areaOfService,
        String skills,
        String userSummary,
        String experience,
        Double rating,
        String balancePaymentStatus,
        String pastWorkFeedback,
        String profilePhotoUrl,
        Role role
) {
}
