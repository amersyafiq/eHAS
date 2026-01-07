<%-- 
    Document   : index
    Created on : Dec 23, 2025, 5:42:57 PM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Dashboard" />
    
    <%-- Query upcoming appointments for the logged-in patient --%>
    <sql:query var="upcomingAppointments" dataSource="${myDatasource}">
        SELECT 
            a.appointmentid,
            a.status,
            a.concern,
            a.totalamount,
            TO_CHAR(ts.starttime, 'HH12:MI AM') as starttime,
            TO_CHAR(ts.endtime, 'HH12:MI AM') as endtime,
            TO_CHAR(ds.scheduledate, 'Day, DD Month YYYY') as scheduledate,
            acc.fullname as doctor_name,
            s.specialityname
        FROM appointment a
        JOIN timeslot ts ON a.timeslotid = ts.timeslotid
        JOIN doctorschedule ds ON ts.scheduleid = ds.scheduleid
        JOIN doctor d ON a.doctorid = d.accountid
        JOIN account acc ON d.accountid = acc.accountid
        JOIN speciality s ON d.specialityid = s.specialityid
        WHERE a.patientid = ?
        AND ds.scheduledate >= CURRENT_DATE
        AND a.status IN ('PENDING', 'CONFIRMED')
        ORDER BY ds.scheduledate ASC, ts.starttime ASC
        LIMIT 3
        <sql:param value="${sessionScope.loggedUser.accountID}" />
    </sql:query>
    
    <%-- Query bills (appointments with amounts) --%>
    <sql:query var="bills" dataSource="${myDatasource}">
        SELECT 
            a.appointmentid,
            a.totalamount,
            a.billstatus,
            acc.fullname as doctor_name
        FROM appointment a
        JOIN doctor d ON a.doctorid = d.accountid
        JOIN account acc ON d.accountid = acc.accountid
        WHERE a.patientid = ?
        AND a.totalamount IS NOT NULL
        AND a.totalamount > 0
        ORDER BY a.createdat DESC
        LIMIT 3
        <sql:param value="${sessionScope.loggedUser.accountID}" />
    </sql:query>
    
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
        <%@ include file="/WEB-INF/jspf/nav.jspf" %>
        <%-- Navigation END --%>
        
        <main class="main-content">
            <div class="position-relative iq-banner">

                <!--Header Start-->
                <%@ include file="/WEB-INF/jspf/header.jspf" %>
                <%-- Header END --%>
            
                <%-- Main Section Start --%>
                <div class="conatiner-fluid content-inner p-3">
                    <div class="row">
                        <!-- Welcome Banner -->
                        <div class="col-12">
                            <div class="card border-0 mb-3" style="background: linear-gradient(90deg, #2563eb 0%, #3b82f6 100%);">
                                <div class="card-body py-4 px-4">
                                    <h3 class="text-white fw-bold mb-1">Welcome Back, ${sessionScope.loggedUser.fullName}.</h3>
                                    <p class="text-white fs-6 mb-0 opacity-75">You are a Patient</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Appointments and Bills Row -->
                        <div class="col-12 mb-3">
                            <div class="row g-3">
                                <!-- Upcoming Appointments Section (8 columns) -->
                                <div class="col-12 col-lg-8">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h5 class="mb-0 fw-semibold">Upcoming Appointments</h5>
                                                <a href="${pageContext.request.contextPath}/appointment/list" class="text-decoration-none text-primary fw-medium small">View All Appointments</a>
                                            </div>
                                            
                                            <c:choose>
                                                <c:when test="${upcomingAppointments.rowCount > 0}">
                                                    <c:forEach var="appt" items="${upcomingAppointments.rows}">
                                                        <div class="border rounded p-3 mb-3 border-1 border-primary" style="background-color: #f2f4fe;">
                                                            <div class="d-flex justify-content-between align-items-start">
                                                                <div class="d-flex gap-3">
                                                                    <div class="text-primary px-2">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
                                                                            <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                                                                            <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                                                        </svg>
                                                                    </div>
                                                                    <div>
                                                                        <p class="mb-0 fw-medium text-primary">Appointment #${appt.appointmentid}</p>
                                                                        <p class="mb-0 text-dark small">${appt.doctor_name}</p>
                                                                    </div>
                                                                </div>
                                                                <div class="text-end pe-2">
                                                                    <p class="mb-0 fw-medium text-primary">${appt.scheduledate}</p>
                                                                    <p class="mb-0 text-dark small">${appt.starttime} - ${appt.endtime}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="text-center py-5 text-muted">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-calendar-x mb-3 opacity-50" viewBox="0 0 16 16">
                                                            <path d="M6.146 7.146a.5.5 0 0 1 .708 0L8 8.293l1.146-1.147a.5.5 0 1 1 .708.708L8.707 9l1.147 1.146a.5.5 0 0 1-.708.708L8 9.707l-1.146 1.147a.5.5 0 0 1-.708-.708L7.293 9 6.146 7.854a.5.5 0 0 1 0-.708z"/>
                                                            <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                                        </svg>
                                                        <p class="mb-0">No upcoming appointments</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Your Bills Section (4 columns) -->
                                <div class="col-12 col-lg-4">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <h5 class="mb-4 fw-semibold">Your Bills</h5>
                                            
                                            <c:choose>
                                                <c:when test="${bills.rowCount > 0}">
                                                    <c:forEach var="bill" items="${bills.rows}">
                                                        <div class="border rounded p-3 mb-3 d-flex justify-content-between align-items-center">
                                                            <div>
                                                                <h6 class="mb-1 fw-semibold">Appointment #${bill.appointmentid}</h6>
                                                                <p class="mb-0 text-muted small">${bill.doctor_name}</p>
                                                            </div>
                                                            <div class="text-end">
                                                                <c:choose>
                                                                    <c:when test="${bill.billstatus == 'PAID'}">
                                                                        <p class="mb-0 fw-bold text-success">RM${bill.totalamount}</p>
                                                                        <span class="badge bg-success-subtle text-success small px-3 py-1">Paid</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <p class="mb-0 fw-bold text-danger">RM${bill.totalamount}</p>
                                                                        <span class="badge bg-danger-subtle text-danger small px-3 py-1">Unpaid</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="text-center py-5 text-muted">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-receipt mb-3 opacity-50" viewBox="0 0 16 16">
                                                            <path d="M1.92.506a.5.5 0 0 1 .434.14L3 1.293l.646-.647a.5.5 0 0 1 .708 0L5 1.293l.646-.647a.5.5 0 0 1 .708 0L7 1.293l.646-.647a.5.5 0 0 1 .708 0L9 1.293l.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .801.13l.5 1A.5.5 0 0 1 15 2v12a.5.5 0 0 1-.053.224l-.5 1a.5.5 0 0 1-.8.13L13 14.707l-.646.647a.5.5 0 0 1-.708 0L11 14.707l-.646.647a.5.5 0 0 1-.708 0L9 14.707l-.646.647a.5.5 0 0 1-.708 0L7 14.707l-.646.647a.5.5 0 0 1-.708 0L5 14.707l-.646.647a.5.5 0 0 1-.708 0L3 14.707l-.646.647a.5.5 0 0 1-.801-.13l-.5-1A.5.5 0 0 1 1 14V2a.5.5 0 0 1 .053-.224l.5-1a.5.5 0 0 1 .367-.27zm.217 1.338L2 2.118v11.764l.137.274.51-.51a.5.5 0 0 1 .707 0l.646.647.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.509.509.137-.274V2.118l-.137-.274-.51.51a.5.5 0 0 1-.707 0L12 1.707l-.646.647a.5.5 0 0 1-.708 0L10 1.707l-.646.647a.5.5 0 0 1-.708 0L8 1.707l-.646.647a.5.5 0 0 1-.708 0L6 1.707l-.646.647a.5.5 0 0 1-.708 0L4 1.707l-.646.647a.5.5 0 0 1-.708 0l-.509-.51z"/>
                                                            <path d="M3 4.5a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm8-6a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5z"/>
                                                        </svg>
                                                        <p class="mb-0">No bills available</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action Cards Row -->
                        <div class="col-12">
                            <div class="row g-3">
                                <!-- Book Appointment Card -->
                                <div class="col-12 col-md-4">
                                    <a href="${pageContext.request.contextPath}/appointment/book" class="text-decoration-none">
                                        <div class="card border-0 shadow-sm h-100 text-white" style="background: linear-gradient(135deg, #2563eb 0%, #3b82f6 100%);">
                                            <div class="card-body text-center py-3 d-flex flex-column justify-content-center align-items-center">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-plus-circle mb-2" viewBox="0 0 16 16">
                                                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                                </svg>
                                                <h5 class="fw-semibold m-0 text-white">Book Appointment</h5>
                                                <p class="mb-0 small lh-1 mt-1 text-white">Schedule a new appointment with doctors</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                
                                <!-- My Appointments Card -->
                                <div class="col-12 col-md-4">
                                    <a href="${pageContext.request.contextPath}/appointment/list" class="text-decoration-none">
                                        <div class="card border shadow-sm h-100">
                                            <div class="card-body text-center py-3 d-flex flex-column justify-content-center align-items-center">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-calendar-check text-secondary mb-2" viewBox="0 0 16 16">
                                                    <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                                                    <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                                </svg>
                                                <h5 class="fw-semibold m-0 text-dark">My Appointments</h5>
                                                <p class="mb-0 small lh-1 mt-1 text-muted">View, reschedule or cancel your appointments</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                
                                <!-- Profile Card -->
                                <div class="col-12 col-md-4">
                                    <a href="${pageContext.request.contextPath}/profile" class="text-decoration-none">
                                        <div class="card border shadow-sm h-100">
                                            <div class="card-body text-center py-3 d-flex flex-column justify-content-center align-items-center">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-circle text-secondary mb-2" viewBox="0 0 16 16">
                                                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                                                </svg>
                                                <h5 class="fw-semibold m-0 text-dark">Profile</h5>
                                                <p class="mb-0 small lh-1 mt-1 text-muted">Manage your account information and settings</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- Main Section END --%>

            </div>
        
            <!-- Footer Section Start -->
            <%@ include file="/WEB-INF/jspf/footer.jspf" %>
            <!-- Footer Section END -->    

        </main>
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>