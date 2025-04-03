package com.boston311.dao.impl;

import com.boston311.dao.CitizenDAO;
import com.boston311.model.Citizen;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public class CitizenDAOImpl implements CitizenDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void saveCitizen(Citizen citizen) {
        entityManager.persist(citizen);
    }

    @Override
    public Citizen getCitizenById(int id) {
        return entityManager.find(Citizen.class, id);
    }

    @Override
    public List<Citizen> getAllCitizens() {
        return entityManager.createQuery("from Citizen", Citizen.class).getResultList();
    }
}