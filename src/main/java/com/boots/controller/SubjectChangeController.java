package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Student;
import com.boots.entity.Subject;
import com.boots.service.PartyService;
import com.boots.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
public class SubjectChangeController {
    @Autowired
    private SubjectService subjectService;
    @Autowired
    private PartyService partyService;

    @GetMapping(StringConstant.SLCHANGESUBJECT)
    public String getSubject(@PathVariable("id") Long id, Model model) {
        model.addAttribute("partyList", subjectService.listWithoutParty(partyService.findAll(), subjectService.findSubjectsById(id).getParty().getName()));
        model.addAttribute("id", id);
        return StringConstant.CHANGESUBJECT;
    }

    // @PostMapping(StringConstant.SLCHANGESUBJECT)
    // public String changeSubject(@PathVariable("id")Long id,@ModelAttribute("SubjectForm")@Valid Subject subject, BindingResult bindingResult,Model model)
    // {
    //     try{
//
    //     if(bindingResult.hasErrors())
    //     {
    //         return StringConstant.CHANGESUBJECT;
    //     }
//
    //    subjectService.save(subject);
    //     return StringConstant.REDSUBJECT;}
    //     catch (Exception e)
    //     {
    //         model.addAttribute("PartyList", subjectService.listWithoutParty(partyService.findAll(), subjectService.findSubjectsById(id).getParty().getName()));
    //         bindingResult.addError(new FieldError("SubjectForm", "name", "Такое название уже существует"));
    //         return StringConstant.CHANGESUBJECT;
    //     }
//
//
    // }
    @GetMapping("/change_subject/{id}")
    public ResponseEntity<Subject> getStudentById(@PathVariable("id") Long id) {
        return new ResponseEntity<>(subjectService.findSubjectsById(id), HttpStatus.OK);
    }

    @PostMapping("/addchange_subject/{id}")
    public ResponseEntity<String> changeStudent(@RequestBody Subject subject) {
        try {
            //System.out.println(subject);
            subjectService.save(subject);
            return new ResponseEntity<>("", HttpStatus.OK);
        } catch (Exception e) {

            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
