/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.DoctorSchedule;
import com.ehas.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.time.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorScheduleDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String CHECK_SCHEDULE_DATE =
        "SELECT COUNT(*) FROM DOCTORSCHEDULE WHERE SCHEDULEDATE = ? AND ISACTIVE = ? AND DOCTORID = ?";
    
    private static final String INSERT_SCHEDULE_DATE = 
        "INSERT INTO doctorschedule (scheduledate, isactive, doctorid) " +
        "VALUES (?, ?, ?)";
    
    private static final String UPDATE_SCHEDULE_STATUS = 
        "UPDATE doctorschedule SET isactive = ? WHERE scheduleid = ?";

    // Create new schedule
    public boolean createSchedule(DoctorSchedule schedule) {
        try {
            conn = DBConnection.createConnection();
            
            pstmt = conn.prepareStatement(CHECK_SCHEDULE_DATE);
            pstmt.setDate(1, java.sql.Date.valueOf(schedule.getScheduleDate()));
            pstmt.setBoolean(2, schedule.isActive());
            pstmt.setInt(3, schedule.getDoctorID());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    return false;
                }
            }

            pstmt = conn.prepareStatement(INSERT_SCHEDULE_DATE);
            pstmt.setDate(1, java.sql.Date.valueOf(schedule.getScheduleDate()));
            pstmt.setBoolean(2, schedule.isActive());
            pstmt.setInt(3, schedule.getDoctorID());
            
            int affectedRows = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update schedule active status
    public boolean updateScheduleStatus(int scheduleId, boolean isActive) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_SCHEDULE_STATUS);
            
            pstmt.setBoolean(1, isActive);
            pstmt.setInt(2, scheduleId);
            
            int rowsAffected = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    private DoctorSchedule extractDoctorSchedule(ResultSet rs) throws SQLException {
        int scheduleId = rs.getInt("scheduleid");
        LocalDate scheduleDate = rs.getObject("scheduledate", LocalDate.class);
        boolean isActive = rs.getBoolean("isactive");
        int doctorId = rs.getInt("doctorid");
        
        return new DoctorSchedule(scheduleId, scheduleDate, isActive, doctorId);
    }
}


