<%-- 
    Document   : Doctor Dashboard
    Created on : Dec 23, 2025, 5:42:57 PM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Dashboard" />
    
    <%-- Query today's appointments for the logged-in doctor --%>
    <sql:query var="todaysAppointments" dataSource="${myDatasource}">
        SELECT 
            a.appointmentid,
            a.status,
            a.concern,
            TO_CHAR(ts.starttime, 'HH12:MI AM') as starttime,
            TO_CHAR(ts.endtime, 'HH12:MI AM') as endtime,
            TO_CHAR(ds.scheduledate, 'Day, DD Month YYYY') as scheduledate,
            acc.fullname as patient_name,
            p.medicalrecordno
        FROM appointment a
        JOIN timeslot ts ON a.timeslotid = ts.timeslotid
        JOIN doctorschedule ds ON ts.scheduleid = ds.scheduleid
        JOIN patient p ON a.patientid = p.accountid
        JOIN account acc ON p.accountid = acc.accountid
        WHERE a.doctorid = ?
        AND ds.scheduledate = CURRENT_DATE
        AND a.status IN ('PENDING', 'CONFIRMED')
        ORDER BY ts.starttime ASC
        LIMIT 3
        <sql:param value="${sessionScope.loggedUser.accountID}" />
    </sql:query>
    
    <%-- Query upcoming appointments (next 7 days) --%>
    <sql:query var="upcomingAppointments" dataSource="${myDatasource}">
        SELECT 
            a.appointmentid,
            a.status,
            TO_CHAR(ts.starttime, 'HH12:MI AM') as starttime,
            TO_CHAR(ts.endtime, 'HH12:MI AM') as endtime,
            TO_CHAR(ds.scheduledate, 'Day, DD Month YYYY') as scheduledate,
            acc.fullname as patient_name
        FROM appointment a
        JOIN timeslot ts ON a.timeslotid = ts.timeslotid
        JOIN doctorschedule ds ON ts.scheduleid = ds.scheduleid
        JOIN patient p ON a.patientid = p.accountid
        JOIN account acc ON p.accountid = acc.accountid
        WHERE a.doctorid = ?
        AND ds.scheduledate > CURRENT_DATE
        AND ds.scheduledate <= CURRENT_DATE + INTERVAL '7 days'
        AND a.status IN ('PENDING', 'CONFIRMED')
        ORDER BY ds.scheduledate ASC, ts.starttime ASC
        LIMIT 3
        <sql:param value="${sessionScope.loggedUser.accountID}" />
    </sql:query>
    
    <%-- Query statistics --%>
    <sql:query var="stats" dataSource="${myDatasource}">
        SELECT 
            COUNT(CASE WHEN ds.scheduledate = CURRENT_DATE THEN 1 END) as today_count,
            COUNT(CASE WHEN ds.scheduledate > CURRENT_DATE AND ds.scheduledate <= CURRENT_DATE + INTERVAL '7 days' THEN 1 END) as week_count,
            COUNT(CASE WHEN a.status = 'COMPLETED' AND EXTRACT(MONTH FROM a.createdat) = EXTRACT(MONTH FROM CURRENT_DATE) THEN 1 END) as month_completed
        FROM appointment a
        JOIN timeslot ts ON a.timeslotid = ts.timeslotid
        JOIN doctorschedule ds ON ts.scheduleid = ds.scheduleid
        WHERE a.doctorid = ?
        AND a.status IN ('PENDING', 'CONFIRMED', 'COMPLETED')
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
                                    <h3 class="text-white fw-bold mb-1">Welcome Back, Dr. ${sessionScope.loggedUser.fullName}.</h3>
                                    <p class="text-white fs-6 mb-0 opacity-75">You are a Doctor</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Statistics Cards Row -->
                        <div class="col-12 mb-3">
                            <div class="row g-3">
                                <c:forEach var="stat" items="${stats.rows}">
                                    <!-- Today's Appointments -->
                                    <div class="col-12 col-md-4">
                                        <div class="card border-0 shadow-sm m-0">
                                            <div class="card-body text-center py-4">
                                                <div class="d-flex justify-content-center align-items-center mb-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-calendar-day text-primary" viewBox="0 0 16 16">
                                                        <path d="M4.684 11.523v-2.3h2.261v-.61H4.684V6.801h2.464v-.61H4v5.332h.684zm3.296 0h.676V8.98c0-.554.227-1.007.953-1.007.125 0 .258.004.329.015v-.613a1.806 1.806 0 0 0-.254-.02c-.582 0-.891.32-1.012.567h-.02v-.504H7.98v4.105zm2.805-5.093c0 .238.192.425.43.425a.428.428 0 1 0 0-.855.426.426 0 0 0-.43.43zm.094 5.093h.672V7.418h-.672v4.105z"/>
                                                        <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                                    </svg>
                                                </div>
                                                <h2 class="fw-bold text-primary mb-1 counter">${stat.today_count}</h2>
                                                <p class="mb-0 text-muted small">Today's Appointments</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- This Week -->
                                    <div class="col-12 col-md-4">
                                        <div class="card border-0 shadow-sm m-0">
                                            <div class="card-body text-center py-4">
                                                <div class="d-flex justify-content-center align-items-center mb-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-calendar-week text-success" viewBox="0 0 16 16">
                                                        <path d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-5 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
                                                        <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                                    </svg>
                                                </div>
                                                <h2 class="fw-bold text-success mb-1 counter">${stat.week_count}</h2>
                                                <p class="mb-0 text-muted small">This Week</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Completed This Month -->
                                    <div class="col-12 col-md-4">
                                        <div class="card border-0 shadow-sm m-0">
                                            <div class="card-body text-center py-4">
                                                <div class="d-flex justify-content-center align-items-center mb-2">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-check-circle text-info" viewBox="0 0 16 16">
                                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                                        <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
                                                    </svg>
                                                </div>
                                                <h2 class="fw-bold text-info mb-1 counter">${stat.month_completed}</h2>
                                                <p class="mb-0 text-muted small">Completed This Month</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Appointments Row -->
                        <div class="col-12 mb-3">
                            <div class="row g-3">
                                <!-- Today's Appointments Section -->
                                <div class="col-12 col-lg-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h5 class="mb-0 fw-semibold">Today's Appointments</h5>
                                                <a href="${pageContext.request.contextPath}/appointment" class="text-decoration-none text-primary fw-medium small">View All Appointments</a>
                                            </div>
                                            
                                            <c:choose>
                                                <c:when test="${todaysAppointments.rowCount > 0}">
                                                    <c:forEach var="appt" items="${todaysAppointments.rows}">
                                                        <div role="button" onclick="location.href='${pageContext.request.contextPath}/appointment/page?id=${appt.appointmentid}'" class="border rounded p-3 mb-3 border-1 border-primary" style="background-color: #f2f4fe;">
                                                            <div class="d-flex justify-content-between align-items-start">
                                                                <div class="d-flex gap-3">
                                                                    <div class="text-primary px-2">
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                                                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                                                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                                                                        </svg>
                                                                    </div>
                                                                    <div>
                                                                        <p class="mb-0 fw-medium text-primary">${appt.patient_name}</p>
                                                                        <p class="mb-0 text-dark small">MRN: ${appt.medicalrecordno}</p>
                                                                        <c:if test="${not empty appt.concern}">
                                                                            <p class="mb-0 text-muted small mt-1">Concern: ${appt.concern}</p>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                                <div class="text-end pe-2">
                                                                    <p class="mb-0 fw-medium text-primary">${appt.starttime} - ${appt.endtime}</p>
                                                                    <span class="badge ${appt.status == 'CONFIRMED' ? 'bg-success' : 'bg-warning'} small mt-1">${appt.status}</span>
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
                                                        <p class="mb-0">No appointments for today</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Upcoming Appointments Section -->
                                <div class="col-12 col-lg-6">
                                    <div class="card border-0 shadow-sm h-100">
                                        <div class="card-body">
                                            <h5 class="mb-4 fw-semibold">Upcoming This Week</h5>
                                            
                                            <c:choose>
                                                <c:when test="${upcomingAppointments.rowCount > 0}">
                                                    <c:forEach var="appt" items="${upcomingAppointments.rows}">
                                                        <div role="button" onclick="location.href='${pageContext.request.contextPath}/appointment/page?id=${appt.appointmentid}'" class="border rounded p-3 mb-3">
                                                            <div>
                                                                <h6 class="mb-1 fw-semibold text-truncate">${appt.patient_name}</h6>
                                                                <p class="mb-0 text-primary small fw-medium">${appt.scheduledate}</p>
                                                                <p class="mb-0 text-dark small">${appt.starttime} - ${appt.endtime}</p>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="text-center py-5 text-muted">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-calendar-week mb-3 opacity-50" viewBox="0 0 16 16">
                                                            <path d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-5 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
                                                            <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                                        </svg>
                                                        <p class="mb-0 small">No upcoming appointments</p>
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
                                <!-- Manage Schedule Card -->
                                <div class="col-12 col-md-4">
                                    <a href="${pageContext.request.contextPath}/schedule/manage" class="text-decoration-none">
                                        <div class="card border-0 shadow-sm h-100 text-white" style="background: linear-gradient(135deg, #2563eb 0%, #3b82f6 100%);">
                                            <div class="card-body text-center py-3 d-flex flex-column justify-content-center align-items-center">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-calendar-event mb-2" viewBox="0 0 16 16">
                                                    <path d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
                                                    <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                                </svg>
                                                <h5 class="fw-semibold m-0 text-white">Manage Schedule</h5>
                                                <p class="mb-0 small lh-1 mt-1 text-white">Set your availability and working hours</p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                
                                <!-- View Appointments Card -->
                                <div class="col-12 col-md-4">
                                    <a href="${pageContext.request.contextPath}/appointment" class="text-decoration-none">
                                        <div class="card border shadow-sm h-100">
                                            <div class="card-body text-center py-3 d-flex flex-column justify-content-center align-items-center">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-calendar-check text-secondary mb-2" viewBox="0 0 16 16">
                                                    <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                                                    <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                                                </svg>
                                                <h5 class="fw-semibold m-0 text-dark">View Appointments</h5>
                                                <p class="mb-0 small lh-1 mt-1 text-muted">See all your scheduled appointments</p>
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