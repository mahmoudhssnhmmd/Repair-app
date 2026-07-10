package com.example.homefix.controller;

import com.example.homefix.dto.WorkerRequest;
import com.example.homefix.dto.WorkerResponse;
import com.example.homefix.service.WorkerService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/workers")
public class WorkerController {

    private final WorkerService workerService;

    public WorkerController(WorkerService workerService) {
        this.workerService = workerService;
    }

    @GetMapping
    public List<WorkerResponse> getAllWorkers() {
        return workerService.findAll();
    }

    @GetMapping("/{id}")
    public WorkerResponse getWorkerById(@PathVariable Long id) {
        return workerService.findById(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public WorkerResponse createWorker(@RequestBody WorkerRequest request) {
        return workerService.create(request);
    }

    @PutMapping("/{id}")
    public WorkerResponse updateWorker(@PathVariable Long id, @RequestBody WorkerRequest request) {
        return workerService.update(id, request);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteWorker(@PathVariable Long id) {
        workerService.delete(id);
    }
}
