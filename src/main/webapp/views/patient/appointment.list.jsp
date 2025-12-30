<%-- 
    Document   : appointment.list
    Created on : Dec 24, 2025, 9:47:05 AM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="My Appointments" />   
    <style>
        .appointment-tab {
            padding: 0.5rem 1rem;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            color: #6c757d;
            font-weight: 500;
            transition: all 0.2s;
        }

        .appointment-tab.active {
            border-bottom-color: var(--bs-primary);
            color: #000;
            font-weight: 600;
        }

        .card-anim {
            transition: all 0.3s;
        }

        .card-anim:hover {
            transform: scale(1.015);
            filter: drop-shadow(0 5px 10px #3a57e81f);
        }
    </style>
    
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
                <div class="container-fluid content-inner p-3">
                    <%-- Breadcrumb Start --%> 
                    <div class="col-12">
                        <div class="card py-3 px-5 mb-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item">
                                                <a href="#">Appointments</a>
                                            </li>
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
                    <%-- Breadcrumb END --%>

                    <%-- Appointment Filter Start --%> 
                    <div class="row g-3">
                        <div class="col-md-10">
                            <div class="row g-3">
                                <div class="col-md-9">
                                    <input  id="searchInput" type="text" style="font-size: 0.875rem;" class="form-control py-2 px-5" placeholder="Search Appointment">
                                </div>
                                <div class="col-md-3">
                                    <select id="statusFilter" class="form-select py-2">
                                        <option value="">All Status</option>
                                        <option value="SENT REQUEST">Sent Request</option>
                                        <option value="CONFIRMED">Confirmed</option>
                                        <option value="COMPLETED">Completed</option>
                                        <option value="CANCELLED">Cancelled</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2 d-grid">
                            <button type="button" onclick="window.location.href='/eHAS/appointment/book'" class="btn btn-sm btn-primary text-nowrap d-flex align-items-center gap-2">
                                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8.00033 3.33331V12.6666" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M3.33301 8.00002H12.6663" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>

                                Book Appointment
                            </button>
                        </div>
                        <div class="col-12 border-bottom px-4 mb-3">
                            <div class="row">
                                <div role="button"
                                    id="tabUpcoming"
                                    class="col-auto appointment-tab active">
                                    Upcoming Appointments
                                </div>

                                <div role="button"
                                    id="tabPast"
                                    class="col-auto appointment-tab">
                                    Past Appointments
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Appointment Filter END --%>

                    <%-- Display Appointment Start --%> 
                    <div class="conatiner-fluid p-0 mt-3">
                        <c:set var="accountID" value="${sessionScope.loggedUser.accountID}" />
                        <sql:query var="results" dataSource="${myDatasource}"> 
                            SELECT A.APPOINTMENTID, A.STATUS, AC.FULLNAME,  TO_CHAR(T.STARTTIME, 'HH:MI AM') AS STARTTIME,
                                   TO_CHAR(T.ENDTIME, 'HH:MI AM') AS ENDTIME, TO_CHAR(D.SCHEDULEDATE, 'DD') AS DATE, 
                                   UPPER(TO_CHAR(D.SCHEDULEDATE, 'Mon')) AS MONTH, D.SCHEDULEDATE
                            FROM APPOINTMENT A
                            LEFT JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID
                            LEFT JOIN DOCTORSCHEDULE D ON T.SCHEDULEID = D.SCHEDULEID 
                            LEFT JOIN ACCOUNT AC ON D.DOCTORID = AC.ACCOUNTID 
                            WHERE PATIENTID = ? ORDER BY A.CREATEDAT DESC
                            <sql:param value="${accountID}" />
                        </sql:query>
                        <c:choose>
                            <c:when test="${empty results.rows}">
                                <%-- If user hasn't booked any appointment yet --%> 
                                <div class="d-flex justify-content-center m-5">
                                    <p>You do not have any appointments booked yet.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="row g-3 px-3 py-1">
                                    <c:forEach var="result" items="${results.rows}">
                                        <div 
                                            role="button"
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/appointment/list/page?id=${result.appointmentID}'"
                                            class="col-md-4 appointment-card card-anim mt-0"
                                            data-status="${result.STATUS}"
                                            data-doctor="${fn:toLowerCase(result.FULLNAME)}"
                                            data-date="${result.SCHEDULEDATE}"
                                        >
                                            <div class="card shadow-sm border-0 rounded-3 mb-3">
                                                <div class="card-body p-4">
                                                    <div class="d-flex gap-3">
                                                        <div class="bg-primary text-white rounded-3 text-center d-flex flex-column justify-content-center align-items-center px-5 py-0">
                                                            <h2 class="fw-bold text-white lh-1 mb-0">${result.DATE}</h2>
                                                            <p class="fs-4 fw-semibold mb-0 lh-1">${result.MONTH}</p>
                                                        </div>
                                                        
                                                        <div class="flex-grow-1 d-flex flex-column gap-2 justify-content-between">
                                                            <div>
                                                                <span 
                                                                    class="
                                                                        badge 
                                                                        px-3 py-2 fw-normal
                                                                        <c:choose>
                                                                            <c:when test="${result.STATUS == 'PENDING'}">
                                                                                bg-primary bg-opacity-25 text-primary
                                                                            </c:when>
                                                                            <c:when test="${result.STATUS == 'CONFIRMED'}">
                                                                                bg-primary text-white
                                                                            </c:when>
                                                                            <c:when test="${result.STATUS == 'COMPLETED'}">
                                                                                bg-secondary text-white
                                                                            </c:when>
                                                                            <c:when test="${result.STATUS == 'CANCELLED'}">
                                                                                bg-danger text-white
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                bg-dark text-white
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    "
                                                                >
                                                                    ${result.STATUS}
                                                                </span>
                                                            </div>
                                                            
                                                            <div class="d-flex flex-column">
                                                                <p class="card-title fs-6 m-0 lh-1 mt-2 mb-1 fw-semibold">Appointment Session</p>
                                                                <p class="card-text m-0 fw-normal text-dark lh-1"><small>${result.FULLNAME}</small></p>
                                                            </div>
                                                            
                                                            <div class="text-secondary d-flex align-items-center gap-1 text-muted">
                                                                <svg width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                    <path d="M7.16634 13.8333C3.48444 13.8333 0.499676 10.8486 0.499676 7.16667C0.499676 3.48477 3.48444 0.5 7.16634 0.5C10.8482 0.5 13.833 3.48477 13.833 7.16667C13.833 10.8486 10.8482 13.8333 7.16634 13.8333Z" stroke="currentColor"/>
                                                                    <path d="M7.16602 4.5V7.16667L5.49935 8.83333" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                                                                </svg>
                                                                ${result.STARTTIME} - ${result.ENDTIME}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <p id="noResults" class="text-center mt-4" style="display:none;">
                                    No appointments found.
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <%-- Display Appointment END --%>
                </div>
                <%-- Main Section END --%> 
            </div>
                
            <!-- Footer Section Start -->
            <%@ include file="/WEB-INF/jspf/footer.jspf" %>
            <!-- Footer Section END -->
        </main>
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        
        <script>
        $(document).ready(function () {

            let activeTab = "upcoming";

            function filterAppointments() {
                const search = $("#searchInput").val().toLowerCase();
                const status = $("#statusFilter").val();

                const today = new Date().toISOString().split("T")[0];
                let visibleCount = 0;

                $(".appointment-card").each(function () {
                    const card = $(this);

                    const cardStatus = card.data("status");
                    const doctorName = card.data("doctor");
                    const date = card.data("date"); // YYYY-MM-DD

                    let show = true;

                    if (status && cardStatus !== status) show = false;
                    if (search && !doctorName.includes(search)) show = false;

                    if (activeTab === "upcoming" && date < today) show = false;
                    if (activeTab === "past" && date >= today) show = false;

                    card.toggle(show);
                    if (show) visibleCount++;
                });

                $("#noResults").toggle(visibleCount === 0);
            }

            $("#searchInput").on("input", filterAppointments);
            $("#statusFilter").on("change", filterAppointments);

            $("#tabUpcoming").on("click", function () {
                activeTab = "upcoming";
                $(".appointment-tab").removeClass("active");
                $(this).addClass("active");
                filterAppointments();
            });

            $("#tabPast").on("click", function () {
                activeTab = "past";
                $(".appointment-tab").removeClass("active");
                $(this).addClass("active");
                filterAppointments();
            });


            filterAppointments();
        });
        </script>


    </body>
</html>
