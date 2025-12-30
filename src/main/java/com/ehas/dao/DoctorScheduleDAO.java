/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.DoctorSchedule;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

public class DoctorScheduleDAO {

    /**
     * Get schedule by doctorID and date
     */
    public DoctorSchedule getScheduleByDoctorAndDate(int doctorID, Date scheduleDate, Connection conn) throws SQLException {
        String sql = "SELECT * FROM doctorschedule WHERE doctorID = ? AND scheduleDate = ? AND isActive = TRUE";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, doctorID);
            stmt.setDate(2, scheduleDate);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    DoctorSchedule sched = new DoctorSchedule();
                    sched.setScheduleID(rs.getInt("scheduleID"));
                    sched.setDoctorID(rs.getInt("doctorID"));
                    sched.setScheduleDate(rs.getString("scheduleDate"));
                    sched.setIsActive(rs.getBoolean("isActive"));
                    return sched;
                }
            }
        }
        return null;
    }

    /**
     * Create new schedule
     * Returns generated scheduleID
     */
    public int createSchedule(DoctorSchedule sched, Connection conn) throws SQLException {
        String sql = "INSERT INTO doctorschedule (doctorID, scheduleDate, isActive) VALUES (?, ?, ?) RETURNING scheduleID";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, sched.getDoctorID());
            stmt.setDate(2, Date.valueOf(sched.getScheduleDate())); // convert string to SQL Date
            stmt.setBoolean(3, sched.isIsActive());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("scheduleID");
                }
            }
        }
        return 0;
    }
}


