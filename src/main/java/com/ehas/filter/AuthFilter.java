/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ehas.filter;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
 * - Checking user authentication/authorization (TODO)
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
