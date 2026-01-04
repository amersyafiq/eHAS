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

    private static final String GET_TIMESLOT_BY_ID = 
        "SELECT TIMESLOTID, STARTTIME, ENDTIME, ISAVAILABLE, SCHEDULEID " +
        "FROM TIMESLOT " +
        "WHERE TIMESLOTID = ?";

    private static final String CHECK_TIMESLOT = 
        "SELECT COUNT(*) FROM TIMESLOT WHERE STARTTIME = ? AND ENDTIME = ? AND ISAVAILABLE = ? AND SCHEDULEID = ? ";
    
    private static final String INSERT_TIMESLOT = 
        "INSERT INTO TIMESLOT (STARTTIME, ENDTIME, ISAVAILABLE, SCHEDULEID) " +
        "VALUES (?, ?, ?, ?)";
    
    private static final String UPDATE_TIMESLOT_AVAILABILITY = 
        "UPDATE TIMESLOT SET ISAVAILABLE = ? WHERE TIMESLOTID = ?";

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
    public boolean createTimeslot(Timeslot timeslot) {
        try {
            conn = DBConnection.createConnection();

            pstmt = conn.prepareStatement(CHECK_TIMESLOT);
            pstmt.setTime(1, Time.valueOf(timeslot.getStartTime()));
            pstmt.setTime(2, Time.valueOf(timeslot.getEndTime()));
            pstmt.setBoolean(3, timeslot.isAvailable());
            pstmt.setInt(4, timeslot.getScheduleID());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    return false;
                }
            }

            pstmt = conn.prepareStatement(INSERT_TIMESLOT);
            pstmt.setTime(1, Time.valueOf(timeslot.getStartTime()));
            pstmt.setTime(2, Time.valueOf(timeslot.getEndTime()));
            pstmt.setBoolean(3, timeslot.isAvailable());
            pstmt.setInt(4, timeslot.getScheduleID());
            
            int affectedRows = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();

            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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
