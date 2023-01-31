package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Party;
import com.boots.service.PartyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
public class PartyChangeController {
    @Autowired
    private PartyService partyService;

    @GetMapping(StringConstant.SLCHANGEPARTY)
    public String getParty(@PathVariable("id") Long id, Model model) {
        model.addAttribute("id", id);
        return StringConstant.CHANGEPARTY;
    }
    //@PostMapping(StringConstant.SLCHANGEPARTY)
    //public String changeParty(@ModelAttribute("PartyForm") @Valid Party party, BindingResult bindingResult)
    //{
    //    try {
    //        if (bindingResult.hasErrors()) {
    //            return StringConstant.CHANGEPARTY;
    //        }
    //        partyService.save(party);
    //        return StringConstant.REDPARTY;
    //    }
    //    catch (Exception e)
    //    {
    //        bindingResult.addError(new FieldError("PartyForm","name","Такое название уже существует"));
    //        return StringConstant.CHANGEPARTY;
    //    }
    //}


    @GetMapping("/change_party/{id}")
    public ResponseEntity<Party> getParty(@PathVariable("id") Long id) {
        return new ResponseEntity<>(partyService.findPartyById(id), HttpStatus.OK);
    }

    @PostMapping("/addchange_party/{id}")
    public ResponseEntity<String> addParty(@RequestBody Party party) {
        try {
            partyService.save(party);
            return new ResponseEntity<>("", HttpStatus.OK);
        } catch (Exception e) {

            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
