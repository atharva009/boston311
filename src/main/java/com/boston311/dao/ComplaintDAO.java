package com.boston311.dao;

import com.boston311.model.Complaint;

import java.util.List;

public interface ComplaintDAO {
    void saveComplaint(Complaint complaint);
    Complaint getComplaintById(int id);
    List<Complaint> getAllComplaints();
    List<Complaint> getByDepartmentId(int deptId);
    void assignWorker(int complaintId, int workerId);
    void updateStatus(int complaintId, String status);
}