package com.ehas.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "summaryServlet", urlPatterns = {"/appointment/summary"})
public class summaryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve doctor, date, time from query parameters
        String doctor = request.getParameter("doctor");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        // Pass to JSP
        request.setAttribute("doctor", doctor);
        request.setAttribute("date", date);
        request.setAttribute("time", time);

        // Forward to summary.jsp
        request.getRequestDispatcher("/views/patient/appointment/summary.jsp")
               .forward(request, response);
    }

    // POST not needed here because form submits to ConfirmBookServlet
}
