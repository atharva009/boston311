package com.boston311.dao;

import com.boston311.model.Citizen;
import java.util.List;

public interface CitizenDAO {
    void saveCitizen(Citizen citizen);
    Citizen getCitizenById(int id);
    List<Citizen> getAllCitizens();
}