package com.boots.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Size;


@Entity
public class Party {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(unique = true, nullable = false)
    @Size(min = 3)
    private String name;
    @Column
    @Size(min = 3)
    private String course;

    public Party(String name, String course) {
        this.name = name;
        this.course = course;
    }

    @JsonCreator
    public Party(@JsonProperty("id") Long id, @JsonProperty("name") String name, @JsonProperty("course") String course) {
        this.name = name;
        this.course = course;
    }

    public Party() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    @Override
    public String toString() {
        return "Party{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", course='" + course + '\'' +
                '}';
    }
}
