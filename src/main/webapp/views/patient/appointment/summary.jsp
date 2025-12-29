<%-- 
    Document   : summary
    Created on : 28 Dec 2025, 11:31:13 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="../../partials/head.jsp" %>
    <head>
        <style>
            body {
                margin: 0;
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f1f3f6;
            }

            .container {
                max-width: 1100px;
                margin: 30px auto;
                padding: 20px;
            }

            /* Breadcrumb */
            .breadcrumb {
                background: #ffffff;
                padding: 15px 20px;
                border-radius: 6px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .breadcrumb span {
                color: #1f4ed8;
                font-weight: 500;
            }

            .home-btn {
                background: #1f4ed8;
                color: #fff;
                border: none;
                padding: 8px 16px;
                border-radius: 5px;
                cursor: pointer;
            }

            /* Card */
            .card {
                background: #ffffff;
                padding: 35px;
                border-radius: 6px;
            }

            .title {
                text-align: center;
                font-size: 26px;
                font-weight: 600;
                color: #3f5ae0;
                margin-bottom: 30px;
                letter-spacing: 1px;
            }

            /* Summary layout */
            .summary-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 30px 50px;
            }

            .summary-item {
                display: flex;
                align-items: flex-start;
                gap: 15px;
            }

            .icon-box {
                width: 42px;
                height: 42px;
                border-radius: 8px;
                background: #eef2ff;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #3f5ae0;
                font-size: 18px;
            }

            .summary-label {
                font-size: 13px;
                color: #6b7280;
                margin-bottom: 4px;
            }

            .summary-value {
                font-size: 15px;
                font-weight: 500;
                color: #111827;
            }

            .sub-text {
                font-size: 13px;
                color: #6b7280;
                margin-top: 2px;
            }

            /* Buttons */
            .action-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-top: 40px;
            }

            .btn-cancel {
                background: #e00000;
                color: #fff;
                border: none;
                padding: 15px;
                border-radius: 6px;
                font-size: 15px;
                cursor: pointer;
            }

            .btn-proceed {
                background: #3f5ae0;
                color: #fff;
                border: none;
                padding: 15px;
                border-radius: 6px;
                font-size: 15px;
                cursor: pointer;
            }

            @media (max-width: 768px) {
                .summary-grid {
                    grid-template-columns: 1fr;
                }

                .action-row {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body class=" " data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
        <!-- loader Start -->
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body">
                </div>
            </div>    
        </div>
        <!-- loader END -->

        <%-- Navigation Start --%>
        <%@ include file="../../partials/nav.jsp" %>
        <%-- Navigation END --%>
        
        <main class="main-content">
            <div class="position-relative iq-banner">

                <!--Header Start-->
                <%@ include file="../../partials/header.jsp" %>
                <%-- Header END --%>
            
                <%-- Main Section Start --%>
                <div class="conatiner-fluid content-inner p-3">
                    <%-- TODO: Use Case Here --%>

                    <div class="container">

                        <!-- Breadcrumb -->
                        <div class="breadcrumb">
                            <span>Appointments / Book Appointment / Booking Summary</span>
                            <button class="home-btn"
                                    onclick="location.href='./'">
                                Home
                            </button>
                        </div>

                        <!-- Summary Card -->
                        <div class="card">

                            <div class="title">BOOKING SUMMARY</div>

                            <div class="summary-grid">

                                <!-- Date -->
                                <div class="summary-item">
                                    <div class="icon-box">📅</div>
                                    <div>
                                        <div class="summary-label">Date</div>
                                        <div class="summary-value">
                                            Monday, December 1, 2025
                                        </div>
                                    </div>
                                </div>

                                <!-- Time -->
                                <div class="summary-item">
                                    <div class="icon-box">⏰</div>
                                    <div>
                                        <div class="summary-label">Time</div>
                                        <div class="summary-value">
                                            08:00 AM - 08:30 AM
                                        </div>
                                    </div>
                                </div>

                                <!-- Doctor -->
                                <div class="summary-item">
                                    <div class="icon-box">👨‍⚕️</div>
                                    <div>
                                        <div class="summary-label">Doctor</div>
                                        <div class="summary-value">
                                            Dr. Farhan Izmeer
                                        </div>
                                        <div class="sub-text">
                                            Oncologist Department
                                        </div>
                                    </div>
                                </div>

                                <!-- Location -->
                                <div class="summary-item">
                                    <div class="icon-box">📍</div>
                                    <div>
                                        <div class="summary-label">Location</div>
                                        <div class="summary-value">
                                            Pantai Medical Centre, Kuala Lumpur
                                        </div>
                                        <div class="sub-text">
                                            No. 8, Jalan Bukit Pantai,<br>
                                            Taman Bukit Pantai, 59100 Kuala Lumpur
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <!-- Actions -->
                            <div class="action-row">
                                <button class="btn-cancel"
                                        onclick="history.back()">
                                    Cancel
                                </button>

                                <button class="btn-proceed"
                                        onclick="location.href='${pageContext.request.contextPath}/appointment/confirm'">
                                    Proceed
                                </button>
                            </div>

                        </div>
                    </div>
                </div>
                <%-- Main Section END --%>

            </div>
        
        
            <!-- Footer Section Start -->
            <footer class="footer">
                <div class="footer-body">
                    <ul class="left-panel list-inline mb-0 p-0">
                        <li class="list-inline-item"><a href="${pageContext.request.contextPath}/vendor/dashboard/extra/privacy-policy.html">Privacy Policy</a></li>
                        <li class="list-inline-item"><a href="${pageContext.request.contextPath}/vendor/dashboard/extra/terms-of-service.html">Terms of Use</a></li>
                    </ul>
                    <div class="right-panel">
                        ©<script>document.write(new Date().getFullYear())</script> Taman Medical Center
                    </div>
                </div>
            </footer>
            <!-- Footer Section END -->    

        </main>
        
        <%@ include file="../../partials/scripts.jsp" %>
    </body>
</html>
