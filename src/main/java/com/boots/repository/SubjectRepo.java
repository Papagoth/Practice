package com.boots.repository;
import com.boots.entity.Subject;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SubjectRepo extends CrudRepository<Subject,Long> {
    List<Subject> findAll();

    Subject findSubjectsById(Long id);
    Subject findSubjectByName(String Name);

}
