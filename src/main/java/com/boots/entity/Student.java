package com.boots.entity;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

@AllArgsConstructor
@Entity
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "group_id")
    @NotNull
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Party party;
    @Column
    @Size(min = 3)
    private String fio;
    @Column(unique = true, nullable = false)
    @Max(99999999)
    @Min(10000000)
    private Long sticket;
    @NotNull
    private String borndata;

    public String getBorndata() {
        return borndata;
    }

    public void setBorndata(String borndata) {
        this.borndata = borndata;
    }

    public Student(Party party, String fio, Long sticket, String borndata) {
        this.party = party;
        this.fio = fio;
        this.sticket = sticket;
        this.borndata = borndata;
    }

    public Student() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Party getParty() {
        return party;
    }

    public void setParty(Party party) {
        this.party = party;
    }

    public String getFio() {
        return fio;
    }

    public void setFio(String fio) {
        this.fio = fio;
    }

    public Long getSticket() {
        return sticket;
    }

    public void setSticket(Long sticket) {
        this.sticket = sticket;
    }

    @Override
    public String toString() {
        try {
            return new ObjectMapper().writeValueAsString(this);
        } catch (Exception e) {
            return "";
        }
    }
}
