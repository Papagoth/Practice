package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.service.PartyService;
import com.boots.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class SubjectController {
    @Autowired
    private PartyService partyService;
    @Autowired
    private SubjectService subjectService;

    @GetMapping(StringConstant.SLSUBJECT)
    public String  subjects(Model model)
    {
        model.addAttribute("Subject", subjectService.findAll());
        return StringConstant.SUBJECT;
    }
}
