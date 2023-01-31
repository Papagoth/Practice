package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Student;
import com.boots.service.PartyService;
import com.boots.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
public class StudentChangeController {


    @Autowired
    private StudentService studentService;
    @Autowired
    private PartyService partyService;

    @GetMapping(StringConstant.SLCHANGESTUDENT)
    public String getStudent(@PathVariable("id") Long id, Model model) {
        model.addAttribute("PartyList", studentService.listWithoutParty(partyService.findAll(), studentService.findStudentById(id).getParty().getName()));
        model.addAttribute("StudentForm", studentService.findStudentById(id));
        return StringConstant.CHANGESTUDENT;
    }

    @PostMapping(StringConstant.SLCHANGESTUDENT)
    public String changeStudent(@PathVariable("id") Long id, @ModelAttribute("StudentForm") @Valid Student student, BindingResult bindingResult, Model model) {
        try {
            if (bindingResult.hasErrors()) {
                return StringConstant.CHANGESTUDENT;
            }
            studentService.save(student);
            return StringConstant.REDSTUDENT;
        } catch (Exception e) {
            bindingResult.addError(new FieldError("StudentForm", "sticket", "Такой билет уже существует"));
            model.addAttribute("PartyList", studentService.listWithoutParty(partyService.findAll(), studentService.findStudentById(id).getParty().getName()));
            return StringConstant.CHANGESTUDENT;

        }
    }
}
