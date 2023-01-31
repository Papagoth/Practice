package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.service.PartyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class DeletePartyController {
    @Autowired
    private PartyService partyService;
    @GetMapping(StringConstant.SLDELETEPARTY)
    public String delete(@PathVariable("id") Long id)
    {
        partyService.delete(id);
        return StringConstant.REDPARTY;
    }
}
