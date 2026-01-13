<%-- 
    Document   : admin/report
    Created on : Jan 2026
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<%@ include file="/WEB-INF/jspf/head.jspf" %>
<c:set var="pageTitle" value="Admin Reports" />

<body class="uikit">

    <%@ include file="/WEB-INF/jspf/nav.jspf" %>

    <main class="main-content">
        <div class="container-fluid content-inner p-3">

            <!-- Page Header -->
            <div class="row mb-3">
                <div class="col-12">
                    <h3 class="fw-bold">Appointment & Financial Reports</h3>
                    <p class="text-muted mb-0">Overview of appointments and billing status</p>
                </div>
            </div>

            <!-- Reports Table -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm border-0">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover table-bordered align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>#ID</th>
                                            <th>Patient</th>
                                            <th>Doctor</th>
                                            <th>Speciality</th>
                                            <th>Concern</th>
                                            <th>Status</th>
                                            <th>Total Amount (RM)</th>
                                            <th>Bill Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty reports}">
                                                <c:forEach var="r" items="${reports}">
                                                    <tr>
                                                        <td>${r.appointmentid}</td>
                                                        <td>${r.patient_name}</td>
                                                        <td>${r.doctor_name}</td>
                                                        <td>${r.specialityname}</td>
                                                        <td>${r.concern}</td>
                                                        <td>${r.status}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${r.totalamount != null}">
                                                                    RM ${r.totalamount}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    -
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${r.billstatus}</td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="8" class="text-center text-muted">
                                                        No reports available
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <%@ include file="/WEB-INF/jspf/footer.jspf" %>
    <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

</body>
</html>
