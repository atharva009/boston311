package com.boston311.dao.impl;

import com.boston311.dao.DepartmentDAO;
import com.boston311.model.Department;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public class DepartmentDAOImpl implements DepartmentDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void saveDepartment(Department department) {
        entityManager.persist(department);
    }

    @Override
    public Department getDepartmentById(int id) {
        return entityManager.find(Department.class, id);
    }

    @Override
    public List<Department> getAllDepartments() {
        return entityManager.createQuery("from Department", Department.class).getResultList();
    }
}