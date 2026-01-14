/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Appointment;
import com.ehas.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;

public class AppointmentDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final String INSERT_APPOINTMENT = 
        "INSERT INTO APPOINTMENT (CONCERN, PATIENTID, DOCTORID, TIMESLOTID, FOLLOWUPAPPOINTMENTID) " +
        "VALUES (?, ?, ?, ?, ?)";
    
    private static final String GET_APPOINTMENT_BY_ID = 
        "SELECT appointmentid, status, concern, patientid, doctorid, timeslotid, " +
        "diagnosis, treatment, notes, followupappointmentid, consultationfee, " +
        "treatmentfee, totalamount, createdat " +
        "FROM appointment WHERE appointmentid = ?";
    
    private static final String UPDATE_APPOINTMENT_STATUS = 
        "UPDATE APPOINTMENT SET STATUS = ? WHERE APPOINTMENTID = ?";

    private static final String UPDATE_APPOINTMENT_TIMESLOT = 
        "UPDATE APPOINTMENT SET TIMESLOTID = ? WHERE APPOINTMENTID = ?";;
    
    private static final String UPDATE_APPOINTMENT_CONSULTATION = 
        "UPDATE APPOINTMENT SET DIAGNOSIS = ?, TREATMENT = ?, NOTES = ?, STATUS = ? " +
        "WHERE APPOINTMENTID = ?";
    
    private static final String UPDATE_APPOINTMENT_FOLLOWUP = 
        "UPDATE APPOINTMENT SET FOLLOWUPAPPOINTMENTID = ? WHERE APPOINTMENTID = ?";
    
    // Create new appointment
    public boolean createAppointment(Appointment appointment) {
        try {
            conn = DBConnection.createConnection();

            pstmt = conn.prepareStatement(INSERT_APPOINTMENT);
            pstmt.setString(1, appointment.getConcern());
            pstmt.setInt(2, appointment.getPatientID());
            pstmt.setInt(3, appointment.getDoctorID());
            pstmt.setInt(4, appointment.getTimeslotID());
            if (appointment.getFollowUpAppointmentID() > 0) {
                pstmt.setInt(5, appointment.getFollowUpAppointmentID());
            } else {
                pstmt.setNull(5, java.sql.Types.INTEGER);
            }
            int rowsAffected = pstmt.executeUpdate();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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

    // Update appointment timeslot
    public boolean updateAppointmentTimeslot(int appointmentId, int timeslotID) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_APPOINTMENT_TIMESLOT);
            
            pstmt.setInt(1, timeslotID);
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

    // Update appointment consultation
    public boolean updateAppointmentConsultation(Appointment appointment) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_APPOINTMENT_CONSULTATION);
            
            pstmt.setString(1, appointment.getDiagnosis());
            pstmt.setString(2, appointment.getTreatment());
            pstmt.setString(3, appointment.getNotes());
            pstmt.setString(4, appointment.getStatus());
            pstmt.setInt(5, appointment.getAppointmentID());
            
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
        
        Integer followupAppointmentId = rs.getInt("followupappointmentid");
        if (rs.wasNull()) { followupAppointmentId = null; }
        
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