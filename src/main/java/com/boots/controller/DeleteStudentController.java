package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class DeleteStudentController {
    @Autowired
    private StudentService studentService;
    @GetMapping(StringConstant.SLDELETESTUDENT)
    public String delete(@PathVariable("id") Long id)
    {
        studentService.delete(id);
        return StringConstant.REDSTUDENT;
    }

}
