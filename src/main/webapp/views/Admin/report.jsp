<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light">

<%@ include file="/WEB-INF/jspf/head.jspf" %>
<c:set var="pageTitle" value="Health Reports" />

<body class="uikit">

    <div id="loading">
        <div class="loader simple-loader">
            <div class="loader-body"></div>
        </div>
    </div>

    <%-- Navigation Sidebar --%>
    <%@ include file="/WEB-INF/jspf/nav.jspf" %>

    <main class="main-content">
        <div class="position-relative iq-banner">

            <%-- Header --%>
            <%@ include file="/WEB-INF/jspf/header.jspf" %>

            <div class="container-fluid content-inner p-3">

                <div class="row mb-3">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body py-4 px-4">
                                <h3 class="fw-bold mb-1">Health & Consultation Reports</h3>
                                <p class="text-muted mb-0">Overview of patient appointments and consultations</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-12">
                        <div class="card shadow-sm border-0">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>#</th>
                                                <th>Patient</th>
                                                <th>Doctor</th>
                                                <th>Specialty</th>
                                                <th>Appointment Date</th>
                                                <th>Status</th>
                                                <th>Consultation Notes</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${reports}" var="r" varStatus="i">
                                                <tr>
                                                    <td>${i.count}</td>
                                                    <td><strong>${r.patient_name}</strong></td>
                                                    <td>${r.doctor_name}</td>
                                                    <td>${r.specialty_name}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty r.appointmentdate}">
                                                                <fmt:formatDate value="${r.appointmentdate}" pattern="dd/MM/yyyy HH:mm"/>
                                                            </c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <%-- Adding a simple badge class for better visibility within your design --%>
                                                        <span class="badge ${r.status == 'Completed' ? 'bg-success' : 'bg-primary'}">
                                                            ${r.status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <%-- Truncated notes to prevent row stretching --%>
                                                        <div style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${r.consultation_notes}">
                                                            ${r.consultation_notes}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <a href="${pageContext.request.contextPath}/Admin/report/edit?id=${r.appointmentid}" 
                                                               class="btn btn-sm btn-soft-primary">View</a>
                                                            <a href="${pageContext.request.contextPath}/Admin/report/delete?id=${r.appointmentid}" 
                                                               onclick="return confirm('Delete this report?');" 
                                                               class="btn btn-sm btn-soft-danger">Delete</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty reports}">
                                                <tr>
                                                    <td colspan="8" class="text-center py-4 text-muted">No reports available in the database.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <%-- Footer --%>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>

    </main>

    <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

</body>
</html>