package com.boston311.dao.impl;

import com.boston311.dao.WorkerDAO;
import com.boston311.model.Worker;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class WorkerDAOImpl implements WorkerDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void saveWorker(Worker worker) {
        getSession().persist(worker);
    }

    @Override
    public Worker getWorkerById(int id) {
        return getSession().get(Worker.class, id);
    }

    @Override
    public Worker getWorkerByEmail(String email) {
        List<Worker> result = getSession()
                .createQuery("from Worker where email = :email", Worker.class)
                .setParameter("email", email)
                .getResultList();
        return result.isEmpty() ? null : result.get(0);
    }

    @Override
    public List<Worker> getWorkersByDepartment(int departmentId) {
        return getSession()
                .createQuery("from Worker where department.id = :deptId", Worker.class)
                .setParameter("deptId", departmentId)
                .getResultList();
    }

    @Override
    public List<Worker> getAllWorkers() {
        return getSession()
                .createQuery("from Worker", Worker.class)
                .getResultList();
    }

    @Override
    public void updateWorker(Worker worker) {
        getSession().merge(worker);
    }
}