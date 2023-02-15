package com.boots.controller;

import com.boots.constant.StringConstant;
import com.boots.entity.Party;
import com.boots.service.PartyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Controller
public class PartyController {
    @Autowired
    private PartyService partyService;

    @GetMapping(StringConstant.SLPARTY)
    public String party() {
        return StringConstant.PARTY;
    }

    @PostMapping(StringConstant.SLADDPARTY)
    public ResponseEntity<Party> addparty(@RequestBody Party party) {
        try {
            partyService.save(party);
            return new ResponseEntity<>(partyService.save(party), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/get_allparty")
    public ResponseEntity<List<Party>> getParty() {
        return new ResponseEntity<List<Party>>(partyService.findAll(), HttpStatus.OK);
    }

    @GetMapping("/get_oneparty/{id}")
    public ResponseEntity<Party> getOneParty(@PathVariable("id") Long id) {
        return new ResponseEntity<>(partyService.findPartyById(id), HttpStatus.OK);
    }

    @GetMapping("/Party_Find/{name}")
    public ResponseEntity<List<Party>> findParty(@PathVariable("name") String name) {
        return new ResponseEntity<>(partyService.findAllByNameLikeOrderByName(name), HttpStatus.OK);
    }

}
