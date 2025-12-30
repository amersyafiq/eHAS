<%-- 
    Document   : appointment.list
    Created on : Dec 24, 2025, 9:47:05 AM
    Author     : ASUS
--%>

<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="My Appointments" />   
    
    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
        <!-- loader Start -->
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body"></div>
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
                <div class="container-fluid content-inner p-3">
                    
                    <%-- Breadcrumb Start --%>
                    <div class="row mb-3">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body py-3">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <nav aria-label="breadcrumb">
                                                <ol class="breadcrumb mb-0">
                                                    <li class="breadcrumb-item"><a href="#">Appointments</a></li>
                                                    <li class="breadcrumb-item active" aria-current="page">${pageTitle}</li>
                                                </ol>
                                            </nav>
                                        </div>
                                        <div class="col-auto">
                                            <button onclick="window.location.href='${pageContext.request.contextPath}/'" class="btn btn-sm btn-primary">Home</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Breadcrumb END --%>

                    <%-- Filter Section Start --%>
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row g-3 align-items-center">
                                        <div class="col-md-4">
                                            <div class="input-group">
                                                <span class="input-group-text bg-white border-end-0">
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M11 19C15.4183 19 19 15.4183 19 11C19 6.58172 15.4183 3 11 3C6.58172 3 3 6.58172 3 11C3 15.4183 6.58172 19 11 19Z" stroke="#8A92A6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M21 21L16.65 16.65" stroke="#8A92A6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                    </svg>
                                                </span>
                                                <input type="text" id="searchInput" class="form-control border-start-0" placeholder="Search Appointment">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <select class="form-select" id="dateRangeFilter">
                                                <option value="">Date Range</option>
                                                <option value="upcoming">Upcoming</option>
                                                <option value="past">Past</option>
                                                <option value="today">Today</option>
                                                <option value="this-week">This Week</option>
                                                <option value="this-month">This Month</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <select class="form-select" id="statusFilter">
                                                <option value="">Type</option>
                                                <option value="ACCEPTED">Accepted</option>
                                                <option value="SENT_REQUEST">Sent Request</option>
                                                <option value="COMPLETED">Completed</option>
                                                <option value="CANCELLED">Cancelled</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <button 
                                                type="button"    
                                                onclick="window.location.href='${pageContext.request.contextPath}/appointment/book'"
                                                class="btn btn-primary w-100"
                                            >
                                                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg" class="me-1">
                                                    <path d="M8 3.33331V12.6666" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                    <path d="M3.33301 8H12.6663" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                </svg>
                                                Book Appointment
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Filter Section END --%>

                    <%-- Tabs Navigation --%>
                    <div class="row mb-3">
                        <div class="col-12">
                            <ul class="nav nav-tabs" id="appointmentTabs" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="upcoming-tab" data-bs-toggle="tab" data-bs-target="#upcoming" type="button" role="tab">
                                        Upcoming Appointments
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="past-tab" data-bs-toggle="tab" data-bs-target="#past" type="button" role="tab">
                                        Past Appointments
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <%-- Appointments List --%>
                    <div class="tab-content" id="appointmentTabsContent">
                        <%-- Upcoming Appointments --%>
                        <div class="tab-pane fade show active" id="upcoming" role="tabpanel">
                            <div class="row g-3" id="upcomingAppointments">

                                <sql:query var="appointments" dataSource="${myDatasource}">
                                    SELECT A.APPOINTMENTID, A.STATUS, AC.FULLNAME, T.STARTTIME, T.ENDTIME, 
                                        TO_CHAR(D.SCHEDULEDATE, 'DD') AS DATE, 
                                        UPPER(TO_CHAR(D.SCHEDULEDATE, 'Mon')) AS MONTH,
                                        D.SCHEDULEDATE,
                                        A.CREATEDAT
                                    FROM APPOINTMENT A
                                    LEFT JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID
                                    LEFT JOIN DOCTORSCHEDULE D ON T.SCHEDULEID = D.SCHEDULEID 
                                    LEFT JOIN ACCOUNT AC ON D.DOCTORID = AC.ACCOUNTID 
                                    WHERE A.PATIENTID = ?
                                    ORDER BY A.CREATEDAT DESC
                                    <sql:param value="${sessionScope.userId}" />
                                </sql:query>
                                
                                <c:forEach var="apt" items="${appointments.rows}">
                                    <jsp:useBean id="now" class="java.util.Date"/>
                                    <fmt:parseDate value="${apt.SCHEDULEDATE}" pattern="yyyy-MM-dd" var="aptDate"/>
                                    <c:if test="${aptDate >= now}">
                                        <div class="col-12 appointment-card" 
                                             data-status="${apt.STATUS}"
                                             data-doctor="${apt.FULLNAME}"
                                             data-date="${apt.SCHEDULEDATE}"
                                             data-search="${apt.FULLNAME} ${apt.STATUS} ${apt.MONTH} ${apt.DATE}">
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-auto">
                                                            <div class="bg-primary text-white text-center rounded p-3" style="min-width: 80px;">
                                                                <h2 class="mb-0 fw-bold">${apt.DATE}</h2>
                                                                <div class="fw-semibold">${apt.MONTH}</div>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="d-flex align-items-start justify-content-between">
                                                                <div>
                                                                    <div class="d-flex align-items-center gap-2 mb-2">
                                                                        <c:choose>
                                                                            <c:when test="${apt.STATUS == 'ACCEPTED'}">
                                                                                <span class="badge bg-success-subtle text-success">Accepted</span>
                                                                            </c:when>
                                                                            <c:when test="${apt.STATUS == 'SENT_REQUEST'}">
                                                                                <span class="badge bg-warning-subtle text-warning">Sent Request</span>
                                                                            </c:when>
                                                                            <c:when test="${apt.STATUS == 'COMPLETED'}">
                                                                                <span class="badge bg-info-subtle text-info">Completed</span>
                                                                            </c:when>
                                                                            <c:when test="${apt.STATUS == 'CANCELLED'}">
                                                                                <span class="badge bg-danger-subtle text-danger">Cancelled</span>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </div>
                                                                    <h5 class="mb-1">Appointment Session</h5>
                                                                    <p class="text-muted mb-1">${apt.FULLNAME} - Oncologist Department</p>
                                                                    <div class="d-flex align-items-center text-muted small">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="me-1">
                                                                            <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                                                                            <path d="M12 6V12L16 14" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                                                        </svg>
                                                                        <fmt:formatDate value="${apt.STARTTIME}" pattern="hh:mm a" var="startTime"/>
                                                                        <fmt:formatDate value="${apt.ENDTIME}" pattern="hh:mm a" var="endTime"/>
                                                                        ${apt.STARTTIME} - ${apt.ENDTIME}
                                                                    </div>
                                                                </div>
                                                                <button class="btn btn-light btn-sm" onclick="viewDetails(${apt.APPOINTMENTID})">
                                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="me-1">
                                                                        <path d="M1 12C1 12 5 4 12 4C19 4 23 12 23 12C23 12 19 20 12 20C5 20 1 12 1 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                                        <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2"/>
                                                                    </svg>
                                                                    View Details
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>

                        <%-- Past Appointments --%>
                        <div class="tab-pane fade" id="past" role="tabpanel">
                            <div class="row g-3" id="pastAppointments">
                                <c:forEach var="apt" items="${appointments.rows}">
                                    <jsp:useBean id="nowPast" class="java.util.Date"/>
                                    <fmt:parseDate value="${apt.SCHEDULEDATE}" pattern="yyyy-MM-dd" var="aptDatePast"/>
                                    <c:if test="${aptDatePast < nowPast}">
                                        <div class="col-12 appointment-card" 
                                             data-status="${apt.STATUS}"
                                             data-doctor="${apt.FULLNAME}"
                                             data-date="${apt.SCHEDULEDATE}"
                                             data-search="${apt.FULLNAME} ${apt.STATUS} ${apt.MONTH} ${apt.DATE}">
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row align-items-center">
                                                        <div class="col-auto">
                                                            <div class="bg-secondary text-white text-center rounded p-3" style="min-width: 80px;">
                                                                <h2 class="mb-0 fw-bold">${apt.DATE}</h2>
                                                                <div class="fw-semibold">${apt.MONTH}</div>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="d-flex align-items-start justify-content-between">
                                                                <div>
                                                                    <div class="d-flex align-items-center gap-2 mb-2">
                                                                        <c:choose>
                                                                            <c:when test="${apt.STATUS == 'COMPLETED'}">
                                                                                <span class="badge bg-success-subtle text-success">Completed</span>
                                                                            </c:when>
                                                                            <c:when test="${apt.STATUS == 'CANCELLED'}">
                                                                                <span class="badge bg-danger-subtle text-danger">Cancelled</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="badge bg-secondary-subtle text-secondary">${apt.STATUS}</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                    <h5 class="mb-1">Appointment Session</h5>
                                                                    <p class="text-muted mb-1">${apt.FULLNAME} - Oncologist Department</p>
                                                                    <div class="d-flex align-items-center text-muted small">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="me-1">
                                                                            <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2"/>
                                                                            <path d="M12 6V12L16 14" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                                                        </svg>
                                                                        ${apt.STARTTIME} - ${apt.ENDTIME}
                                                                    </div>
                                                                </div>
                                                                <button class="btn btn-light btn-sm" onclick="viewDetails(${apt.APPOINTMENTID})">
                                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class="me-1">
                                                                        <path d="M1 12C1 12 5 4 12 4C19 4 23 12 23 12C23 12 19 20 12 20C5 20 1 12 1 12Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                                        <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2"/>
                                                                    </svg>
                                                                    View Details
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
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
        
        <%-- Client-Side Filtering Script --%>
        <script>
            // Filter functionality
            function filterAppointments() {
                const searchTerm = document.getElementById('searchInput').value.toLowerCase();
                const statusFilter = document.getElementById('statusFilter').value;
                const dateRangeFilter = document.getElementById('dateRangeFilter').value;
                
                const cards = document.querySelectorAll('.appointment-card');
                
                cards.forEach(card => {
                    const searchData = card.getAttribute('data-search').toLowerCase();
                    const cardStatus = card.getAttribute('data-status');
                    const cardDate = new Date(card.getAttribute('data-date'));
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);
                    
                    let showCard = true;
                    
                    // Search filter
                    if (searchTerm && !searchData.includes(searchTerm)) {
                        showCard = false;
                    }
                    
                    // Status filter
                    if (statusFilter && cardStatus !== statusFilter) {
                        showCard = false;
                    }
                    
                    // Date range filter
                    if (dateRangeFilter) {
                        const dayInMs = 24 * 60 * 60 * 1000;
                        const weekStart = new Date(today.getTime() - (today.getDay() * dayInMs));
                        const monthStart = new Date(today.getFullYear(), today.getMonth(), 1);
                        
                        switch(dateRangeFilter) {
                            case 'upcoming':
                                if (cardDate < today) showCard = false;
                                break;
                            case 'past':
                                if (cardDate >= today) showCard = false;
                                break;
                            case 'today':
                                if (cardDate.toDateString() !== today.toDateString()) showCard = false;
                                break;
                            case 'this-week':
                                if (cardDate < weekStart || cardDate > new Date(today.getTime() + (7 * dayInMs))) showCard = false;
                                break;
                            case 'this-month':
                                if (cardDate < monthStart || cardDate.getMonth() !== today.getMonth()) showCard = false;
                                break;
                        }
                    }
                    
                    card.style.display = showCard ? 'block' : 'none';
                });
            }
            
            // Add event listeners
            document.getElementById('searchInput').addEventListener('input', filterAppointments);
            document.getElementById('statusFilter').addEventListener('change', filterAppointments);
            document.getElementById('dateRangeFilter').addEventListener('change', filterAppointments);
            
            // View details function
            function viewDetails(appointmentId) {
                window.location.href = '${pageContext.request.contextPath}/appointment/details?id=' + appointmentId;
            }
        </script>
    </body>
</html>
