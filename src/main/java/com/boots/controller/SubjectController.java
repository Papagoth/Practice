package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Party;
import com.boots.entity.Student;
import com.boots.entity.Subject;
import com.boots.service.PartyService;
import com.boots.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Controller
public class SubjectController {
    @Autowired
    private PartyService partyService;
    @Autowired
    private SubjectService subjectService;

    @GetMapping(StringConstant.SLSUBJECT)
    public String subjects(Model model) {
        model.addAttribute("subject", subjectService.findAll());
        return StringConstant.SUBJECT;
    }

    @PostMapping(StringConstant.SLADDSUBJECT)
    public ResponseEntity<Subject> addSubject(@RequestBody Subject subject) {
        try {

            subjectService.save(subject);
            return new ResponseEntity<>(subjectService.save(subject), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/get_allsubject")
    public ResponseEntity<List<Subject>> getStudent() {
        return new ResponseEntity<>(subjectService.findAll(), HttpStatus.OK);
    }

    @GetMapping("/get_onesubject/{id}")
    public ResponseEntity<Subject> getOneParty(@PathVariable("id") Long id) {
        return new ResponseEntity<>(subjectService.findSubjectsById(id), HttpStatus.OK);
    }

    @GetMapping("/Subject_Find/{name}")
    public ResponseEntity<List<Subject>> findParty(@PathVariable("name") String name) {
        return new ResponseEntity<>(subjectService.findAllByNameContainingOrderByName(name), HttpStatus.OK);
    }


}
