package com.ehas.controller;

import java.io.IOException;

import com.ehas.dao.AppointmentDAO;
import com.ehas.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/invoice")
public class invoiceServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/invoice.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
        double consultationFee = Double.parseDouble(request.getParameter("consultationFee"));
        double treatmentFee = Double.parseDouble(request.getParameter("treatmentFee"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        Appointment appointment = new Appointment();
        appointment.setAppointmentID(appointmentID);
        appointment.setConsultationFee(consultationFee);
        appointment.setTreatmentFee(treatmentFee);
        appointment.setTotalAmount(totalAmount);

        boolean updateSuccess = appointmentDAO.updateAppointmentFee(appointment);
        if (updateSuccess) {
            response.sendRedirect(request.getContextPath() + "/invoice");
        } else {
            request.setAttribute("error", "Failed to store appointment fee. Please try again");
            request.getRequestDispatcher("/views/admin/invoice.jsp").forward(request, response);
        }

    }
}