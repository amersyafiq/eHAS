/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.controller;

import jakarta.servlet.RequestDispatcher;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.S3Client;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import com.ehas.dao.AccountDAO; 
import com.ehas.dao.PatientDAO;
import com.ehas.util.DBConnection; 
import com.ehas.model.Account;
import com.ehas.model.Patient;
import com.ehas.util.S3Connection;

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
            String gender = "Male";
            String dateOfBirth = request.getParameter("dateOfBirth");

            String picturePath = "uploads/default.png";  // fallback in your webapp (e.g., default profile pic)

            Part part = request.getPart("profilePicture");

            if (part != null && part.getSize() > 0) {
                String submittedFileName = part.getSubmittedFileName();
                String contentType = part.getContentType();  // Important for correct display
                long fileSize = part.getSize();

                // Generate unique filename
                String extension = "";
                int dotIndex = submittedFileName.lastIndexOf('.');
                if (dotIndex > 0 && dotIndex < submittedFileName.length() - 1) {
                    extension = submittedFileName.substring(dotIndex);  // includes the dot
                }
                String fileNameInBucket = "profile-pictures/pfp_" + System.currentTimeMillis() + extension;

                try (InputStream inputStream = part.getInputStream()) {
                    // Get the S3 client (from your utility class)
                    S3Client s3 = S3Connection.getClient();

                    String bucketName = "ehas";

                    // Build and execute upload
                    PutObjectRequest putRequest = PutObjectRequest.builder()
                            .bucket(bucketName)
                            .key(fileNameInBucket)
                            .contentType(contentType)
                            .build();

                    s3.putObject(putRequest, RequestBody.fromInputStream(inputStream, fileSize));

                    // Generate public URL (only works if bucket is PUBLIC)
                    // If bucket is PRIVATE, use presigned URL instead (see below)
                    picturePath = S3Connection.getPublicObjectUrl(bucketName, fileNameInBucket);

                } catch (Exception e) {
                    e.printStackTrace();
                    // Handle error: log, show message, fallback to default
                    picturePath = "uploads/default.png";  // keep fallback on error
                }
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
            response.sendRedirect(request.getContextPath() + "/login");
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
}
