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
import java.util.List;

import com.ehas.dao.SpecialityDAO;
import com.ehas.model.Speciality;
import com.ehas.util.DBConnection;
import com.ehas.dao.DoctorDAO;
import com.ehas.model.Doctor;
import com.ehas.dao.AccountDAO;
import com.ehas.dao.AppointmentDAO;
import com.ehas.model.Account;
import com.ehas.model.Appointment;
import com.google.gson.Gson;

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
    "/appointment/book",
    "/appointment/book/specialities",
    "/appointment/book/doctors",
    "/appointment/book/dates",
    "/appointment/book/timeslots"
})
public class appointmentBookServlet extends HttpServlet {

    private PreparedStatement pstmt;
    private ResultSet rs;
    private SpecialityDAO specialityDAO;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
    	specialityDAO = new SpecialityDAO();
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
            case "/appointment/book/specialities":
                getSpecialities(request, response);
                break;
            case "/appointment/book/doctors":
                getDoctors(request, response);
                break;
            case "/appointment/book/dates":
                getDates(request, response);
                break;
            case "/appointment/book/timeslots":
                getTimeslots(request, response);
                break;
            default:
                RequestDispatcher view = request.getRequestDispatcher("/views/patient/appointment.book.jsp");
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

        String concern = request.getParameter("concern");
        int patientID = Integer.parseInt(request.getParameter("patientID"));
        int doctorID = Integer.parseInt(request.getParameter("doctor"));
        int timeslotID = Integer.parseInt(request.getParameter("timeslot"));

        Appointment appointment = new Appointment();
        appointment.setConcern(concern);
        appointment.setPatientID(patientID);
        appointment.setDoctorID(doctorID);
        appointment.setTimeslotID(timeslotID);

        if (appointmentDAO.createAppointment(appointment))
            response.sendRedirect(request.getContextPath() + "/appointment/list");
        else {
            RequestDispatcher view = request.getRequestDispatcher("/views/patient/appointment.book.jsp");
            view.forward(request, response);
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

    private void getSpecialities(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
                 
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            try (PrintWriter out = response.getWriter()) {

                List<Speciality> specialities = specialityDAO.getAllSpecialities();
                out.println("<option value=''>-- Select Speciality --</option>");
                for (Speciality s : specialities)
                    out.println(String.format("<option value='%d'>%s</option>", s.getSpecialityID(), s.getSpecialityName()));

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().print("{\"error\": \"" + e.getMessage() + "\"}");
            }
    }
    
    private void getDoctors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
                 
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            int specialityID = Integer.parseInt(request.getParameter("specialityID"));

            try (PrintWriter out = response.getWriter()) {
                out.println("<option value=''>-- Select Doctor --</option>");

                String sql = "SELECT D.ACCOUNTID, A.FULLNAME " +
                             "FROM DOCTOR D " +
                             "LEFT JOIN ACCOUNT A ON D.ACCOUNTID = A.ACCOUNTID " +
                             "WHERE D.SPECIALITYID = ? " +
                             "ORDER BY A.FULLNAME";
                try (Connection conn = DBConnection.createConnection()) {
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, specialityID);
                    rs = pstmt.executeQuery();

                    while(rs.next()) {
                        int accountID = rs.getInt("ACCOUNTID");
                        String fullName = rs.getString("FULLNAME");
                        out.println(String.format("<option value='%d'>%s</option>", accountID, fullName));
                    }

                    rs.close();
                    pstmt.close();
                    conn.close();
                }
                

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().print("{\"error\": \"" + e.getMessage() + "\"}");
            }
    }

    private void getDates(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
                 
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            int doctorID = Integer.parseInt(request.getParameter("doctorID"));

            try (PrintWriter out = response.getWriter()) {
                out.println("[");

                String sql = "SELECT SCHEDULEID, SCHEDULEDATE " +
                             "FROM DOCTORSCHEDULE D " +
                             "WHERE DOCTORID = ? AND ISACTIVE = TRUE AND SCHEDULEDATE >= CURRENT_DATE " +
                             "AND 0 < ( SELECT COUNT(TIMESLOTID) FROM TIMESLOT WHERE SCHEDULEID = D.SCHEDULEID AND ISAVAILABLE = TRUE )" +
                             "ORDER BY SCHEDULEDATE";

                boolean first = true;
                try (Connection conn = DBConnection.createConnection();
                    PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, doctorID);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int scheduleID = rs.getInt("SCHEDULEID");
                        String scheduleDate = rs.getString("SCHEDULEDATE");

                        if (!first) {
                            out.println(",");
                        }
                        first = false; 
                        out.println(String.format("  {\"scheduleID\": %d, \"scheduleDate\": \"%s\"}", scheduleID, scheduleDate));
                    }
                }

                out.println(); 
                out.println("]");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().print("{\"error\": \"" + e.getMessage() + "\"}");
            }
    }

    private void getTimeslots(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
                 
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));

            try (PrintWriter out = response.getWriter()) {
                out.println("<option value=''>-- Select Timeslot --</option>");

                String sql = "SELECT TIMESLOTID, TO_CHAR(STARTTIME, 'HH:MI AM') AS STARTTIME, TO_CHAR(ENDTIME, 'HH:MI AM') AS ENDTIME " +
                             "FROM TIMESLOT " +
                             "WHERE SCHEDULEID = ? AND ISAVAILABLE = TRUE " +
                             "AND TIMESLOTID NOT IN ( SELECT TIMESLOTID FROM APPOINTMENT WHERE STATUS != 'CANCELLED' ) " +
                             "ORDER BY STARTTIME";
                try (Connection conn = DBConnection.createConnection()) {
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, scheduleID);
                    rs = pstmt.executeQuery();

                    while(rs.next()) {
                        int timeslotID = rs.getInt("TIMESLOTID");
                        String startTime = rs.getString("STARTTIME");
                        String endTime = rs.getString("ENDTIME");
                        out.println(String.format("<option value='%d'>%s - %s</option>", timeslotID, startTime, endTime));
                    }

                    rs.close();
                    pstmt.close();
                    conn.close();
                }
                

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().print("{\"error\": \"" + e.getMessage() + "\"}");
            }
    }
}
