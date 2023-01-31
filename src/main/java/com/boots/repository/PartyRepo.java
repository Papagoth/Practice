package com.boots.repository;

import com.boots.entity.Party;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PartyRepo extends CrudRepository<Party,Long> {
    List<Party> findAll();
    Party findPartyById(Long id);
}
