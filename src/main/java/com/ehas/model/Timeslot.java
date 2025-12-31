/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.model;
import java.io.Serializable;
import java.time.LocalTime;

/**
 *
 * @author ASUS
 */
public class Timeslot implements Serializable {
    private int timeslotID, scheduleID;
    private LocalTime startTime, endTime;
    private boolean isAvailable;

    public Timeslot() { }

    public Timeslot(int timeslotID, LocalTime startTime, LocalTime endTime, boolean isAvailable, int scheduleID) {
        this.timeslotID = timeslotID;
        this.startTime = startTime;
        this.endTime = endTime;
        this.isAvailable = isAvailable;
        this.scheduleID = scheduleID;
    }

    public int getTimeslotID() { return timeslotID; }
    public LocalTime getStartTime() { return startTime; }
    public LocalTime getEndTime() { return endTime; }
    public boolean isAvailable() { return isAvailable; }
    public int getScheduleID() { return scheduleID; }

    public void setTimeslotID(int timeslotID) { this.timeslotID = timeslotID; }
    public void setStartTime(LocalTime startTime) { this.startTime = startTime; }
    public void setEndTime(LocalTime endTime) { this.endTime = endTime; }
    public void setIsAvailable(boolean isAvailable) { this.isAvailable = isAvailable; }
    public void setScheduleID(int scheduleID) { this.scheduleID = scheduleID; }
}