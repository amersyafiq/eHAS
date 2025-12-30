package com.ehas.dao;

import com.ehas.model.Timeslot;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class TimeslotDAO {

    private static final SimpleDateFormat INPUT_FORMAT = new SimpleDateFormat("hh:mm a"); // "08:30 AM"
    private static final SimpleDateFormat SQL_TIME_FORMAT = new SimpleDateFormat("HH:mm:ss");

    // Get timeslot by scheduleID and startTime
    public Timeslot getTimeslotByScheduleAndTime(int scheduleID, String startTime, Connection conn) throws SQLException {
        String sql = "SELECT * FROM timeslot WHERE scheduleID = ? AND startTime = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, scheduleID);
            stmt.setTime(2, convertToSqlTime(startTime));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Timeslot slot = new Timeslot();
                    slot.setTimeslotID(rs.getInt("timeslotID"));
                    slot.setScheduleID(rs.getInt("scheduleID"));
                    slot.setStartTime(rs.getString("startTime"));
                    slot.setEndTime(rs.getString("endTime"));
                    slot.setIsAvailable(rs.getBoolean("isAvailable"));
                    return slot;
                }
            }
        }
        return null;
    }

    // Insert a new timeslot
    public int createTimeslot(Timeslot slot, Connection conn) throws SQLException {
        String sql = "INSERT INTO timeslot (scheduleID, startTime, endTime, isAvailable) VALUES (?, ?, ?, ?) RETURNING timeslotID";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, slot.getScheduleID());
            stmt.setTime(2, convertToSqlTime(slot.getStartTime()));
            stmt.setTime(3, convertToSqlTime(slot.getEndTime()));
            stmt.setBoolean(4, slot.isIsAvailable());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt("timeslotID");
            }
        }
        return 0;
    }

    // Converts "08:30 a.m." or "2:00 p.m." to java.sql.Time
    private Time convertToSqlTime(String timeStr) {
        try {
            java.util.Date parsed = INPUT_FORMAT.parse(timeStr.replace(".", "").toUpperCase()); // "08:30 a.m." -> "08:30 AM"
            return new Time(parsed.getTime());
        } catch (ParseException e) {
            throw new IllegalArgumentException("Invalid time format: " + timeStr, e);
        }
    }
}
