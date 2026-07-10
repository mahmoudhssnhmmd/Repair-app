package com.example.homefix.repository;

import com.example.homefix.entity.Worker;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface WorkerRepository extends JpaRepository<Worker, Long> {
    Optional<Worker> findByNationalId(String nationalId);
    boolean existsByNationalId(String nationalId);
}
