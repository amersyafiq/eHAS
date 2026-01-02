/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Doctor;
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

    private static final String GET_DOCTORS_BY_SPECIALITY = 
        "SELECT ACCOUNTID, LICENSENO, SPECIALITYID FROM DOCTOR WHERE SPECIALITYID = ? ";

    // Get doctors by speciality
    public List<Doctor> getDoctorsBySpeciality(int specialityId) {
        List<Doctor> doctors = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_DOCTORS_BY_SPECIALITY);
            pstmt.setInt(1, specialityId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                doctors.add(extractDoctor(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctors;
    }

    private Doctor extractDoctor(ResultSet rs) throws SQLException {
        int accountId = rs.getInt("accountid");
        String licenseNo = rs.getString("licenseno");
        int specialityId = rs.getInt("specialityid");
        
        return new Doctor(accountId, licenseNo, specialityId);
    }
}


