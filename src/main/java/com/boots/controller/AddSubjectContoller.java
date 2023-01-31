package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Subject;
import com.boots.service.PartyService;
import com.boots.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
public class AddSubjectContoller {
    @Autowired
    private PartyService partyService;
    @Autowired
    private SubjectService subjectService;

    @GetMapping(StringConstant.SLADDSUBJECT)
    public String subject(Model model) {
        model.addAttribute("SubjectForm", new Subject());
        model.addAttribute("PartyList", partyService.findAll());
        return StringConstant.ADDSUBJECT;
    }

    @PostMapping(StringConstant.SLADDSUBJECT)
    public String addSubject(@ModelAttribute("SubjectForm") @Valid Subject subject, BindingResult bindingResult, Model model) {
        try {
            if (bindingResult.hasErrors()) {
                model.addAttribute("PartyList", partyService.findAll());
                return StringConstant.ADDSUBJECT;
            }
            subjectService.save(subject);

            return StringConstant.REDSUBJECT;
        } catch (Exception e) {
            bindingResult.addError(new FieldError("SubjectForm", "name", "Такое название уже существует"));
            model.addAttribute("PartyList", partyService.findAll());
            return StringConstant.ADDSUBJECT;
        }
    }
}
