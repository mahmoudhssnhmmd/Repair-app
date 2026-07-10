package com.example.homefix.dto;

import java.time.LocalDateTime;

public record WorkerResponse(
        Long id,
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
        LocalDateTime createdAt
) {
}
