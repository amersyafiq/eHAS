package com.ehas.dao;

import com.ehas.model.Timeslot;
import com.ehas.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class TimeslotDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String GET_AVAILABLE_TIMESLOTS_BY_SCHEDULE = 
        "SELECT timeslotid, starttime, endtime, isavailable, scheduleid " +
        "FROM timeslot " +
        "WHERE scheduleid = ? AND isavailable = true " +
        "AND timeslotid NOT IN (" +
        "   SELECT timeslotid FROM appointment WHERE status != 'CANCELLED'" +
        ") " +
        "ORDER BY starttime";
    
    private static final String GET_TIMESLOT_BY_ID = 
        "SELECT timeslotid, starttime, endtime, isavailable, scheduleid " +
        "FROM timeslot " +
        "WHERE timeslotid = ?";
    
    private static final String GET_ALL_TIMESLOTS_BY_SCHEDULE = 
        "SELECT timeslotid, starttime, endtime, isavailable, scheduleid " +
        "FROM timeslot " +
        "WHERE scheduleid = ? " +
        "ORDER BY starttime";
    
    private static final String INSERT_TIMESLOT = 
        "INSERT INTO timeslot (starttime, endtime, isavailable, scheduleid) " +
        "VALUES (?, ?, ?, ?)";
    
    private static final String UPDATE_TIMESLOT_AVAILABILITY = 
        "UPDATE timeslot SET isavailable = ? WHERE timeslotid = ?";

    // Get available timeslots by schedule (excludes booked slots)
    public List<Timeslot> getAvailableTimeslotsBySchedule(int scheduleId) {
        List<Timeslot> timeslots = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_AVAILABLE_TIMESLOTS_BY_SCHEDULE);
            pstmt.setInt(1, scheduleId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                timeslots.add(extractTimeslot(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return timeslots;
    }

    // Get all timeslots by schedule (includes unavailable)
    public List<Timeslot> getAllTimeslotsBySchedule(int scheduleId) {
        List<Timeslot> timeslots = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_ALL_TIMESLOTS_BY_SCHEDULE);
            pstmt.setInt(1, scheduleId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                timeslots.add(extractTimeslot(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return timeslots;
    }

    // Get timeslot by ID
    public Timeslot getTimeslotById(int timeslotId) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_TIMESLOT_BY_ID);
            pstmt.setInt(1, timeslotId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Timeslot timeslot = extractTimeslot(rs);
                
                rs.close();
                pstmt.close();
                conn.close();
                
                return timeslot;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create new timeslot
    public Timeslot createTimeslot(Timeslot timeslot) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(INSERT_TIMESLOT, Statement.RETURN_GENERATED_KEYS);
            
            // Convert LocalTime to java.sql.Time
            pstmt.setTime(1, Time.valueOf(timeslot.getStartTime()));
            pstmt.setTime(2, Time.valueOf(timeslot.getEndTime()));
            pstmt.setBoolean(3, timeslot.isAvailable());
            pstmt.setInt(4, timeslot.getTimeslotID());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int timeslotId = rs.getInt(1);
                    
                    rs.close();
                    pstmt.close();
                    conn.close();
                    
                    return getTimeslotById(timeslotId);
                }
            }
            
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update timeslot availability
    public boolean updateTimeslotAvailability(int timeslotId, boolean isAvailable) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_TIMESLOT_AVAILABILITY);
            
            pstmt.setBoolean(1, isAvailable);
            pstmt.setInt(2, timeslotId);
            
            int rowsAffected = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Timeslot extractTimeslot(ResultSet rs) throws SQLException {
        int timeslotId = rs.getInt("timeslotid");
        LocalTime startTime = rs.getObject("starttime", LocalTime.class);
        LocalTime endTime = rs.getObject("endtime", LocalTime.class);        
        boolean isAvailable = rs.getBoolean("isavailable");
        int scheduleId = rs.getInt("scheduleid");
        
        return new Timeslot(timeslotId, startTime, endTime, isAvailable, scheduleId);
    }
}
