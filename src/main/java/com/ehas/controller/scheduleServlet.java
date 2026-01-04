/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ehas.dao.DoctorScheduleDAO;
import com.ehas.dao.TimeslotDAO;
import com.ehas.model.DoctorSchedule;
import com.ehas.model.Timeslot;
import com.ehas.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
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
    "/schedule",
    "/schedule/doctorschedule",
    "/schedule/timeslots",
    "/schedule/timeslot/add",
    "/schedule/timeslot/delete",
    "/schedule/date/add",
    "/schedule/date/delete"
})
public class scheduleServlet extends HttpServlet {

    private PreparedStatement pstmt;
    private ResultSet rs;
    TimeslotDAO timeslotDAO;
    DoctorScheduleDAO doctorscheduleDAO;


    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
    	timeslotDAO = new TimeslotDAO();
    	doctorscheduleDAO = new DoctorScheduleDAO();
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
            case "/schedule/doctorschedule":
                getSchedule(request, response);
                break;
            case "/schedule/timeslots":
                getTimeslots(request, response);
                break;
            default:
                RequestDispatcher view = request.getRequestDispatcher("/views/doctor/schedule.jsp");
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
        
            String path = request.getServletPath();
        
            switch (path) {
                case "/schedule/timeslot/add":
                    addTimeslot(request, response);
                    break;
                case "/schedule/timeslot/delete":
                    deleteTimeslot(request, response);
                    break;
                case "/schedule/date/add":
                    addDate(request, response);
                    break;
                case "/schedule/date/delete":
                    // deleteDate(request, response);
                    break;
            }
    }

    private void getSchedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            JSONArray events = new JSONArray();

            int doctorID = Integer.parseInt(request.getParameter("doctorID"));
            String sql = "SELECT D.SCHEDULEID, TO_CHAR(D.SCHEDULEDATE, 'yyyy-MM-dd') AS SCHEDULEDATE, " +
                         "(SELECT COUNT(*) FROM TIMESLOT WHERE SCHEDULEID = D.SCHEDULEID) AS SLOT_COUNT " +
                         "FROM DOCTORSCHEDULE D " +
                         "WHERE D.DOCTORID = ? ";

            try (Connection conn = DBConnection.createConnection()) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, doctorID);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    JSONObject event = new JSONObject();
                    event.put("title", rs.getInt("SLOT_COUNT") + "\nSLOTS");
                    event.put("start", rs.getString("SCHEDULEDATE"));
                    event.put("backgroundColor", "#3a57e8");
                    event.put("textColor", "white");
                    event.put("borderColor", "#3a57e8");
                    event.put("extendedProps", new JSONObject().put("scheduleID", rs.getInt("SCHEDULEID")));

                    events.put(event);
                }
                out.print(events.toString());

            } catch (SQLException e) {
                e.printStackTrace();
            }

            out.flush();
    }

    private void getTimeslots(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            JSONArray timeslots = new JSONArray();

            int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
            String sql = "SELECT T.TIMESLOTID, STARTTIME, ISAVAILABLE, APPOINTMENTID, FULLNAME, PICTUREPATH " +
                         "FROM TIMESLOT T " +
                         "LEFT JOIN APPOINTMENT AP ON T.TIMESLOTID = AP.TIMESLOTID AND AP.STATUS != 'CANCELLED' " +
                         "LEFT JOIN ACCOUNT AC ON AP.PATIENTID = AC.ACCOUNTID " +
                         "WHERE T.SCHEDULEID = ? " +
                         "ORDER BY T.STARTTIME ASC";

            try (Connection conn = DBConnection.createConnection()) {
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, scheduleID);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    JSONObject timeslot = new JSONObject();
                    timeslot.put("timeslotID", rs.getInt("TIMESLOTID"));
                    timeslot.put("startTime", rs.getString("STARTTIME"));
                    timeslot.put("isAvailable", rs.getString("ISAVAILABLE"));
                    timeslot.put("appointmentID", rs.getInt("APPOINTMENTID"));
                    timeslot.put("fullName", rs.getString("FULLNAME"));
                    timeslot.put("picturePath", rs.getString("PICTUREPATH"));

                    timeslots.put(timeslot);
                }
                out.print(timeslots.toString());

            } catch (SQLException e) {
                e.printStackTrace();
            }

            out.flush();
    }

    private void addTimeslot(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            
            Timeslot timeslot = new Timeslot();
            timeslot.setScheduleID(scheduleID);
            timeslot.setStartTime(startTime);
            timeslot.setEndTime(endTime);
            timeslot.setIsAvailable(true);
            
            if (timeslotDAO.createTimeslot(timeslot)) {
                out.print("{\"success\": true, \"message\": \"Timeslot added successfully\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to add timeslot\"}");
            }
            
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Invalid parameters\"}");
        }
    }

    private void deleteTimeslot(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            int timeslotID = Integer.parseInt(request.getParameter("timeslotID"));
            
            // Check if timeslot has appointments
            String checkSql = "SELECT COUNT(*) AS COUNT FROM APPOINTMENT WHERE TIMESLOTID = ? AND STATUS != 'CANCELLED'";
            
            try (Connection conn = DBConnection.createConnection();
                 PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                
                checkStmt.setInt(1, timeslotID);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("COUNT") > 0) {
                        out.print("{\"success\": false, \"message\": \"Cannot delete timeslot with existing appointments\"}");
                        return;
                    }
                }
                
                // Delete timeslot
                String deleteSql = "DELETE FROM TIMESLOT WHERE TIMESLOTID = ?";
                
                try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                    deleteStmt.setInt(1, timeslotID);
                    
                    int rowsAffected = deleteStmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        out.print("{\"success\": true, \"message\": \"Timeslot deleted successfully\"}");
                    } else {
                        out.print("{\"success\": false, \"message\": \"Failed to delete timeslot\"}");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Database error: " + e.getMessage() + "\"}");
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Invalid timeslot ID\"}");
        }
    }

    private void addDate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            int doctorID = Integer.parseInt(request.getParameter("doctorID"));
            LocalDate scheduleDate = LocalDate.parse(request.getParameter("scheduleDate"));
            
            DoctorSchedule doctorSchedule = new DoctorSchedule();
            doctorSchedule.setDoctorID(doctorID);
            doctorSchedule.setScheduleDate(scheduleDate);
            doctorSchedule.setIsActive(true);

            if (doctorscheduleDAO.createSchedule(doctorSchedule)) {
                out.print("{\"success\": true, \"message\": \"Timeslot added successfully\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to add date\"}");
            }
            
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Invalid doctor ID\"}");
        }
    }

}
