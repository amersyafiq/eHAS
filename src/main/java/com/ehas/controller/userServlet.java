package com.ehas.controller;

import java.io.IOException;

import com.ehas.dao.AccountDAO;
import com.ehas.dao.DoctorDAO;
import com.ehas.model.Doctor;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/user")
public class userServlet extends HttpServlet {

    private DoctorDAO doctorDAO;
    private AccountDAO accountDAO;

    @Override
    public void init() throws ServletException {
       
    	// Initialize DAO object. Called once when servlet loads. 
        doctorDAO = new DoctorDAO();
        accountDAO = new AccountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/user.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        String errorMsg = null;
        String action = request.getParameter("action");
        int accountID = Integer.parseInt(request.getParameter("accountID"));
        
        try {
            if (action.equalsIgnoreCase("add_doctor")) {
                String licenseNo = request.getParameter("licenseNo");
                Integer specialityID = Integer.parseInt(request.getParameter("specialityID"));
                
                Doctor doctor = new Doctor();
                doctor.setAccountID(accountID);
                doctor.setLicenseNo(licenseNo);
                doctor.setSpecialityID(specialityID);

                if (doctorDAO.createDoctor(doctor)) {
                    if (accountDAO.updateAccountType(accountID, "Doctor")) {
                        response.sendRedirect(request.getContextPath() + "/user");
                        return;
                    } else {
                        throw new Exception("Failed to udpate account type");
                    }
                } else {
                    throw new Exception("Failed to store doctor record");
                }
                
            } else if (action.equalsIgnoreCase("revert_doctor")) {
                if (doctorDAO.deleteDoctor(accountID)) {
                    if (accountDAO.updateAccountType(accountID, "Patient")) {
                        response.sendRedirect(request.getContextPath() + "/user");
                        return;
                    } else {
                        throw new Exception("Failed to udpate account type");
                    }
                } else {
                    throw new Exception("Failed to delete doctor record");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = e.getMessage();
        }

        request.setAttribute("error", errorMsg);
        request.getRequestDispatcher("/views/admin/user.jsp").forward(request, response);
    }
}