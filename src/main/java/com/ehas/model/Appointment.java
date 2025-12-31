/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.model;
import java.io.Serializable;
import java.time.LocalDate;

/**
 *
 * @author SYAFIQ
 */

public class Appointment implements Serializable {
    private int appointmentID, patientID, doctorID, timeslotID;
    private Integer followUpAppointmentID;
    private String status, concern, diagnosis, treatment, notes;
    private double consultationFee, treatmentFee, totalAmount;
    LocalDate createdAt;

    public Appointment() { }

    public Appointment(int appointmentID, String status, String concern,
                       int patientID, int doctorID, int timeslotID,
                       String diagnosis, String treatment, String notes,
                       Integer followUpAppointmentID,
                       double consultationFee, double treatmentFee, double totalAmount,
                       LocalDate createdAt) {

        this.appointmentID = appointmentID;
        this.status = status;
        this.concern = concern;
        this.patientID = patientID;
        this.doctorID = doctorID;
        this.timeslotID = timeslotID;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.notes = notes;
        this.followUpAppointmentID = followUpAppointmentID;
        this.consultationFee = consultationFee;
        this.treatmentFee = treatmentFee;
        this.totalAmount = totalAmount;
        this.createdAt = createdAt;
    }

    public int getAppointmentID() { return appointmentID; }
    public String getStatus() { return status; }
    public String getConcern() { return concern; }
    public int getPatientID() { return patientID; }
    public int getDoctorID() { return doctorID; }
    public int getTimeslotID() { return timeslotID; }
    public String getDiagnosis() { return diagnosis; }
    public String getTreatment() { return treatment; }
    public String getNotes() { return notes; }
    public Integer getFollowUpAppointmentID() { return followUpAppointmentID; }
    public double getConsultationFee() { return consultationFee; }
    public double getTreatmentFee() { return treatmentFee; }
    public double getTotalAmount() { return totalAmount; }
    public LocalDate getCreatedAt() { return createdAt; }

    public void setAppointmentID(int appointmentID) { this.appointmentID = appointmentID; }
    public void setStatus(String status) { this.status = status; }
    public void setConcern(String concern) { this.concern = concern; }
    public void setPatientID(int patientID) { this.patientID = patientID; }
    public void setDoctorID(int doctorID) { this.doctorID = doctorID; }
    public void setTimeslotID(int timeslotID) { this.timeslotID = timeslotID; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
    public void setTreatment(String treatment) { this.treatment = treatment; }
    public void setNotes(String notes) { this.notes = notes; }
    public void setFollowUpAppointmentID(Integer followUpAppointmentID) { this.followUpAppointmentID = followUpAppointmentID; }
    public void setConsultationFee(double consultationFee) { this.consultationFee = consultationFee; }
    public void setTreatmentFee(double treatmentFee) { this.treatmentFee = treatmentFee; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public void setCreatedAt(LocalDate createdAt) { this.createdAt = createdAt; }
}
