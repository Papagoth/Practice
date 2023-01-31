package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Subject;
import com.boots.entity.Teacher;
import com.boots.service.SubjectService;
import com.boots.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
public class TeacherChangeController {
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private SubjectService subjectService;
    @GetMapping(StringConstant.SLCHANGETEACHER)
    public String getTeacher(@PathVariable("id")Long id, Model model)
    {
        model.addAttribute("SubjectList",teacherService.listWithoutSubject(teacherService.findTeacherById(id).getSubjects(),subjectService.findAll()));
        model.addAttribute("TeacherForm",teacherService.findTeacherById(id));
        return StringConstant.CHANGETEACHER;
    }
    @PostMapping(StringConstant.SLCHANGETEACHER)
        public String changeTeacher(@PathVariable("id")Long id, Model model,@ModelAttribute("TeacherForm")@Valid Teacher teacher, BindingResult bindingResult)
    {


        if(bindingResult.hasErrors())
        {
            model.addAttribute("SubjectList",teacherService.listWithoutSubject(teacherService.findTeacherById(id).getSubjects(),subjectService.findAll()));
            return StringConstant.CHANGETEACHER;
        }
        teacherService.save(teacher);
        return StringConstant.REDTEACHER;


    }
}
