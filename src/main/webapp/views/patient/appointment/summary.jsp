<%-- 
    Document   : summary
    Created on : 28 Dec 2025, 11:31:13 pm
    Author     : User
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Book Appointment" />
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
        <%@ include file="/WEB-INF/jspf/nav.jspf" %>

        <main class="main-content">
            <%@ include file="/WEB-INF/jspf/header.jspf" %>

            <div class="container">
                <div class="breadcrumb">
                    <span>Appointments / Book Appointment / Booking Summary</span>
                    <button class="home-btn" onclick="location.href='./'">Home</button>
                </div>

                <%
                    String doctor = request.getParameter("doctor");
                    String date = request.getParameter("date");
                    String time = request.getParameter("time");
                %>

                <!-- Single Form -->
                <form action="<%= request.getContextPath() %>/appointment/confirm" method="post">
                    <input type="hidden" name="doctor" value="<%= doctor %>">
                    <input type="hidden" name="date" value="<%= date %>">
                    <input type="hidden" name="time" value="<%= time %>">

                    <div class="card">
                        <div class="title">BOOKING SUMMARY</div>

                        <c:if test="${not empty message}">
                            <div style="margin-bottom:20px; padding:12px; background-color:#d1fae5; color:#065f46; border-radius:6px;">
                                ${message}
                            </div>
                        </c:if>

                        <div class="summary-grid">
                            <div class="summary-item">
                                <div class="icon-box">📅</div>
                                <div>
                                    <div class="summary-label">Date</div>
                                    <div class="summary-value"><%= date %></div>
                                </div>
                            </div>

                            <div class="summary-item">
                                <div class="icon-box">⏰</div>
                                <div>
                                    <div class="summary-label">Time</div>
                                    <div class="summary-value"><%= time %></div>
                                </div>
                            </div>

                            <div class="summary-item">
                                <div class="icon-box">👨‍⚕️</div>
                                <div>
                                    <div class="summary-label">Doctor</div>
                                    <div class="summary-value"><%= doctor %></div>
                                    <div class="sub-text">Oncologist Department</div>
                                </div>
                            </div>

                            <div class="summary-item">
                                <div class="icon-box">📍</div>
                                <div>
                                    <div class="summary-label">Location</div>
                                    <div class="summary-value">Pantai Medical Centre, Kuala Lumpur</div>
                                    <div class="sub-text">
                                        No. 8, Jalan Bukit Pantai,<br>
                                        Taman Bukit Pantai, 59100 Kuala Lumpur
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="action-row">
                            <button type="button" class="btn-cancel" onclick="history.back()">Cancel</button>
                            <button type="submit" class="btn-proceed"
                                    onclick="return confirm('Are you sure you want to confirm this appointment?');">
                                Confirm Appointment
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <%@ include file="/WEB-INF/jspf/footer.jspf" %>
        </main>

        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
