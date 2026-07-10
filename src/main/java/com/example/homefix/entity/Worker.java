package com.example.homefix.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "workers")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Worker {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String nationalId;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String fullName;

    @Column(nullable = false)
    private String contactInfo;

    @Column(nullable = false)
    private String areaOfService;

    @Column(length = 2000)
    private String skills;

    @Column(length = 2000)
    private String summary;

    private String experience;

    private Double rating;

    private String guaranteeTemplateTitle;

    @Column(length = 2000)
    private String guaranteeCoverage;

    private String guaranteeDuration;

    private String balancePaymentStatus;

    @Column(length = 2000)
    private String pastWorkFeedback;

    private String profilePhotoUrl;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private String role;

    @Column(nullable = false)
    private Boolean isVerified;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}
