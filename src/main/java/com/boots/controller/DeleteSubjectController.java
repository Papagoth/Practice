package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.service.PartyService;
import com.boots.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class DeleteSubjectController {
    @Autowired
    private SubjectService subjectService;

    @GetMapping(StringConstant.SLDELETESUBJECT)
    public String getSubject(@PathVariable("id")Long id)
    {
        subjectService.delete(id);
        return StringConstant.REDSUBJECT;
    }
}
