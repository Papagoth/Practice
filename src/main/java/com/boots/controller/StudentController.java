package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Party;
import com.boots.entity.Student;
import com.boots.service.PartyService;
import com.boots.service.StudentService;
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
public class StudentController {
    @Autowired
    private PartyService partyService;
    @Autowired
    private StudentService studentService;

    @GetMapping(StringConstant.SLSTUDENT)
    public String student() {
        return StringConstant.STUDENT;
    }

    @GetMapping("/get_allstudent")
    public ResponseEntity<List<Student>> getStudent() {
        return new ResponseEntity<>(studentService.findAll(), HttpStatus.OK);
    }

    @PostMapping(StringConstant.SLADDSTUDENT)
    public ResponseEntity<Student> addStudent(@RequestBody Student student) {
        try {
            studentService.save(student);
            return new ResponseEntity<>(studentService.save(student), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/get_onestudent/{id}")
    public ResponseEntity<Student> getOneParty(@PathVariable("id") Long id) {
        return new ResponseEntity<>(studentService.findStudentById(id), HttpStatus.OK);
    }
}
