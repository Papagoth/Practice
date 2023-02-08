package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Subject;
import com.boots.entity.Teacher;
import com.boots.service.SubjectService;
import com.boots.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@Controller
public class AddTeacherController {

    @Autowired
    private TeacherService teacherService;
    @Autowired
    private SubjectService subjectService;

    @GetMapping(StringConstant.SLADDTEACHER)
    public String teacher(Model model) {
        model.addAttribute("SubjectList", subjectService.findAll());
        return StringConstant.ADDTEACHER;
    }

    //@PostMapping(StringConstant.SLADDTEACHER)
    //public String addTeacher(@ModelAttribute("TeacherForm") @Valid Teacher teacher, BindingResult bindingResult, Model model) {

    //    if (bindingResult.hasErrors()) {
    //        model.addAttribute("SubjectList", subjectService.findAll());
    //        return StringConstant.ADDTEACHER;
    //    }

    //    teacherService.save(teacher);

    //    return StringConstant.REDTEACHER;
    //}

    @PostMapping(StringConstant.SLADDTEACHER)
    public ResponseEntity<String> addTeacher(@RequestBody Teacher teacher) {
        try {
            //System.out.println(teacher);
            teacherService.save(teacher);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
