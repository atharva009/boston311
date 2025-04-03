package com.boston311.dao.impl;

import com.boston311.dao.WorkerDAO;
import com.boston311.model.Worker;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public class WorkerDAOImpl implements WorkerDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void saveWorker(Worker worker) {
        entityManager.persist(worker);
    }

    @Override
    public Worker getWorkerById(int id) {
        return entityManager.find(Worker.class, id);
    }

    @Override
    public List<Worker> getWorkersByDepartment(int departmentId) {
        return entityManager.createQuery(
                        "from Worker where department.id = :deptId", Worker.class)
                .setParameter("deptId", departmentId)
                .getResultList();
    }
}