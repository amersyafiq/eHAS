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

@WebServlet(name = "invoiceListServlet", urlPatterns = {"/Admin/invoice"})
public class invoiceListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> invoices = new ArrayList<>();

        // SQL FIX: Pulling billing info (amount, status, date) instead of consultation notes
        String sql = "SELECT a.appointmentid, " +
                     "acc.fullname AS patient_name, " +
                     "a.createdat AS billing_date, " +
                     "a.totalamount, " +
                     "a.billstatus " +
                     "FROM appointment a " +
                     "JOIN account acc ON a.patientid = acc.accountid " +
                     "ORDER BY a.createdat DESC";

        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                // These keys MUST match the ${inv.variable} in your invoice.jsp
                row.put("appointmentid", rs.getInt("appointmentid"));
                row.put("patient_name", rs.getString("patient_name"));
                row.put("billing_date", rs.getTimestamp("billing_date"));
                row.put("totalamount", rs.getDouble("totalamount"));
                row.put("billstatus", rs.getString("billstatus"));
                
                invoices.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Setting attribute to 'invoices' to match <c:forEach items="${invoices}">
        request.setAttribute("invoices", invoices);
        
        // This path looks for /Admin/invoice.jsp in your web root
        request.getRequestDispatcher("/Admin/invoice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}