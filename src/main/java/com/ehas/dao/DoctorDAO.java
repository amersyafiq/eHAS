/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Doctor;
import com.ehas.model.Patient;
import com.ehas.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String INSERT_DOCTOR_SQL =
        "INSERT INTO Doctor (accountID, licenseNo, specialityID) VALUES (?, ?, ?)";

    private static final String DELETE_DOCTOR_SQL =
        "DELETE FROM DOCTOR WHERE ACCOUNTID = ? ";

    public boolean createDoctor(Doctor doctor) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(INSERT_DOCTOR_SQL);
            
            pstmt.setInt(1, doctor.getAccountID());
            pstmt.setString(2, doctor.getLicenseNo());
            pstmt.setInt(3, doctor.getSpecialityID());
            int rowsAffected = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error while inserting user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteDoctor(int accountID) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(DELETE_DOCTOR_SQL);
            
            pstmt.setInt(1, accountID);;
            int rowsAffected = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error while deleting user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    private Doctor extractDoctor(ResultSet rs) throws SQLException {
        int accountId = rs.getInt("accountid");
        String licenseNo = rs.getString("licenseno");
        int specialityId = rs.getInt("specialityid");
        
        return new Doctor(accountId, licenseNo, specialityId);
    }
}


