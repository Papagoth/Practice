package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.service.PartyService;
import com.boots.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StudentController {
    @Autowired
    private PartyService partyService;
    @Autowired
    private StudentService studentService;

    @GetMapping(StringConstant.SLSTUDENT)
    public String student(Model model)
    {
        model.addAttribute("Student", studentService.findAll());
        return StringConstant.STUDENT;
    }
}
