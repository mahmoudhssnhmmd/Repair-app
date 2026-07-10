package com.example.homefix.dto;

import jakarta.validation.constraints.NotBlank;
public record WorkerRequest(
        String email,
        @NotBlank(message = "Password cannot be blank")
        String password,
        @NotBlank(message = "National ID cannot be blank")
        String nationalId,
        String fullName,
        String contactInfo,
        String areaOfService,
        String skills,
        String summary,
        String experience,
        Double rating,
        String guaranteeTemplateTitle,
        String guaranteeCoverage,
        String guaranteeDuration,
        String balancePaymentStatus,
        String pastWorkFeedback,
        String profilePhotoUrl,
        String status
) {
}
