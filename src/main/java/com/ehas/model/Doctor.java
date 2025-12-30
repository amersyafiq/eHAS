/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.model;
import java.io.Serializable;
/**
 *
 * @author SYAFIQ
 */
public class Doctor implements Serializable {
    private int accountID;
    private String licenseNo;
    private int specialityID;

    public Doctor() { }

    public Doctor(int accountID, String licenseNo, int specialityID) {
        this.accountID = accountID;
        this.licenseNo = licenseNo;
        this.specialityID = specialityID;
    }

    public int getAccountID() { return accountID; }
    public String getLicenseNo() { return licenseNo; }
    public int getSpecialityID() { return specialityID; }

    public void setAccountID(int accountID) { this.accountID = accountID; }
    public void setLicenseNo(String licenseNo) { this.licenseNo = licenseNo; }
    public void setSpecialityID(int specialityID) { this.specialityID = specialityID; }
}