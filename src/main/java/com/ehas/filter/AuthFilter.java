/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.filter;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.ehas.model.Account;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

/**
 * Global authentication and request filtering filter.
 * 
 * This filter is applied to all URLs ("/*") in the application.
 * It intercepts every incoming HTTP request to perform common tasks such as:
 * - Logging the requested path
 * - Checking user authentication/authorization
 * - Setting common response headers
 * - Blocking unauthorized access to protected resources
 * 
 * All requests pass through this filter before reaching servlets, JSPs, or static resources.
 * 
 * @author SYAFIQ
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1, FilterChain fc) throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) sr;
        HttpServletResponse response = (HttpServletResponse) sr1;
        
        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();
        String path = uri.substring(contextPath.length());

        HttpSession session = request.getSession(false);
        
        // Public Path (Static Resources, e.g.: CSS, JS, etc )
        if (
                // Index
                (
                    session == null &&
                    (path.equals("/") ||
                    path.equals("/index"))
                ) ||
                
                // Login or Register
                path.equals("/login") ||
                path.equals("/register") ||
                
                // Static resources
                path.startsWith("/vendor/") ||
                
                // Partials
                path.endsWith(".jspf")
            ) {
            fc.doFilter(request, response);
            return;
        }

        Account account = (session == null) ? null : (Account) session.getAttribute("loggedUser");

        // If no user is logged in and trying to access a protected page
        if (account == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        String type = account.getAccountType();

        // Prevent Patients from accessing Doctor views
        if (path.startsWith("/views/doctor/") && !"Doctor".equalsIgnoreCase(type)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Doctors only.");
            return;
        }

        // Prevent Doctors from accessing Patient views
        if (path.startsWith("/views/patient/") && !"Patient".equalsIgnoreCase(type)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Patients only.");
            return;
        }

        // If logged-in user hits root or index, show dashboard WITHOUT changing the URL
        if (path.equals("/") || path.equals("/index")) {
            String dashboardPath = "";
            
            if ("Patient".equalsIgnoreCase(type)) {
                dashboardPath = "/views/patient/index.jsp";
            } else if ("Doctor".equalsIgnoreCase(type)) {
                dashboardPath = "/views/doctor/index.jsp";
              
            }else if ("Admin".equalsIgnoreCase(type)) {
                dashboardPath = "/views/Admin/index.jsp";
              
            }
           

            if (!dashboardPath.isEmpty()) {
                request.getRequestDispatcher(dashboardPath).forward(request, response);
                return;
            }
        }


        
        fc.doFilter(request, response);
    }

}
