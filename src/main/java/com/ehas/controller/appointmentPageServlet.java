/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;

import com.ehas.dao.AppointmentDAO;
import com.ehas.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet({
    "/appointment/list/page",
    "/appointment/list/page/cancel",
    "/appointment/list/page/reschedule"
})
public class appointmentPageServlet extends HttpServlet {

    private PreparedStatement pstmt;
    private ResultSet rs;
    AppointmentDAO appointmentDAO;

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
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/appointment/list/page/cancel":
                handleCancel(request, response);
                break;
            case "/appointment/list/page/reschedule":
                handleReschedule(request, response);
                break;
            default:
                RequestDispatcher view = request.getRequestDispatcher("/views/patient/appointment.page.jsp");
                view.forward(request, response);
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

    private void handleCancel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
            String status = "CANCELLED";

            String sql = "SELECT D.SCHEDULEDATE, T.STARTTIME, T.ENDTIME " +
                         "FROM APPOINTMENT A " +
                         "JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID " +
                         "JOIN DOCTORSCHEDULE D ON T.SCHEDULEID = D.SCHEDULEID " +
                         "WHERE A.APPOINTMENTID = ?";
            try (Connection conn = DBConnection.createConnection()) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, appointmentID);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    LocalDate appointmentDate = rs.getObject(1, LocalDate.class);

                    LocalTime appointmentStart = rs.getObject(2, LocalTime.class);
                    LocalTime twoHoursBefore = appointmentStart.minusHours(2);

                    LocalDate currentDate = LocalDate.now();
                    LocalTime currentTime = LocalTime.now();

                    // Check if cancellation was made within 2 hours the appointment start
                    if (currentDate.isBefore(appointmentDate)) {
                        appointmentDAO.updateAppointmentStatus(appointmentID, status);
                    } else if (currentDate.isEqual(appointmentDate)) {
                        if (currentTime.isBefore(twoHoursBefore))
                            appointmentDAO.updateAppointmentStatus(appointmentID, status);
                        else {
                            out.print("{\"success\": true, \"message\": \"Appointment cancelled successfully.\"}");
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
    }

    private void handleReschedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        int newTimeslotID = Integer.parseInt(request.getParameter("timeslotID"));

        if (appointmentDAO.updateAppointmentTimeslot(appointmentID, newTimeslotID))
            out.print("{\"success\": true, \"message\": \"Appointment rescheduled successfully.\"}");
        else
            out.print("{\"success\": false, \"message\": \"Failed to reschedule appointment.\"}");
    }

}
