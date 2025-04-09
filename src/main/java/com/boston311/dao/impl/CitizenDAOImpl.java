package com.boston311.dao.impl;

import com.boston311.dao.CitizenDAO;
import com.boston311.model.Citizen;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class CitizenDAOImpl implements CitizenDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void saveCitizen(Citizen citizen) {
        getSession().merge(citizen);
    }

    @Override
    public Citizen getCitizenById(int id) {
        return getSession().get(Citizen.class, id);
    }

    @Override
    public List<Citizen> getAllCitizens() {
        return getSession().createQuery("from Citizen", Citizen.class).getResultList();
    }
}