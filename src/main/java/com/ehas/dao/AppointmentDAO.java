/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Appointment;
import com.ehas.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String INSERT_APPOINTMENT = 
        "INSERT INTO appointment (status, concern, patientid, doctorid, timeslotid) " +
        "VALUES (?, ?, ?, ?, ?)";
    
    private static final String GET_APPOINTMENT_BY_ID = 
        "SELECT appointmentid, status, concern, patientid, doctorid, timeslotid, " +
        "diagnosis, treatment, notes, followupappointmentid, consultationfee, " +
        "treatmentfee, totalamount, createdat " +
        "FROM appointment WHERE appointmentid = ?";
    
    private static final String GET_APPOINTMENTS_BY_PATIENT = 
        "SELECT appointmentid, status, concern, patientid, doctorid, timeslotid, " +
        "diagnosis, treatment, notes, followupappointmentid, consultationfee, " +
        "treatmentfee, totalamount, createdat " +
        "FROM appointment WHERE patientid = ? ORDER BY createdat DESC";
    
    private static final String GET_APPOINTMENTS_BY_DOCTOR = 
        "SELECT appointmentid, status, concern, patientid, doctorid, timeslotid, " +
        "diagnosis, treatment, notes, followupappointmentid, consultationfee, " +
        "treatmentfee, totalamount, createdat " +
        "FROM appointment WHERE doctorid = ? ORDER BY createdat DESC";
    
    private static final String GET_APPOINTMENTS_BY_STATUS = 
        "SELECT appointmentid, status, concern, patientid, doctorid, timeslotid, " +
        "diagnosis, treatment, notes, followupappointmentid, consultationfee, " +
        "treatmentfee, totalamount, createdat " +
        "FROM appointment WHERE status = ? ORDER BY createdat DESC";
    
    private static final String UPDATE_APPOINTMENT_STATUS = 
        "UPDATE appointment SET status = ? WHERE appointmentid = ?";
    
    private static final String UPDATE_APPOINTMENT_DETAILS = 
        "UPDATE appointment SET diagnosis = ?, treatment = ?, notes = ?, " +
        "consultationfee = ?, treatmentfee = ?, totalamount = ? " +
        "WHERE appointmentid = ?";
    
    private static final String UPDATE_APPOINTMENT_FOLLOWUP = 
        "UPDATE appointment SET followupappointmentid = ? WHERE appointmentid = ?";
    
    private static final String CHECK_TIMESLOT_AVAILABILITY = 
        "SELECT COUNT(*) as count FROM appointment " +
        "WHERE timeslotid = ? AND status != 'CANCELLED'";

    // Create new appointment
    public Appointment createAppointment(Appointment appointment) {
        try {
            conn = DBConnection.createConnection();
            
            // First check if timeslot is already booked
            if (!isTimeslotAvailable(appointment.getTimeslotID())) {
                conn.close();
                return null; // Timeslot already booked
            }
            
            pstmt = conn.prepareStatement(INSERT_APPOINTMENT, Statement.RETURN_GENERATED_KEYS);
            
            pstmt.setString(1, appointment.getStatus());
            pstmt.setString(2, appointment.getConcern());
            pstmt.setInt(3, appointment.getPatientID());
            pstmt.setInt(4, appointment.getDoctorID());
            pstmt.setInt(5, appointment.getTimeslotID());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int appointmentId = rs.getInt(1);
                    
                    rs.close();
                    pstmt.close();
                    conn.close();
                    
                    return getAppointmentById(appointmentId);
                }
            }
            
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get appointment by ID
    public Appointment getAppointmentById(int appointmentId) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_APPOINTMENT_BY_ID);
            pstmt.setInt(1, appointmentId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Appointment appointment = extractAppointment(rs);
                
                rs.close();
                pstmt.close();
                conn.close();
                
                return appointment;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get appointments by patient
    public List<Appointment> getAppointmentsByPatient(int patientId) {
        List<Appointment> appointments = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_APPOINTMENTS_BY_PATIENT);
            pstmt.setInt(1, patientId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                appointments.add(extractAppointment(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    // Get appointments by doctor
    public List<Appointment> getAppointmentsByDoctor(int doctorId) {
        List<Appointment> appointments = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_APPOINTMENTS_BY_DOCTOR);
            pstmt.setInt(1, doctorId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                appointments.add(extractAppointment(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    // Get appointments by status
    public List<Appointment> getAppointmentsByStatus(String status) {
        List<Appointment> appointments = new ArrayList<>();
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(GET_APPOINTMENTS_BY_STATUS);
            pstmt.setString(1, status);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                appointments.add(extractAppointment(rs));
            }
            
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    // Update appointment status
    public boolean updateAppointmentStatus(int appointmentId, String status) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_APPOINTMENT_STATUS);
            
            pstmt.setString(1, status);
            pstmt.setInt(2, appointmentId);
            
            int rowsAffected = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update appointment details (diagnosis, treatment, etc.)
    public boolean updateAppointmentDetails(int appointmentId, String diagnosis, 
            String treatment, String notes, Double consultationFee, 
            Double treatmentFee, Double totalAmount) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_APPOINTMENT_DETAILS);
            
            pstmt.setString(1, diagnosis);
            pstmt.setString(2, treatment);
            pstmt.setString(3, notes);
            pstmt.setDouble(4, consultationFee != null ? consultationFee : 0.0);
            pstmt.setDouble(5, treatmentFee != null ? treatmentFee : 0.0);
            pstmt.setDouble(6, totalAmount != null ? totalAmount : 0.0);
            pstmt.setInt(7, appointmentId);
            
            int rowsAffected = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update follow-up appointment
    public boolean updateFollowupAppointment(int appointmentId, Integer followupAppointmentId) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_APPOINTMENT_FOLLOWUP);
            
            if (followupAppointmentId != null) {
                pstmt.setInt(1, followupAppointmentId);
            } else {
                pstmt.setNull(1, Types.INTEGER);
            }
            pstmt.setInt(2, appointmentId);
            
            int rowsAffected = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check if timeslot is available (not already booked)
    public boolean isTimeslotAvailable(int timeslotId) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(CHECK_TIMESLOT_AVAILABILITY);
            pstmt.setInt(1, timeslotId);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                
                rs.close();
                pstmt.close();
                conn.close();
                
                return count == 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Appointment extractAppointment(ResultSet rs) throws SQLException {
        int appointmentId = rs.getInt("appointmentid");
        String status = rs.getString("status");
        String concern = rs.getString("concern");
        int patientId = rs.getInt("patientid");
        int doctorId = rs.getInt("doctorid");
        int timeslotId = rs.getInt("timeslotid");
        String diagnosis = rs.getString("diagnosis");
        String treatment = rs.getString("treatment");
        String notes = rs.getString("notes");
        
        // Handle nullable integer
        Integer followupAppointmentId = rs.getInt("followupappointmentid");
        if (rs.wasNull()) { followupAppointmentId = null; }
        
        // Handle nullable doubles
        Double consultationFee = rs.getDouble("consultationfee");
        if (rs.wasNull()) { consultationFee = null; }
        
        Double treatmentFee = rs.getDouble("treatmentfee");
        if (rs.wasNull()) { treatmentFee = null; }
        
        Double totalAmount = rs.getDouble("totalamount");
        if (rs.wasNull()) { totalAmount = null; }
        
        LocalDate createdAt = rs.getObject("createdat", LocalDate.class);
        
        return new Appointment(appointmentId, status, concern, patientId, doctorId, 
                timeslotId, diagnosis, treatment, notes, followupAppointmentId, 
                consultationFee, treatmentFee, totalAmount, createdAt);
    }
}