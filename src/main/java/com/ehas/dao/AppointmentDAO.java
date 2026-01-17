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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    private static final String UPDATE_APPOINTMENT_FEE = 
        "UPDATE APPOINTMENT SET CONSULTATIONFEE = ?, TREATMENTFEE = ?, TOTALAMOUNT = ? " +
        "WHERE APPOINTMENTID = ?";

    private static final String UPDATE_APPOINTMENT_BILLSTATUS = 
        "UPDATE APPOINTMENT SET BILLSTATUS = 'PAID' " +
        "WHERE APPOINTMENTID = ?";
    
    private static final String GET_TOTAL_SUM = "SELECT SUM(%s) FROM appointment WHERE billstatus = 'PAID'";
    private static final String COUNT_BY_STATUS = "SELECT COUNT(*) FROM appointment WHERE status = ?";
    private static final String GET_TOTAL_COUNT = "SELECT COUNT(*) FROM appointment";
    private static final String GET_SPECIALTY_STATS = 
        "SELECT s.specialityname, s.department, COUNT(a.appointmentid) as app_count " +
        "FROM appointment a " +
        "JOIN doctor d ON a.doctorid = d.accountid " +
        "JOIN speciality s ON d.specialityid = s.specialityid " +
        "GROUP BY s.specialityname, s.department " +
        "ORDER BY app_count DESC";
    
    // Count appointments by their status (e.g., 'Completed', 'Cancelled')
    public int countByStatus(String status) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM appointment WHERE status = ?";
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) count = rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public double getTotalSum(String columnName) {
    double sum = 0;
    // Use String.format to safely inject the column name into your constant
    String query = String.format(GET_TOTAL_SUM, columnName); 
    try (Connection conn = DBConnection.createConnection();
         PreparedStatement ps = conn.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) sum = rs.getDouble(1);
    } catch (SQLException e) { e.printStackTrace(); }
    return sum;
}

    // Get total count of all appointments
    public int getTotalCount() {
        int count = 0;
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement pstmt = conn.prepareStatement(GET_TOTAL_COUNT);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // Get Specialty Performance Breakdown
    public List<Map<String, Object>> getAppointmentsBySpecialty() {
        List<Map<String, Object>> list = new ArrayList<>();
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement pstmt = conn.prepareStatement(GET_SPECIALTY_STATS);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("specialityname", rs.getString("specialityname"));
                map.put("department", rs.getString("department"));
                map.put("appointmentCount", rs.getInt("app_count"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
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

    public boolean updateAppointmentFee(Appointment appointment) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_APPOINTMENT_FEE);
            
            pstmt.setDouble(1, appointment.getConsultationFee());
            pstmt.setDouble(2, appointment.getTreatmentFee());
            pstmt.setDouble(3, appointment.getTotalAmount());
            pstmt.setInt(4, appointment.getAppointmentID());
            
            int rowsAffected = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateAppointmentBillStatus(int appointmentID) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_APPOINTMENT_BILLSTATUS);
            
            pstmt.setInt(1, appointmentID);
            
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