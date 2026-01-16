/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;

import com.ehas.dao.AppointmentDAO;
import com.ehas.model.Account;
import com.ehas.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@WebServlet("/appointment/consultation")
public class appointmentConsultationServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
        appointmentDAO = new AppointmentDAO();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            Account account = (Account) session.getAttribute("loggedUser");
            String accountType = account.getAccountType();
            if ("patient".equalsIgnoreCase(accountType)) {
                request.getRequestDispatcher("/views/patient/appointment.list.jsp").forward(request, response);
                return;
            } else if ("doctor".equalsIgnoreCase(accountType)) {
                request.getRequestDispatcher("/views/doctor/appointment.consultation.jsp").forward(request, response);
                return;
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            String diagnosis = request.getParameter("diagnosis");
            String treatment = request.getParameter("treatment");
            String notes = request.getParameter("notes");
            
            String enableFollowUp = request.getParameter("enableFollowUp");
            int patientID = Integer.parseInt(request.getParameter("patientID"));
            int doctorID = Integer.parseInt(request.getParameter("doctorID"));
            String followUpTimeslotStr = request.getParameter("timeslotID");
            String concern = request.getParameter("concern");

            Appointment appointment = new Appointment();
            appointment.setAppointmentID(appointmentID);
            appointment.setDiagnosis(diagnosis);
            appointment.setTreatment(treatment);
            appointment.setNotes(notes);
            appointment.setStatus("COMPLETED");

            boolean updateSuccess = appointmentDAO.updateAppointmentConsultation(appointment);

            if (updateSuccess) {
                if ("true".equals(enableFollowUp) && followUpTimeslotStr != null && !followUpTimeslotStr.isEmpty()) {
                    int followUpTimeslotID = Integer.parseInt(followUpTimeslotStr);
                    
                    Appointment followUpAppt = new Appointment();
                    followUpAppt.setPatientID(patientID);
                    followUpAppt.setDoctorID(doctorID);
                    followUpAppt.setTimeslotID(followUpTimeslotID);
                    followUpAppt.setConcern("Follow-up: " + concern);
                    followUpAppt.setFollowUpAppointmentID(appointmentID);

                    appointmentDAO.createAppointment(followUpAppt);
                }
                
                response.sendRedirect(request.getContextPath() + "/appointment/page?id=" + appointmentID);
            } else {
                request.setAttribute("error", "Failed to store consultation data. Please try again");
                request.setAttribute("consultation", appointment);
                request.getRequestDispatcher("/views/patient/appointment.page.jsp").forward(request, response);
            }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
