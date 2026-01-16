package com.ehas.controller;

import java.io.IOException;

import com.ehas.dao.AppointmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

@WebServlet({
    "/appointment/invoice",
    "/appointment/invoice/process-payment"
})
public class appointmentInvoiceServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/patient/appointment.invoice.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        String cardholderName = request.getParameter("cardholderName");
        
        try {
            if (appointmentDAO.updateAppointmentBillStatus(appointmentID)) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Payment processed successfully\"}");
            } else {
                throw new Exception("Failed to save the bill status into the database");
            }
            
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}