<%-- 
    Document   : appointment.list
    Created on : Dec 24, 2025, 9:47:05 AM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="My Appointments" />   
    
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
                                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Appointments</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">All Appointments</li>
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

                    <div class="col-12">
                        <div class="card py-3 px-4 mb-3">
                            <div class="table-responsive">
                                <table id="electionTable" class="table" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th class="bg-primary text-white fw-normal rounded-start-5"><small>PATIENT NAME</small></th>
                                            <th class="bg-primary text-white fw-normal"><small>STATUS</small></th>
                                            <th class="bg-primary text-white fw-normal"><small>APPOINTMENT DATE</small></th>
                                            <th class="bg-primary text-white fw-normal"><small>TIMESLOT</small></th>
                                            <th class="bg-primary text-white fw-normal rounded-end-5"><small>ACTION</small></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="accountID" value="${sessionScope.loggedUser.accountID}" />
                                        <sql:query var="results" dataSource="${myDatasource}"> 
                                            SELECT A.APPOINTMENTID, 
                                                UPPER(A.STATUS) AS STATUS, 
                                                PA.FULLNAME AS PATIENT_NAME,
                                                PA.PICTUREPATH AS PATIENT_PICTURE,
                                                DA.FULLNAME AS DOCTOR_NAME,
                                                TO_CHAR(T.STARTTIME, 'HH:MI AM') AS STARTTIME,
                                                TO_CHAR(T.ENDTIME, 'HH:MI AM') AS ENDTIME, 
                                                D.SCHEDULEDATE
                                            FROM APPOINTMENT A
                                            LEFT JOIN PATIENT P ON A.PATIENTID = P.ACCOUNTID
                                            LEFT JOIN ACCOUNT PA ON P.ACCOUNTID = PA.ACCOUNTID
                                            LEFT JOIN DOCTOR DR ON A.DOCTORID = DR.ACCOUNTID
                                            LEFT JOIN ACCOUNT DA ON DR.ACCOUNTID = DA.ACCOUNTID
                                            LEFT JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID
                                            LEFT JOIN DOCTORSCHEDULE D ON T.SCHEDULEID = D.SCHEDULEID 
                                            WHERE A.DOCTORID = ? 
                                            AND CURRENT_TIMESTAMP < D.SCHEDULEDATE
                                            ORDER BY D.SCHEDULEDATE DESC, T.STARTTIME ASC
                                            <sql:param value="${accountID}" />
                                        </sql:query>
                                        <c:forEach var="appointment" items="${results.rows}">
                                            <tr>
                                                <td class="py-2"><img src="${appointment.patient_picture}" onerror="this.onerror=null; this.src='https://placehold.co/600x400?text=No+Image';" alt="Patient Profile" class="theme-color-default-img img-fluid avatar avatar-rounded border border-1 border-primary" style="width: 35px; height: 35px;">&emsp;&nbsp;${appointment.patient_name}</td>
                                                <td class="py-2">
                                                    <span 
                                                        class="
                                                            badge 
                                                            px-3 py-2 fw-normal
                                                            <c:choose>
                                                                <c:when test="${appointment.STATUS == 'PENDING'}">
                                                                    bg-primary bg-opacity-25 text-primary
                                                                </c:when>
                                                                <c:when test="${appointment.STATUS == 'CONFIRMED'}">
                                                                    bg-primary text-white
                                                                </c:when>
                                                                <c:when test="${appointment.STATUS == 'COMPLETED'}">
                                                                    bg-secondary text-white
                                                                </c:when>
                                                                <c:when test="${appointment.STATUS == 'CANCELLED'}">
                                                                    bg-danger text-white
                                                                </c:when>
                                                                <c:otherwise>
                                                                    bg-dark text-white
                                                                </c:otherwise>
                                                            </c:choose>
                                                        "
                                                    >
                                                        ${appointment.STATUS}
                                                    </span>
                                                </td>
                                                <td class="py-2"><fmt:formatDate value="${appointment.SCHEDULEDATE}" pattern="MMMM d, yyyy"/></td>
                                                <td class="py-2">${appointment.STARTTIME} - ${appointment.ENDTIME}</td>
                                                <td class="py-2">
                                                    <a href="${pageContext.request.contextPath}/elections/page/${appointment.election_id}" class="action-link d-flex align-items-center gap-2">
                                                        <c:choose>
                                                            <c:when test="${appointment.status == 'closed' || appointment.status == 'cancelled' || appointment.status == 'active'}">
                                                                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                    <circle cx="9.99992" cy="10.0002" r="1.66667" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                                    <path d="M18.3334 9.99984C16.1109 13.889 13.3334 15.8332 10.0001 15.8332C6.66675 15.8332 3.88925 13.889 1.66675 9.99984C3.88925 6.11067 6.66675 4.1665 10.0001 4.1665C13.3334 4.1665 16.1109 6.11067 18.3334 9.99984" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                                </svg>
                                                                View
                                                            </c:when>
                                                            <c:otherwise>
                                                                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                    <path d="M7.49992 5.83325H4.99992C4.07944 5.83325 3.33325 6.57944 3.33325 7.49992V14.9999C3.33325 15.9204 4.07944 16.6666 4.99992 16.6666H12.4999C13.4204 16.6666 14.1666 15.9204 14.1666 14.9999V12.4999" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                                    <path d="M7.5 12.5H10L17.0833 5.41669C17.7737 4.72634 17.7737 3.60705 17.0833 2.91669C16.393 2.22634 15.2737 2.22634 14.5833 2.91669L7.5 10V12.5" stroke="#7367F0" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                                    <path d="M13.3333 4.16675L15.8333 6.66675" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                                                                </svg>
                                                                Modify
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
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
        <script>
            $(document).ready(function () {
                const table = $('#electionTable').DataTable({
                    paging: true,
                    pageLength: 10,
                    lengthMenu: [10, 25, 50, 100],
                    searching: true,
                    ordering: true,
                    order: [],
                    info: true,
                    responsive: true,
                    dom: 'rt<"bottom"ip><"clear">',
                    columnDefs: [
                        { orderable: false, targets: 4 }, 
                        { searchable: false, targets: [1, 2, 3] }
                    ],
                    language: {
                        search: "",
                        searchPlaceholder: "Search Election",
                        info: "Showing _START_ to _END_ of _TOTAL_ entries",
                        lengthMenu: "Show _MENU_ entries",
                        paginate: {
                            previous: "«",
                            next: "»"
                        }
                    },
                    initComplete: function () {
                        $('#page-length').val(this.api().page.len());
                    }
                });

                $('#page-length').on('change', function () {
                    table.page.len($(this.val())).draw();
                });

                $('#global-search').on('keyup', function () {
                    table.search(this.value).draw();
                });
            });

        </script>
        
    </body>
</html>