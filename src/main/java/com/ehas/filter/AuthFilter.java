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

        // If user already logged in and requesting root, redirect to role-specific dashboard
        HttpSession session = request.getSession(false);
        Account account = (session == null) ? null : (Account) session.getAttribute("loggedUser");
        if (account != null && (path.equals("/") || path.equals("/index"))) {
            String type = account.getAccountType();
            if ("Patient".equalsIgnoreCase(type) && !path.startsWith("/views/patient/")) {
                request.getRequestDispatcher("/views/patient/index.jsp").forward(request, response);
                return;
            } else if ("Doctor".equalsIgnoreCase(type) && !path.startsWith("/views/doctor/")) {
                request.getRequestDispatcher("/views/doctor/index.jsp").forward(request, response);
                return;
            }
        }
        
        // Public Path (Static Resources, e.g.: CSS, JS, etc )
        if (
                // Index
                path.equals("/") ||
                path.equals("/index") ||
                
                // Login or Register
                path.equals("/login") ||
                path.equals("/register") ||
                
                // Static resources
                path.startsWith("/vendor/") ||
                
                // Partials
                path.startsWith("/views/partials/")
            ) {
            fc.doFilter(request, response);
            return;
        }
        
        fc.doFilter(request, response);
    }

}
