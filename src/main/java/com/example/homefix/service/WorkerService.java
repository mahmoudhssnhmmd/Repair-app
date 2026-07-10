package com.example.homefix.service;

import com.example.homefix.dto.WorkerRequest;
import com.example.homefix.dto.WorkerResponse;
import com.example.homefix.entity.Worker;
import com.example.homefix.repository.WorkerRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class WorkerService {

    private final WorkerRepository workerRepository;

    public WorkerService(WorkerRepository workerRepository) {
        this.workerRepository = workerRepository;
    }

    public List<WorkerResponse> findAll() {
        return workerRepository.findAll().stream().map(this::toResponse).toList();
    }

    public WorkerResponse findById(Long id) {
        validateId(id);
        return workerRepository.findById(id)
                .map(this::toResponse)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Worker not found"));
    }

    public WorkerResponse create(WorkerRequest request) {
        validateRequestBody(request);
        validateCreateRequest(request);

        if (workerRepository.existsByNationalId(request.nationalId())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "National ID already exists");
        }

        Worker worker = Worker.builder()
                .nationalId(request.nationalId())
                .fullName(request.fullName())
                .contactInfo(request.contactInfo())
                .areaOfService(request.areaOfService())
                .skills(request.skills())
                .summary(request.summary())
                .experience(request.experience())
                .rating(request.rating())
                .guaranteeTemplateTitle(request.guaranteeTemplateTitle())
                .guaranteeCoverage(request.guaranteeCoverage())
                .guaranteeDuration(request.guaranteeDuration())
                .balancePaymentStatus(request.balancePaymentStatus())
                .pastWorkFeedback(request.pastWorkFeedback())
                .profilePhotoUrl(request.profilePhotoUrl())
                .build();

        return toResponse(workerRepository.save(worker));
    }

    public WorkerResponse update(Long id, WorkerRequest request) {
        validateId(id);
        validateRequestBody(request);

        Worker worker = workerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Worker not found"));

        if (StringUtils.hasText(request.nationalId()) && !request.nationalId().equals(worker.getNationalId())) {
            if (workerRepository.existsByNationalId(request.nationalId())) {
                throw new ResponseStatusException(HttpStatus.CONFLICT, "National ID already exists");
            }
            worker.setNationalId(request.nationalId());
        }
        if (StringUtils.hasText(request.fullName())) worker.setFullName(request.fullName());
        if (StringUtils.hasText(request.contactInfo())) worker.setContactInfo(request.contactInfo());
        if (StringUtils.hasText(request.areaOfService())) worker.setAreaOfService(request.areaOfService());
        if (request.skills() != null) worker.setSkills(request.skills());
        if (request.summary() != null) worker.setSummary(request.summary());
        if (request.experience() != null) worker.setExperience(request.experience());
        if (request.rating() != null) worker.setRating(request.rating());
        if (request.guaranteeTemplateTitle() != null) worker.setGuaranteeTemplateTitle(request.guaranteeTemplateTitle());
        if (request.guaranteeCoverage() != null) worker.setGuaranteeCoverage(request.guaranteeCoverage());
        if (request.guaranteeDuration() != null) worker.setGuaranteeDuration(request.guaranteeDuration());
        if (request.balancePaymentStatus() != null) worker.setBalancePaymentStatus(request.balancePaymentStatus());
        if (request.pastWorkFeedback() != null) worker.setPastWorkFeedback(request.pastWorkFeedback());
        if (request.profilePhotoUrl() != null) worker.setProfilePhotoUrl(request.profilePhotoUrl());

        return toResponse(workerRepository.save(worker));
    }

    public void delete(Long id) {
        validateId(id);
        if (!workerRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Worker not found");
        }
        workerRepository.deleteById(id);
    }

    private void validateCreateRequest(WorkerRequest request) {
        if (!StringUtils.hasText(request.nationalId())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "National ID is required");
        }
        if (!StringUtils.hasText(request.fullName())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Full name is required");
        }
        if (!StringUtils.hasText(request.contactInfo())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Contact info is required");
        }
        if (!StringUtils.hasText(request.areaOfService())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Area of service is required");
        }
    }

    private void validateId(Long id) {
        if (id == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Id is required");
        }
    }

    private void validateRequestBody(WorkerRequest request) {
        if (request == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Request body is required");
        }
    }

    private WorkerResponse toResponse(Worker worker) {
        return new WorkerResponse(
                worker.getId(),
                worker.getNationalId(),
                worker.getFullName(),
                worker.getContactInfo(),
                worker.getAreaOfService(),
                worker.getSkills(),
                worker.getSummary(),
                worker.getExperience(),
                worker.getRating(),
                worker.getGuaranteeTemplateTitle(),
                worker.getGuaranteeCoverage(),
                worker.getGuaranteeDuration(),
                worker.getBalancePaymentStatus(),
                worker.getPastWorkFeedback(),
                worker.getProfilePhotoUrl(),
                worker.getCreatedAt()
        );
    }
}
