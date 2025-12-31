/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.model;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
/**
 *
 * @author SYAFIQ
 */
public class Account implements Serializable {
    private int accountID;
    private String fullName, password, ic_passport, email, phoneNo, gender, accountType, picturePath;
    private LocalDate dateOfBirth;
    private LocalDateTime createdAt, updatedAt;
    
    public Account() { }
    public Account(int accountID, String fullName, String password, String ic_passport, String email, String phoneNo, String gender, LocalDate dateOfBirth, String accountType, String picturePath, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.accountID = accountID;
        this.fullName = fullName;
        this.password = password;
        this.ic_passport = ic_passport;
        this.email = email;
        this.phoneNo = phoneNo; 
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.accountType = accountType;
        this.picturePath = picturePath;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getAccountID() { return accountID; }
    public String getFullName() { return fullName; }
    public String getPassword() { return password; }
    public String getIc_passport() { return ic_passport; }
    public String getEmail() { return email; }
    public String getPhoneNo() { return phoneNo; }
    public String getGender() { return gender; }
    public LocalDate getDateOfBirth() { return dateOfBirth; }
    public String getAccountType() { return accountType; }
    public String getPicturePath() { return picturePath; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }

    public void setAccountID(int accountID) { this.accountID = accountID; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setPassword(String password) { this.password = password; }
    public void setIc_passport(String ic_passport) { this.ic_passport = ic_passport; }
    public void setEmail(String email) { this.email = email; }
    public void setPhoneNo(String phoneNo) { this.phoneNo = phoneNo; }
    public void setGender(String gender) { this.gender = gender; }
    public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    public void setAccountType(String accountType) { this.accountType = accountType; }
    public void setPicturePath(String picturePath) { this.picturePath = picturePath; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}