package com.boots.controller;


import com.boots.constant.StringConstant;
import com.boots.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TeacherController {
    @Autowired
    private TeacherService teacherService;

    @GetMapping(StringConstant.SLTEACHER)
    public String teacher(Model model)
    {
        model.addAttribute("teacher",teacherService.findAll());
        return StringConstant.TEACHER;
    }


}
