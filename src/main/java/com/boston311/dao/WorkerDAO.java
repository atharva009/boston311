package com.boston311.dao;

import com.boston311.model.Worker;
import java.util.List;

public interface WorkerDAO {
    void saveWorker(Worker worker);
    Worker getWorkerById(int id);
    Worker getWorkerByEmail(String email);
    List<Worker> getWorkersByDepartment(int departmentId);
    List<Worker> getAllWorkers();
    void updateWorker(Worker worker);
}