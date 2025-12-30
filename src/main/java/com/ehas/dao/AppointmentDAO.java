/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Appointment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AppointmentDAO {

    /**
     * Insert a new appointment into the database.
     * Only basic fields are required: patientID, doctorID, timeslotID, status.
     */
    public boolean createAppointment(Appointment appt, Connection conn) throws SQLException {
        String sql = "INSERT INTO appointment "
                   + "(patientID, doctorID, timeslotID, status, concern, diagnosis, treatment, notes, followUpAppointmentID, consultationFee, treatmentFee, totalAmount, createdAt) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, appt.getPatientID());
            stmt.setInt(2, 11);
            stmt.setInt(3, appt.getTimeslotID());
            stmt.setString(4, appt.getStatus() != null ? appt.getStatus() : "Pending");
            stmt.setString(5, appt.getConcern() != null ? appt.getConcern() : "");
            stmt.setString(6, appt.getDiagnosis() != null ? appt.getDiagnosis() : "");
            stmt.setString(7, appt.getTreatment() != null ? appt.getTreatment() : "");
            stmt.setString(8, appt.getNotes() != null ? appt.getNotes() : "");
            
            if (appt.getFollowUpAppointmentID() != null) {
                stmt.setInt(9, appt.getFollowUpAppointmentID());
            } else {
                stmt.setNull(9, java.sql.Types.INTEGER);
            }

            stmt.setDouble(10, appt.getConsultationFee());
            stmt.setDouble(11, appt.getTreatmentFee());
            stmt.setDouble(12, appt.getTotalAmount());

            int rows = stmt.executeUpdate();

            // Retrieve generated appointmentID
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int appointmentID = generatedKeys.getInt(1);
                    appt.setAppointmentID(appointmentID);
                }
            }

            return rows > 0;
        }
    }

    /**
     * Optional: Get appointment by ID
     */
    public Appointment getAppointmentByID(int appointmentID, Connection conn) throws SQLException {
        String sql = "SELECT * FROM appointment WHERE appointmentID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appointmentID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Appointment appt = new Appointment();
                    appt.setAppointmentID(rs.getInt("appointmentID"));
                    appt.setPatientID(rs.getInt("patientID"));
                    appt.setDoctorID(rs.getInt("doctorID"));
                    appt.setTimeslotID(rs.getInt("timeslotID"));
                    appt.setStatus(rs.getString("status"));
                    appt.setConcern(rs.getString("concern"));
                    appt.setDiagnosis(rs.getString("diagnosis"));
                    appt.setTreatment(rs.getString("treatment"));
                    appt.setNotes(rs.getString("notes"));
                    appt.setFollowUpAppointmentID(rs.getObject("followUpAppointmentID") != null ? rs.getInt("followUpAppointmentID") : null);
                    appt.setConsultationFee(rs.getDouble("consultationFee"));
                    appt.setTreatmentFee(rs.getDouble("treatmentFee"));
                    appt.setTotalAmount(rs.getDouble("totalAmount"));
                    appt.setCreatedAt(rs.getString("createdAt"));
                    return appt;
                }
            }
        }
        return null;
    }
}
