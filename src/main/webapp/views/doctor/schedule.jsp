
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Schedule" />
    
    <!-- Fullcalender CSS -->
    <link rel='stylesheet' href='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/core/main.css' />
    <link rel='stylesheet' href='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/daygrid/main.css' />
    <link rel='stylesheet' href='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/timegrid/main.css' />
    <link rel='stylesheet' href='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/list/main.css' />
    <style>
        .fc-event {
             height: 65px !important; 
             border-radius: 7px !important;
        }

        .fc-event:hover {
            background: #2e46ba !important;
        }

        .fc-event .fc-content {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            font-weight: lighter;
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

                    <div class="row">
                        <div class="col-md-9 pe-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div id="calendar1" class="calendar-s"></div>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 ps-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title mb-3" style="font-size: 1.1rem;">Actions</h5>
                                    <div class="row px-4 g-2">
                                        <button class="btn btn-primary col-12 d-flex flex-column align-items-center rounded-3 justify-content-center py-3 gap-2"
                                                data-bs-toggle="modal" data-bs-target="#rescheduleModal">
                                            <svg width="23" height="23" viewBox="0 0 23 23" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M8.21429 0L6.57143 0.383333V1.53333H8.21429V0ZM8.21429 1.53333V3.06667H6.57143V1.53333H6.56157C4.49321 1.5548 2.98014 1.48733 1.74471 2.12213C1.127 2.44107 0.635786 2.9808 0.364714 3.65393C0.0952857 4.32553 0 5.12593 0 6.13333V18.4C0 19.4074 0.0952857 20.2063 0.364714 20.8794C0.635786 21.5525 1.127 22.0877 1.74471 22.4066C2.98179 23.0429 4.49486 22.977 6.56157 23H16.4384C18.5051 22.977 20.0166 23.0429 21.2536 22.4066C21.8937 22.0678 22.3822 21.5259 22.6304 20.8794C22.9014 20.2063 23 19.3614 23 18.4V6.13333C23 5.1244 22.9014 4.32553 22.6304 3.65393C22.3816 3.00696 21.8933 2.46425 21.2536 2.12367C20.0166 1.4858 18.5051 1.55633 16.4384 1.53333H16.4286V3.06667H14.7857V1.53333H8.21429ZM14.7857 1.53333H16.4286V0L14.7857 0.383333V1.53333ZM6.58129 7.66667H16.4286C18.4986 7.68813 19.8572 7.75867 20.4585 8.06687C20.7591 8.22327 20.9333 8.39347 21.0926 8.79213C21.2536 9.1908 21.3555 10.7333 21.3555 10.7333V18.4C21.3555 19.3077 21.2536 19.941 21.0926 20.3397C20.9333 20.7383 20.7591 20.9101 20.4585 21.0649C19.8572 21.3747 18.4969 21.4437 16.4286 21.4667H6.57143C4.50143 21.4437 3.14279 21.3747 2.53986 21.0649C2.23921 20.9101 2.06507 20.7383 1.90571 20.3397C1.74471 19.941 1.64286 19.3077 1.64286 18.4V10.7333C1.64286 9.82407 1.74471 9.1908 1.90571 8.79213C2.06507 8.39347 2.23921 8.22327 2.53986 8.06687C3.14279 7.75713 4.50471 7.68813 6.58129 7.66667Z" fill="white"/>
                                            </svg>
                                            Update Availability
                                        </button>
                                    </div>
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

        <!-- Fullcalender Javascript -->
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/core/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/daygrid/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/timegrid/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/list/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/interaction/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/moment.min.js'></script>

        <script>
            if (document.querySelectorAll('#calendar1').length) {
                document.addEventListener('DOMContentLoaded', function () {
                    let calendarEl = document.getElementById('calendar1');
                    let calendar1 = new FullCalendar.Calendar(calendarEl, {
                    handleWindowResize: false,
                    selectable: true,
                    plugins: ["timeGrid", "dayGrid", "list", "interaction"],
                    timeZone: "UTC",
                    defaultView: "dayGridMonth",
                    contentHeight: "auto",
                    eventLimit: true,
                    dayMaxEvents: 4,
                    header: {
                        left: "prev,today",
                        center: "title",
                        right: "next"
                    },
                    dateClick: function (info) {
                        $('#schedule-start-date').val(info.dateStr)
                        $('#schedule-end-date').val(info.dateStr)
                        $('#date-event').modal('show')
                    },
                    events: [
                        <c:set var="accountID" value="${sessionScope.loggedUser.accountID}" />
                        <sql:query var="results" dataSource="${myDatasource}"> 
                            SELECT D.SCHEDULEID, TO_CHAR(D.SCHEDULEDATE, 'yyyy-MM-dd') AS SCHEDULEDATE, (SELECT COUNT(*) FROM TIMESLOT WHERE SCHEDULEID = D.SCHEDULEID) AS SLOT_COUNT
                            FROM DOCTORSCHEDULE D
                            WHERE D.SCHEDULEDATE > CURRENT_DATE 
                            AND D.DOCTORID = ?::Integer
                            <sql:param value="${accountID}" />
                        </sql:query>
                        <c:forEach var="row" items="${results.rows}" varStatus="loop">
                        {
                            title: '${row.SLOT_COUNT}\nSLOTS',
                            url: '${pageContext.request.contextPath}/schedule/date?id=${row.SCHEDULEID}',
                            start: '${row.SCHEDULEDATE}',
                            backgroundColor: '#3a57e8',
                            textColor: 'white',
                            borderColor: '#3a57e8',
                            extendedProps: {
                                scheduleID: '${row.SCHEDULEID}'
                            }
                        }<c:if test="${!loop.last}">,</c:if>
                        </c:forEach>     
                    ]
                });
                calendar1.render();
                });
                
            }
        </script>
    </body>
</html>
