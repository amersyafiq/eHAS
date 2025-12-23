/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Patient;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;

/**
 *
 * @author ASUS
 */
public class PatientDAO {
    private PreparedStatement pstmt = null;

    private static final String INSERT_PATIENT_SQL =
        "INSERT INTO Patient (accountID, medicalRecordNo) VALUES (?, ?)";

    public void createPatient(Patient patient, Connection conn) {
        try {
            pstmt = conn.prepareStatement(INSERT_PATIENT_SQL);
            
            pstmt.setInt(1, patient.getAccountID());
            pstmt.setString(2, generateMRN(patient.getAccountID()));
            pstmt.executeUpdate();

            pstmt.close();

        } catch (SQLException e) {
            System.err.println("Error while inserting user: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // For creating fake MRN
    public static String generateMRN(int accountID) {
        LocalDate today = LocalDate.now();

        String yy = String.format("%02d", today.getYear() % 100);
        String mm = String.format("%02d", today.getMonthValue());
        String seq = String.format("%05d", accountID);

        return "PMC-" + yy + mm + "-" + seq;
    }

}
