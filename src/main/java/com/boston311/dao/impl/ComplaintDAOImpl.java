package com.boston311.dao.impl;

import com.boston311.dao.ComplaintDAO;
import com.boston311.model.Complaint;
import com.boston311.model.Worker;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class ComplaintDAOImpl implements ComplaintDAO {

    @Autowired
    private SessionFactory sessionFactory;

    // Convenience method to get the current Hibernate session
    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void saveComplaint(Complaint complaint) {
        getSession().merge(complaint);
    }

    @Override
    public Complaint getComplaintById(int id) {
        return getSession().get(Complaint.class, id);
    }

    @Override
    public List<Complaint> getAllComplaints() {
        return getSession()
                .createQuery("from Complaint", Complaint.class)
                .getResultList();
    }

    @Override
    public List<Complaint> getByDepartmentId(int deptId) {
        return getSession()
                .createQuery("from Complaint where department.id = :deptId", Complaint.class)
                .setParameter("deptId", deptId)
                .getResultList();
    }

    @Override
    public void assignWorker(int complaintId, int workerId) {
        Complaint complaint = getComplaintById(complaintId);
        Worker worker = getSession().get(Worker.class, workerId);
        complaint.setAssignedWorker(worker);
        getSession().merge(complaint);
    }

    @Override
    public void updateStatus(int complaintId, String status) {
        Complaint complaint = getComplaintById(complaintId);
        complaint.setStatus(status);
        getSession().merge(complaint);
    }

    @Override
    public List<Complaint> getComplaintsByCitizenId(int citizenId) {
        return getSession()
                .createQuery("from Complaint where citizen.id = :cid", Complaint.class)
                .setParameter("cid", citizenId)
                .getResultList();
    }
}