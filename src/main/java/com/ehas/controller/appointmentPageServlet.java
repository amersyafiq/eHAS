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
import java.time.LocalDate;
import java.time.LocalTime;

import com.ehas.dao.AppointmentDAO;
import com.ehas.model.Account;
import com.ehas.util.DBConnection;

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
@WebServlet({
    "/appointment/page",
    "/appointment/page/cancel",
    "/appointment/page/reschedule",
    "/appointment/page/confirm"
})
public class appointmentPageServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            Account account = (Account) session.getAttribute("loggedUser");
            String accountType = account.getAccountType();
            if ("patient".equalsIgnoreCase(accountType)) {
                request.getRequestDispatcher("/views/patient/appointment.page.jsp").forward(request, response);
                return;
            } else if ("doctor".equalsIgnoreCase(accountType)) {
                request.getRequestDispatcher("/views/doctor/appointment.page.jsp").forward(request, response);
                return;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/appointment/page/cancel":
                handleCancel(request, response);
                break;
            case "/appointment/page/reschedule":
                handleReschedule(request, response);
                break;
            case "/appointment/page/confirm":
                handleConfirm(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    private void handleCancel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        String status = "CANCELLED";
        String errorMsg = null;
        try {

            String sql = "SELECT D.SCHEDULEDATE, T.STARTTIME " +
                         "FROM APPOINTMENT A " +
                         "JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID " +
                         "JOIN DOCTORSCHEDULE D ON T.SCHEDULEID = D.SCHEDULEID " +
                         "WHERE A.APPOINTMENTID = ?";

            try (Connection conn = DBConnection.createConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                pstmt.setInt(1, appointmentID);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        LocalDate appointmentDate = rs.getObject(1, LocalDate.class);
                        LocalTime appointmentStart = rs.getObject(2, LocalTime.class);
                        LocalTime twoHoursBefore = appointmentStart.minusHours(2);

                        LocalDate currentDate = LocalDate.now();
                        LocalTime currentTime = LocalTime.now();

                        boolean canCancel = false;
                        if (currentDate.isBefore(appointmentDate)) {
                            canCancel = true;
                        } else if (currentDate.isEqual(appointmentDate)) {
                            if (currentTime.isBefore(twoHoursBefore)) {
                                canCancel = true;
                            }
                        }

                        if (canCancel) {
                            appointmentDAO.updateAppointmentStatus(appointmentID, status);
                            response.sendRedirect(request.getContextPath() + "/appointment/page?id=" + appointmentID);
                            return;  
                        } else {
                            throw new Exception("You can't to cancel an appointment within 2 hours before it start.");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = e.getMessage();
        }

        request.setAttribute("error", errorMsg);
        request.getRequestDispatcher("/views/patient/appointment.page.jsp").forward(request, response);
    }

    private void handleReschedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        int newTimeslotID = Integer.parseInt(request.getParameter("timeslotID"));
        String errorMsg = null;
        try {
            if (appointmentDAO.updateAppointmentTimeslot(appointmentID, newTimeslotID)) {
                response.sendRedirect(request.getContextPath() + "/appointment/page?id=" + appointmentID);
                return;  
            } else {
                throw new Exception("You are unable to reschedule this appointment.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = e.getMessage();
        }

        request.setAttribute("error", errorMsg);
        request.getRequestDispatcher("/views/patient/appointment.page.jsp").forward(request, response);
    }

    private void handleConfirm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        String status = "CONFIRMED";
        String errorMsg = null;
        try {

            if (appointmentDAO.updateAppointmentStatus(appointmentID, status)) {
                response.sendRedirect(request.getContextPath() + "/appointment/page?id=" + appointmentID);
                return;  
            } else {
                throw new Exception("You are unable to confirm this appointment.");
            }
    
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = e.getMessage();
        }

        request.setAttribute("error", errorMsg);
        request.getRequestDispatcher("/views/patient/appointment.page.jsp").forward(request, response);
    }

}