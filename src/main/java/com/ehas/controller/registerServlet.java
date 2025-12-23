/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.controller;

import jakarta.servlet.RequestDispatcher;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;
import java.sql.Connection;

import com.ehas.dao.AccountDAO; 
import com.ehas.dao.PatientDAO;
import com.ehas.util.DBConnection; 
import com.ehas.model.Account;
import com.ehas.model.Patient;

/**
 *
 * @author ASUS
 */
@WebServlet("/register")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 5L * 1024 * 1024,      // 5 MB
    maxRequestSize = 6L * 1024 * 1024    // 6 MB
)
public class registerServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

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
        RequestDispatcher view = request.getRequestDispatcher("/views/register.jsp");
        view.forward(request, response);
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

        List<String> errors = new ArrayList<>();
        Connection conn = null;

        try {

            String fullName = request.getParameter("fullName"); 
            String password = request.getParameter("password"); 
            String confirmPassword = request.getParameter("confirmPassword"); 
            String ic_passport = request.getParameter("ic_passport"); 
            String phoneNo = request.getParameter("phoneNo"); 
            String email = request.getParameter("email"); 
            String gender = request.getParameter("gender"); 
            String dateOfBirth = request.getParameter("dateOfBirth");

            String picturePath = "uploads/default.png"; // fallback
            Part part = request.getPart("profilePicture");
            if (part != null && part.getSize() > 0) {

                String submittedFileName = part.getSubmittedFileName();
                String extension = submittedFileName.substring(submittedFileName.lastIndexOf('.'));

                String fileName = "pfp_" + System.currentTimeMillis() + extension;

                String uploadsDir = getServletContext().getRealPath("/uploads");
                File uploadFolder = new File(uploadsDir);

                 if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs();
                }

                File file = new File(uploadFolder, fileName);
                part.write(file.getAbsolutePath());

                // Path stored in DB (URL-accessible)
                picturePath = request.getContextPath() + "/uploads/" + fileName;
            }

            // FORM VALIDATION
            if (fullName == null || fullName.length() < 6) 
                errors.add("Full name must be at least 6 characters"); 
            if (password == null || password.length() < 6) 
                errors.add("Password must be at least 6 characters"); 
            if (confirmPassword == null || confirmPassword.length() < 6) 
                errors.add("Confirm password must be at least 6 characters"); 
            if (!password.equals(confirmPassword)) 
                errors.add("Passwords do not match"); 
            if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) 
                errors.add("Invalid email format");
            if (!errors.isEmpty()) {
                throw new Exception("Validation error");
            }

            conn = DBConnection.createConnection();
            conn.setAutoCommit(false);

            AccountDAO accountDAO = new AccountDAO();
            PatientDAO patientDAO = new PatientDAO();

            // Check email exists
            boolean emailExists = accountDAO.isEmailExists(email, conn);
            if (emailExists) {
                errors.add("Email already registered.");
                throw new Exception("Duplicate email");
            }

            // Storing into Account table 
            Account account = new Account(); 
            account.setFullName(fullName); 
            account.setPassword(password); 
            account.setIc_passport(ic_passport); 
            account.setPhoneNo(phoneNo); 
            account.setEmail(email); 
            account.setGender(gender); 
            account.setDateOfBirth(dateOfBirth); 
            account.setPicturePath(picturePath); 
            int accountID = accountDAO.createAccount(account, conn); 

            // Storing into Patient table 
            Patient patient = new Patient(); 
            patient.setAccountID(accountID); 
            patientDAO.createPatient(patient, conn); 
            
            conn.commit();
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception ignored) {}
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception ignored) {}
            }
        }

        request.setAttribute("errors", errors);
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

}
