<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light">

<%@ include file="/WEB-INF/jspf/head.jspf" %>
<c:set var="pageTitle" value="Invoice" />

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
                                <h3 class="fw-bold mb-1">Billing & Invoices</h3>
                                <p class="text-muted mb-0">Manage patient payments and transaction history</p>
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
                                                <th>Invoice ID</th>
                                                <th>Patient Name</th>
                                                <th>Date</th>
                                                <th>Amount</th>
                                                <th>Payment Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${invoices}" var="inv" varStatus="i">
                                                <tr>
                                                    <td>#INV-${inv.appointmentid}</td>
                                                    <td><strong>${inv.patient_name}</strong></td>
                                                    <td>
                                                        <fmt:formatDate value="${inv.billing_date}" pattern="dd/MM/yyyy"/>
                                                    </td>
                                                    <td class="fw-bold text-dark">
                                                        RM <fmt:formatNumber value="${inv.totalamount}" minFractionDigits="2"/>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${inv.billstatus == 'PAID'}">
                                                                <span class="badge bg-success">PAID</span>
                                                            </c:when>
                                                            <c:when test="${inv.billstatus == 'UNPAID'}">
                                                                <span class="badge bg-danger">UNPAID</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-warning text-dark">${inv.billstatus}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <a href="${pageContext.request.contextPath}/Admin/invoice/view?id=${inv.appointmentid}" 
                                                               class="btn btn-sm btn-soft-primary">View Detail</a>
                                                            <button class="btn btn-sm btn-soft-info" onclick="window.print()">Print</button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty invoices}">
                                                <tr>
                                                    <td colspan="6" class="text-center py-4 text-muted">No invoices found.</td>
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