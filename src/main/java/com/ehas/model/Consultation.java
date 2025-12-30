/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.model;

import java.io.Serializable;

/**
 *
 * @author eHAS Team
 */
public class Consultation implements Serializable {
    private int consultationId;
    private int appointmentId;
    private int doctorId;
    private String symptoms;
    private String diagnosis;
    private String treatment;
    private String notes;
    private String consultationDate;
    
    public Consultation() { }
    
    public Consultation(int consultationId, int appointmentId, int doctorId, String symptoms, 
                       String diagnosis, String treatment, String notes, String consultationDate) {
        this.consultationId = consultationId;
        this.appointmentId = appointmentId;
        this.doctorId = doctorId;
        this.symptoms = symptoms;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.notes = notes;
        this.consultationDate = consultationDate;
    }

    public int getConsultationId() { 
        return consultationId; 
    }
    
    public int getAppointmentId() { 
        return appointmentId; 
    }
    
    public int getDoctorId() { 
        return doctorId; 
    }
    
    public String getSymptoms() { 
        return symptoms; 
    }
    
    public String getDiagnosis() { 
        return diagnosis; 
    }
    
    public String getTreatment() { 
        return treatment; 
    }
    
    public String getNotes() { 
        return notes; 
    }
    
    public String getConsultationDate() { 
        return consultationDate; 
    }

    public void setConsultationId(int consultationId) { 
        this.consultationId = consultationId; 
    }
    
    public void setAppointmentId(int appointmentId) { 
        this.appointmentId = appointmentId; 
    }
    
    public void setDoctorId(int doctorId) { 
        this.doctorId = doctorId; 
    }
    
    public void setSymptoms(String symptoms) { 
        this.symptoms = symptoms; 
    }
    
    public void setDiagnosis(String diagnosis) { 
        this.diagnosis = diagnosis; 
    }
    
    public void setTreatment(String treatment) { 
        this.treatment = treatment; 
    }
    
    public void setNotes(String notes) { 
        this.notes = notes; 
    }
    
    public void setConsultationDate(String consultationDate) { 
        this.consultationDate = consultationDate; 
    }
}
