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
import jakarta.servlet.RequestDispatcher;

import com.ehas.util.DBConnection;

public class reportListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Map<String, Object>> reports = new ArrayList<>();

        String sql = "SELECT a.appointmentid, a.status, a.concern, a.totalamount, a.billstatus, " +
                     "acc.fullname as patient_name, dacc.fullname as doctor_name, s.specialityname " +
                     "FROM appointment a " +
                     "JOIN account acc ON a.patientid = acc.accountid " +
                     "JOIN doctor doc ON a.doctorid = doc.accountid " +
                     "JOIN account dacc ON doc.accountid = dacc.accountid " +
                     "JOIN speciality s ON doc.specialityid = s.specialityid " +
                     "ORDER BY a.createdat DESC";

        try (Connection conn = DBConnection.createConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("appointmentid", rs.getInt("appointmentid"));
                row.put("status", rs.getString("status"));
                row.put("concern", rs.getString("concern"));
                row.put("totalamount", rs.getDouble("totalamount"));
                row.put("billstatus", rs.getString("billstatus"));
                row.put("patient_name", rs.getString("patient_name"));
                row.put("doctor_name", rs.getString("doctor_name"));
                row.put("specialityname", rs.getString("specialityname"));

                reports.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("reports", reports);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/Admin/report.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    public String getServletInfo() {
        return "Report List Servlet";
    }
}