package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.service.PartyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PartyController {
    @Autowired
    private PartyService partyService;

    @GetMapping(StringConstant.SLPARTY)
    public String party(Model model)
    {
        model.addAttribute("Party", partyService.findAll());
        return StringConstant.PARTY;
    }

}
