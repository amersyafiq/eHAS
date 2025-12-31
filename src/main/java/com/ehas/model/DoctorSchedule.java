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
public class DoctorSchedule implements Serializable {
    private int scheduleID, doctorID;
    private LocalDate scheduleDate;
    private boolean isActive;

    public DoctorSchedule() { }

    public DoctorSchedule(int scheduleID, LocalDate scheduleDate, boolean isActive, int doctorID) {
        this.scheduleID = scheduleID;
        this.scheduleDate = scheduleDate;
        this.isActive = isActive;
        this.doctorID = doctorID;
    }

    public int getScheduleID() { return scheduleID; }
    public LocalDate getScheduleDate() { return scheduleDate; }
    public boolean isActive() { return isActive; }
    public int getDoctorID() { return doctorID; }

    public void setScheduleID(int scheduleID) { this.scheduleID = scheduleID; }
    public void setScheduleDate(LocalDate scheduleDate) { this.scheduleDate = scheduleDate; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public void setDoctorID(int doctorID) { this.doctorID = doctorID; }
}
