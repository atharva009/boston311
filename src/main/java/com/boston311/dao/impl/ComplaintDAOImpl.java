package com.boston311.dao.impl;

import com.boston311.dao.ComplaintDAO;
import com.boston311.model.Complaint;
import com.boston311.model.Worker;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public class ComplaintDAOImpl implements ComplaintDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void saveComplaint(Complaint complaint) {
        entityManager.persist(complaint);
    }

    @Override
    public Complaint getComplaintById(int id) {
        return entityManager.find(Complaint.class, id);
    }

    @Override
    public List<Complaint> getAllComplaints() {
        return entityManager.createQuery("from Complaint", Complaint.class).getResultList();
    }

    @Override
    public List<Complaint> getByDepartmentId(int deptId) {
        return entityManager.createQuery(
                        "from Complaint where department.id = :deptId", Complaint.class)
                .setParameter("deptId", deptId)
                .getResultList();
    }

    @Override
    public void assignWorker(int complaintId, int workerId) {
        Complaint complaint = getComplaintById(complaintId);
        Worker worker = entityManager.find(Worker.class, workerId);
        complaint.setAssignedWorker(worker);
        entityManager.merge(complaint);
    }

    @Override
    public void updateStatus(int complaintId, String status) {
        Complaint complaint = getComplaintById(complaintId);
        complaint.setStatus(status);
        entityManager.merge(complaint);
    }
}