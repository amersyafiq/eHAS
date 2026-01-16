package com.ehas.controller;

import java.io.IOException;

import io.github.cdimascio.dotenv.Dotenv;
import com.ehas.dao.AppointmentDAO;
import com.stripe.Stripe;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;

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

    private Dotenv dotenv;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
        dotenv = Dotenv.configure().ignoreIfMissing().load();
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
        String paymentMethodID = request.getParameter("paymentMethodID");
        long amount = Long.parseLong(request.getParameter("amount")); // in cents
        
        // Use your SECRET KEY for server-side calls
        String secretKey = dotenv.get("STRIPE_SECRET_KEY");       
         
        try {
            // Create payment intent
            Stripe.apiKey = secretKey;
            
            PaymentIntentCreateParams params = PaymentIntentCreateParams.builder()
                .setAmount(amount)
                .setCurrency("myr")
                .setPaymentMethod(paymentMethodID)
                .setConfirm(true)
                .setReturnUrl(request.getContextPath() + "/appointment/invoice?id=" + appointmentID)
                .build();
                
            PaymentIntent intent = PaymentIntent.create(params);
            
            if (intent.getStatus().equals("succeeded")) {

                // Update appointment bill status to PAID in database
                if (appointmentDAO.updateAppointmentBillStatus(appointmentID)) {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\": true}");
                } else {
                    throw new Exception("Failed to save the bill status into the database");
                }

            } else if (intent.getStatus().equals("requires_action")) {
                response.setContentType("application/json");
                response.getWriter().write("{\"requiresAction\": true, \"clientSecret\": \"" + intent.getClientSecret() + "\"}");
            }
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}