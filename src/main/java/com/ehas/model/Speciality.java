/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.model;
import java.io.Serializable;
/**
 *
 * @author ASUS
 */
public class Speciality implements Serializable {
    private int specialityID;
    private String specialityName, department;

    public Speciality() { }

    public Speciality(int specialityID, String specialityName, String department) {
        this.specialityID = specialityID;
        this.specialityName = specialityName;
        this.department = department;
    }

    public int getSpecialityID() { return specialityID; }
    public String getSpecialityName() { return specialityName; }
    public String getDepartment() { return department; }

    public void setSpecialityID(int specialityID) { this.specialityID = specialityID; }
    public void setSpecialityName(String specialityName) { this.specialityName = specialityName; }
    public void setDepartment(String department) { this.department = department; }
}
