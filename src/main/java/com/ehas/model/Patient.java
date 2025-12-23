/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.model;

/**
 *
 * @author SYAFIQ
 */
public class Patient {
    private int accountID;
    private String medicalRecordNo, bloodGroup, allergy;
    
    public Patient() { }
    public Patient(int accountID, String medicalRecordNo, String bloodGroup, String allergy) {
        this.accountID = accountID;
        this.medicalRecordNo = medicalRecordNo;
        this.bloodGroup = bloodGroup;
        this.allergy = allergy;
    }
    
    public int getAccountID() { return accountID; }
    public String getMedicalRecordNo() { return medicalRecordNo; }
    public String getBloodGroup() { return bloodGroup; }
    public String getAllergy() { return allergy; }

    public void setAccountID(int accountID) { this.accountID = accountID; }
    public void setMedicalRecordNo(String medicalRecordNo) { this.medicalRecordNo = medicalRecordNo; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }
    public void setAllergy(String allergy) { this.allergy = allergy; }
}
