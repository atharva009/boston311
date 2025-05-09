package com.boston311.dao;

import com.boston311.model.Department;
import java.util.List;

public interface DepartmentDAO {
    void saveDepartment(Department department);
    Department getDepartmentById(int id);
    List<Department> getAllDepartments();
    void updateDepartment(Department department);
    void deleteDepartment(int id);
    Department getDepartmentByEmail(String email);
}