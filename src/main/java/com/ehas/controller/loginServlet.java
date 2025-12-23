/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.Connection;

import com.ehas.dao.AccountDAO;
import com.ehas.model.Account;
import com.ehas.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@WebServlet("/login")
public class loginServlet extends HttpServlet {
    

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
        RequestDispatcher view = request.getRequestDispatcher("/views/login.jsp");
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

        Connection conn = null;
        try {
            String email = request.getParameter("email"); 
            String password = request.getParameter("password"); 
            
            conn = DBConnection.createConnection();
            AccountDAO accountDAO = new AccountDAO();
            Account account = accountDAO.authenticateAccount(email, password, conn);
            System.out.println(account);

            if (account != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", account);
                session.setAttribute("role", account.getAccountType());
                session.setMaxInactiveInterval(30 * 60);

                response.sendRedirect(request.getContextPath() + "/");
            } else {
                request.setAttribute("error", "Invalid username or password.");
                RequestDispatcher view = request.getRequestDispatcher("/views/login.jsp");
                view.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
