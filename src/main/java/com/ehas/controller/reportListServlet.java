package com.ehas.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

import com.ehas.util.DBConnection;

@WebServlet("/Admin/report")
public class reportListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> reports = new ArrayList<>();

      String sql = "SELECT a.appointmentid, " +
             "acc.fullname AS patient_name, " +
             "d.fullname AS doctor_name, " +
             "s.specialityname AS specialty_name, " + // Match ERD 'specialityname'
             "a.createdat AS appointmentdate, " +    // Match ERD 'createdat'
             "a.status, " +
             "a.notes AS consultation_notes " +      // Notes are in 'appointment' table
             "FROM appointment a " +
             "JOIN account acc ON a.patientid = acc.accountid " +
             "LEFT JOIN doctor doc ON a.doctorid = doc.accountid " +
             "LEFT JOIN account d ON doc.accountid = d.accountid " +
             "LEFT JOIN speciality s ON doc.specialityid = s.specialityid " + // Match 'speciality' table
             "ORDER BY a.createdat DESC";

        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("appointmentid", rs.getInt("appointmentid"));
                row.put("patient_name", rs.getString("patient_name"));

                String doctor = rs.getString("doctor_name");
                row.put("doctor_name", doctor != null ? doctor : "-");

                String specialty = rs.getString("specialty_name");
                row.put("specialty_name", specialty != null ? specialty : "-");

                java.sql.Timestamp apptDate = rs.getTimestamp("appointmentdate");
                row.put("appointmentdate", apptDate != null ? apptDate : null);

                row.put("status", rs.getString("status"));

                String notes = rs.getString("consultation_notes");
                row.put("consultation_notes", notes != null ? notes : "-");

                reports.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("reports", reports);
        request.getRequestDispatcher("/views/Admin/report.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    public String getServletInfo() {
        return "Health Report List Servlet";
    }
}
