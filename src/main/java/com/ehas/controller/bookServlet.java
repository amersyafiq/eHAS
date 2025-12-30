package com.ehas.controller;

import com.ehas.model.Doctor;
import com.ehas.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "bookServlet", urlPatterns = {"/appointment/book"})
public class bookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get parameters
        String hospital = request.getParameter("hospital");
        String doctorName = request.getParameter("doctor");
        String appointmentDate = request.getParameter("appointmentDate");

        // Set attributes for JSP
        request.setAttribute("selectedHospital", hospital);
        request.setAttribute("selectedDoctor", doctorName);
        request.setAttribute("selectedDate", appointmentDate);

        // 2. Fetch ALL doctors (no hospital filter)
        List<Doctor> doctors = new ArrayList<>();
        try (Connection conn = DBConnection.createConnection()) {
            String sql = "SELECT d.accountid, d.licenseno " +
                         "FROM doctor d"; // No WHERE clause
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Doctor doc = new Doctor(
                        rs.getInt("accountid"),
                        rs.getString("licenseno"),
                        0 // specialityID not used
                );
                doctors.add(doc);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("doctors", doctors);

        // 3. Fetch booked times if doctor + date are selected
        List<String> bookedSlots = new ArrayList<>();
        if (doctorName != null && !doctorName.isEmpty() && 
            appointmentDate != null && !appointmentDate.isEmpty()) {
            try (Connection conn = DBConnection.createConnection()) {
                String sql = "SELECT t.starttime " +
                             "FROM timeslot t " +
                             "JOIN doctorschedule s ON t.scheduleid = s.scheduleid " +
                             "JOIN doctor d ON s.doctorid = d.accountid " +
                             "WHERE d.licenseno = ? AND s.scheduledate = ? AND t.isavailable = false";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, doctorName);
                ps.setString(2, appointmentDate);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    bookedSlots.add(rs.getString("starttime"));
                }
                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        request.setAttribute("bookedSlots", bookedSlots);

        // 4. Forward to JSP
        RequestDispatcher view = request.getRequestDispatcher("/views/patient/appointment/book.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
