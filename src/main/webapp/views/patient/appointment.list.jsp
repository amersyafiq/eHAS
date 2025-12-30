<%-- 
    Document   : appointment.list
    Created on : Dec 24, 2025, 9:47:05 AM
    Author     : ASUS
--%>

<% String pageTitle = "My Appointments"; %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    <%@ include file="../partials/head.jsp" %>
    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
        <!-- loader Start -->
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body">
                </div>
            </div>    
        </div>
        <!-- loader END -->

        <%-- Navigation Start --%>
        <%@ include file="../partials/nav.jsp" %>
        <%-- Navigation END --%>
        
        <main class="main-content">
            <div class="position-relative iq-banner">

                <!--Header Start-->
                <%@ include file="../partials/header.jsp" %>
                <%-- Header END --%>
            
                <%-- Main Section Start --%>
                <div class="container-fluid content-inner p-3">
                    
                    <%-- Breadcrumb Start --%>
                    <div class="col-12">
                        <div class="card py-3 px-5 mb-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item"><a href="#">Appointments</a></li>
                                            <li class="breadcrumb-item active" aria-current="page"><%= pageTitle %></li>
                                        </ol>
                                    </nav>
                                </div>
                                <div class="col-auto">
                                    <button onclick="window.location.href='${pageContext.request.contextPath}/'" class="btn btn-sm btn-primary">Home</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Breadcrumb END --%>

                    <%-- Appointment Filter Start --%>
                    <div class="row g-3">
                        <div class="col-md-10">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <input type="text" class="form-control px-5" placeholder="Search Appointment">
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group mb-0">
                                        <input type="text" name="start" class="form-control range_flatpicker" placeholder="Range Date">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option selected>Open this select menu</option>
                                        <option value="1">One</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-2 d-grid">
                            <button 
                                type="button"    
                                onclick="window.location.href='/eHAS/appointment/book'"
                                class="btn btn-sm btn-primary text-nowrap d-flex align-items-center gap-2"
                            >
                                <svg width="16" height="20" viewBox="0 0 16 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8.00033 5.33331V14.6666" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M3.33301 10H12.6663" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                                Book Appointment
                            </button>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-10">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <input type="text" class="form-control px-5" placeholder="Search Appointment">
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group mb-0">
                                        <input type="text" name="start" class="form-control range_flatpicker" placeholder="Range Date">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select">
                                        <option selected>Open this select menu</option>
                                        <option value="1">One</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-2 d-grid">
                            <button 
                                type="button"    
                                onclick="window.location.href='/eHAS/appointment/book'"
                                class="btn btn-sm btn-primary text-nowrap d-flex align-items-center gap-2"
                            >
                                <svg width="16" height="20" viewBox="0 0 16 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8.00033 5.33331V14.6666" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M3.33301 10H12.6663" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                                Book Appointment
                            </button>
                        </div>
                    </div>

                    <%-- Appointment Filter END --%>

                                



                    
                </div>
                <%-- Main Section END --%>

            </div>
        
        
            <!-- Footer Section Start -->
            <%@ include file="../partials/footer.jsp" %>
            <!-- Footer Section END -->    

        </main>
        
        <%@ include file="../partials/scripts.jsp" %>
    </body>
</html>
