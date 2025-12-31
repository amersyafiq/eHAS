/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.DoctorSchedule;
import com.ehas.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
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

    private static final String GET_SCHEDULES_BY_DOCTOR = 
        "SELECT scheduleid, scheduledate, isactive, doctorid " +
        "FROM doctorschedule " +
        "WHERE doctorid = ? AND isactive = true AND scheduledate >= CURRENT_DATE " +
        "ORDER BY scheduledate";
    
    private static final String GET_SCHEDULE_BY_ID = 
        "SELECT scheduleid, scheduledate, isactive, doctorid " +
        "FROM doctorschedule " +
        "WHERE scheduleid = ?";
    
    private static final String INSERT_SCHEDULE = 
        "INSERT INTO doctorschedule (scheduledate, isactive, doctorid) " +
        "VALUES (?, ?, ?)";
    
    private static final String UPDATE_SCHEDULE_STATUS = 
        "UPDATE doctorschedule SET isactive = ? WHERE scheduleid = ?";

    // Get active schedules by doctor
    public List<DoctorSchedule> getSchedulesByDoctor(int doctorId) {
        List<DoctorSchedule> schedules = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_SCHEDULES_BY_DOCTOR);
            pstmt.setInt(1, doctorId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                schedules.add(extractDoctorSchedule(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

    // Get schedule by ID
    public DoctorSchedule getScheduleById(int scheduleId) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_SCHEDULE_BY_ID);
            pstmt.setInt(1, scheduleId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                DoctorSchedule schedule = extractDoctorSchedule(rs);
                
                rs.close();
                pstmt.close();
                conn.close();
                
                return schedule;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create new schedule
    public DoctorSchedule createSchedule(DoctorSchedule schedule) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(INSERT_SCHEDULE, Statement.RETURN_GENERATED_KEYS);
            
            // Convert LocalDate to java.sql.Date
            pstmt.setDate(1, java.sql.Date.valueOf(schedule.getScheduleDate()));
            pstmt.setBoolean(2, schedule.isActive());
            pstmt.setInt(3, schedule.getScheduleID());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int scheduleId = rs.getInt(1);
                    
                    rs.close();
                    pstmt.close();
                    conn.close();
                    
                    return getScheduleById(scheduleId);
                }
            }
            
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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


