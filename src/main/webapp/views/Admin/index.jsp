<%-- 
    Document   : admin/index
    Created on : Jan 2026
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Admin Dashboard" />

    <%-- Admin Summary Query --%>
    <sql:query var="summary" dataSource="${myDatasource}">
        SELECT
            (SELECT COUNT(*) FROM appointment) AS total_appointments,
            (SELECT COUNT(*) FROM appointment WHERE status = 'PENDING') AS pending_appointments,
            (SELECT COUNT(*) FROM appointment WHERE billstatus = 'UNPAID') AS unpaid_bills,
            (SELECT COALESCE(SUM(totalamount), 0) 
             FROM appointment WHERE billstatus = 'PAID') AS total_revenue
    </sql:query>

    <body class="uikit">

        <!-- Loader -->
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body"></div>
            </div>
        </div>

        <%-- Navigation (ADMIN ONLY) --%>
        <%@ include file="/WEB-INF/jspf/nav.jspf" %>

        <main class="main-content">
            <div class="position-relative iq-banner">

                <%-- Header --%>
                <%@ include file="/WEB-INF/jspf/header.jspf" %>

                <div class="container-fluid content-inner p-3">

                    <!-- Welcome Banner -->
                    <div class="row mb-3">
                        <div class="col-12">
                            <div class="card border-0"
                                 style="background: linear-gradient(90deg, #111827 0%, #1f2937 100%);">
                                <div class="card-body py-4 px-4">
                                    <h3 class="text-white fw-bold mb-1">
                                        Welcome, ${sessionScope.loggedUser.fullName}
                                    </h3>
                                    <p class="text-white opacity-75 mb-0">
                                        Administrator Dashboard
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Summary Cards -->
                    <div class="row g-3 mb-4">

                        <div class="col-md-3">
                            <div class="card shadow-sm border-0">
                                <div class="card-body text-center">
                                    <h6 class="text-muted">Total Appointments</h6>
                                    <h3 class="fw-bold">
                                        ${summary.rows[0].total_appointments}
                                    </h3>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card shadow-sm border-0">
                                <div class="card-body text-center">
                                    <h6 class="text-muted">Pending Appointments</h6>
                                    <h3 class="fw-bold text-warning">
                                        ${summary.rows[0].pending_appointments}
                                    </h3>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card shadow-sm border-0">
                                <div class="card-body text-center">
                                    <h6 class="text-muted">Unpaid Bills</h6>
                                    <h3 class="fw-bold text-danger">
                                        ${summary.rows[0].unpaid_bills}
                                    </h3>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card shadow-sm border-0">
                                <div class="card-body text-center">
                                    <h6 class="text-muted">Total Revenue</h6>
                                    <h3 class="fw-bold text-success">
                                        RM ${summary.rows[0].total_revenue}
                                    </h3>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Action Cards -->
                    <div class="row g-3">

                        <!-- Invoice -->
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/admin/invoice"
                               class="text-decoration-none">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center py-4">
                                        <h5 class="fw-semibold">Invoice Management</h5>
                                        <p class="text-muted small mb-0">
                                            Generate and manage invoices
                                        </p>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <!-- Report -->
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/admin/report"
                               class="text-decoration-none">
                                <div class="card shadow-sm border-0 h-100">
                                    <div class="card-body text-center py-4">
                                        <h5 class="fw-semibold">Reports</h5>
                                        <p class="text-muted small mb-0">
                                            View appointment & financial reports
                                        </p>
                                    </div>
                                </div>
                            </a>
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
