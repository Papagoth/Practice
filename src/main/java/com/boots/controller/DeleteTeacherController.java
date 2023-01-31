package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class DeleteTeacherController {
    @Autowired
    private TeacherService teacherService;
    @GetMapping(StringConstant.SLDELETETEACHER)
    public String getTeacher(@PathVariable("id")Long id)
    {
       teacherService.delete(id);
        return StringConstant.REDTEACHER;
    }
}
