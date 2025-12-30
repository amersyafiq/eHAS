/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.model;

import java.time.LocalDateTime;

public class Consultation {
    private int consultationId;
    private int appointmentId;
    private int doctorId;

    private String symptoms;
    private String diagnosis;
    private String notes;
    private String prescription;

    private LocalDateTime consultationDate;

    // constructors
    public Consultation() {}

    // getters & setters
}
