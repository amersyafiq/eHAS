package com.ehas.controller;

import com.ehas.dao.AppointmentDAO;
import com.ehas.dao.AccountDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/report")
public class reportServlet extends HttpServlet {

    private AccountDAO accountDAO;
    private AppointmentDAO appointmentDAO; 
    
    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
    	accountDAO = new AccountDAO();
    	appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Financial Metrics (using float8 fields from appointment table)
            double totalConsultFees = appointmentDAO.getTotalSum("consultationfee");
            double totalTreatmentFees = appointmentDAO.getTotalSum("treatmentfee");
            double totalRevenue = appointmentDAO.getTotalSum("totalamount");
            
            // 2. Specialty Performance (Join doctor + speciality tables)
            // You should create a method in AppointmentDAO or DoctorDAO for this
            List<Map<String, Object>> specialtyStats = appointmentDAO.getAppointmentsBySpecialty();
            
            // 3. Efficiency Metrics
            int completedCount = appointmentDAO.countByStatus("Completed");
            int totalAppts = appointmentDAO.getTotalCount();
            double cancellationRate = (totalAppts > 0) ? 
                (appointmentDAO.countByStatus("Cancelled") * 100.0 / totalAppts) : 0;
            
            // 4. Growth Metrics
            int newPatients = accountDAO.countRecentPatients(30); // Last 30 days
            double avgBill = (completedCount > 0) ? (totalRevenue / completedCount) : 0;

            // Set Attributes for report.jsp
            request.setAttribute("totalConsultFees", totalConsultFees);
            request.setAttribute("totalTreatmentFees", totalTreatmentFees);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("specialtyStats", specialtyStats);
            request.setAttribute("completedCount", completedCount);
            request.setAttribute("cancellationRate", String.format("%.1f", cancellationRate));
            request.setAttribute("newPatientsCount", newPatients);
            request.setAttribute("avgBillAmount", String.format("%.2f", avgBill));

            // Forward to the Admin report location
            request.getRequestDispatcher("/views/admin/report.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating system report.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}