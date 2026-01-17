package com.ehas.controller;

import com.ehas.dao.AppointmentDAO;
import com.ehas.dao.AccountDAO;
import com.ehas.dao.DoctorDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/Admin/report") // Updated URL mapping for admin context
public class reportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Initialize DAOs
        AppointmentDAO appDAO = new AppointmentDAO();
        AccountDAO accountDAO = new AccountDAO();
        
        try {
            // 1. Financial Metrics (using float8 fields from appointment table)
            double totalConsultFees = appDAO.getTotalSum("consultationfee");
            double totalTreatmentFees = appDAO.getTotalSum("treatmentfee");
            double totalRevenue = appDAO.getTotalSum("totalamount");
            
            // 2. Specialty Performance (Join doctor + speciality tables)
            // You should create a method in AppointmentDAO or DoctorDAO for this
            List<Map<String, Object>> specialtyStats = appDAO.getAppointmentsBySpecialty();
            
            // 3. Efficiency Metrics
            int completedCount = appDAO.countByStatus("Completed");
            int totalAppts = appDAO.getTotalCount();
            double cancellationRate = (totalAppts > 0) ? 
                (appDAO.countByStatus("Cancelled") * 100.0 / totalAppts) : 0;
            
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