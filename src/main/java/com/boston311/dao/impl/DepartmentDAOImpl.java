package com.boston311.dao.impl;

import com.boston311.dao.DepartmentDAO;
import com.boston311.model.Department;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class DepartmentDAOImpl implements DepartmentDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void saveDepartment(Department department) {
        getSession().persist(department);
    }

    @Override
    public Department getDepartmentById(int id) {
        return getSession().get(Department.class, id);
    }

    @Override
    public List<Department> getAllDepartments() {
        return getSession().createQuery("from Department", Department.class).getResultList();
    }
}