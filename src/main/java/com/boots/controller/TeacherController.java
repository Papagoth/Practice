package com.boots.controller;


import com.boots.constant.StringConstant;
import com.boots.entity.Party;
import com.boots.entity.Student;
import com.boots.repository.PartyRepo;
import com.boots.service.PartyService;
import com.boots.service.TeacherService;
import org.hibernate.tool.schema.internal.exec.ScriptTargetOutputToFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class TeacherController {
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private PartyRepo partyRepo;

    @GetMapping(StringConstant.SLTEACHER)
    public String teacher(Model model) {
        model.addAttribute("teacher", teacherService.findAll());
        return StringConstant.TEACHER;
    }


    //@PostMapping("/Some_name")
    //public ResponseEntity<String> getsome(@RequestBody Student student) {
    //        System.out.println(student);
    //        return new ResponseEntity<>(HttpStatus.OK);
    //    }


}
