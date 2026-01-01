/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Patient;
import com.ehas.model.Speciality;
import com.ehas.util.DBConnection;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author SYAFIQ
 */
public class SpecialityDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String GET_ALL_SPECIALITIES = 
        "SELECT specialityid, specialityname, department FROM speciality ORDER BY specialityname";
    
    private static final String GET_SPECIALITY_BY_ID = 
        "SELECT specialityid, specialityname, department FROM speciality WHERE specialityid = ?";

    // Get all specialities
    public List<Speciality> getAllSpecialities() {
        List<Speciality> specialities = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_ALL_SPECIALITIES);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                specialities.add(extractSpeciality(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return specialities;
    }

    // Get speciality by ID
    public Speciality getSpecialityById(int specialityId) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_SPECIALITY_BY_ID);
            pstmt.setInt(1, specialityId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Speciality speciality = extractSpeciality(rs);
                
                rs.close();
                pstmt.close();
                conn.close();
                
                return speciality;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Speciality extractSpeciality(ResultSet rs) throws SQLException {
        int specialityId = rs.getInt("specialityid");
        String specialityName = rs.getString("specialityname");
        String department = rs.getString("department");
        
        return new Speciality(specialityId, specialityName, department);
    }
}
