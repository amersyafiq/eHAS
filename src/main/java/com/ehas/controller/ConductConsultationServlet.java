/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.ehas.dao.ConsultationDAO;
import com.ehas.model.Account;
import com.ehas.model.Consultation;
import com.ehas.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author eHAS Team
 */
@WebServlet("/doctor/consultation")
public class ConductConsultationServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     * Displays the consultation form.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("/views/doctor/consultation.jsp");
        view.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Processes the consultation form submission.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        
        try {
            // Get logged-in doctor from session
            HttpSession session = request.getSession();
            Account loggedUser = (Account) session.getAttribute("loggedUser");
            
            if (loggedUser == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            int doctorId = loggedUser.getAccountID();
            
            // Read form parameters
            String appointmentIdStr = request.getParameter("appointmentId");
            String symptoms = request.getParameter("symptoms");
            String diagnosis = request.getParameter("diagnosis");
            String treatment = request.getParameter("treatment");
            String notes = request.getParameter("notes");
            
            // Validate required fields
            if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty()) {
                request.setAttribute("error", "Appointment ID is required.");
                RequestDispatcher view = request.getRequestDispatcher("/views/doctor/consultation.jsp");
                view.forward(request, response);
                return;
            }
            
            int appointmentId;
            try {
                appointmentId = Integer.parseInt(appointmentIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Appointment ID format.");
                RequestDispatcher view = request.getRequestDispatcher("/views/doctor/consultation.jsp");
                view.forward(request, response);
                return;
            }
            
            // Get current date/time for consultation date
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String consultationDate = now.format(formatter);
            
            // Create Consultation object
            Consultation consultation = new Consultation();
            consultation.setAppointmentId(appointmentId);
            consultation.setDoctorId(doctorId);
            consultation.setSymptoms(symptoms != null ? symptoms : "");
            consultation.setDiagnosis(diagnosis != null ? diagnosis : "");
            consultation.setTreatment(treatment != null ? treatment : "");
            consultation.setNotes(notes != null ? notes : "");
            consultation.setConsultationDate(consultationDate);
            
            // Get database connection and call DAO
            conn = DBConnection.createConnection();
            ConsultationDAO consultationDAO = new ConsultationDAO();
            consultationDAO.createConsultation(consultation, conn);
            
            // Redirect to doctor appointment list (adjust URL as needed)
            response.sendRedirect(request.getContextPath() + "/doctor/appointments");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing the consultation: " + e.getMessage());
            RequestDispatcher view = request.getRequestDispatcher("/views/doctor/consultation.jsp");
            view.forward(request, response);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception ignored) {}
            }
        }
    }
}
