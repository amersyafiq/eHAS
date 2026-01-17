<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light">

<%@ include file="/WEB-INF/jspf/head.jspf" %>
<c:set var="pageTitle" value="System Management Reports" />

<body class="uikit">
    <div id="loading">
        <div class="loader simple-loader">
            <div class="loader-body"></div>
        </div>
    </div>

    <%@ include file="/WEB-INF/jspf/nav.jspf" %>

    <main class="main-content">
        <div class="position-relative iq-banner">
            <%@ include file="/WEB-INF/jspf/header.jspf" %>

            <div class="container-fluid content-inner p-3">
                
                <%-- Title Section --%>
                <div class="row mb-3">
                    <div class="col-12">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body py-4 px-4 d-flex justify-content-between align-items-center">
                                <div>
                                    <h3 class="fw-bold mb-1">System Revenue & Activity Analysis</h3>
                                    <p class="text-muted mb-0">Financial breakdown and departmental performance metrics</p>
                                </div>
                                <a href="${pageContext.request.contextPath}/Admin/exportPDF" class="btn btn-primary">
                                    Export PDF
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Section 1: Financial Breakdown (Using appointment float8 fields) --%>
                <div class="row g-3 mb-4">
                    <div class="col-md-7">
                        <div class="card shadow-sm border-0 h-100">
                            <div class="card-header bg-transparent border-0 pt-4 px-4">
                                <h5 class="fw-bold">Revenue by Category</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table align-middle">
                                        <thead class="text-muted small text-uppercase">
                                            <tr>
                                                <th>Revenue Stream</th>
                                                <th class="text-end">Total Amount (MYR)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Consultation Fees</td>
                                                <td class="text-end fw-bold">RM <fmt:formatNumber value="${totalConsultFees}" pattern="#,##0.00"/></td>
                                            </tr>
                                            <tr>
                                                <td>Treatment Fees</td>
                                                <td class="text-end fw-bold">RM <fmt:formatNumber value="${totalTreatmentFees}" pattern="#,##0.00"/></td>
                                            </tr>
                                            <tr class="table-light">
                                                <td class="fw-bold text-primary">Total System Revenue</td>
                                                <td class="text-end fw-bold text-primary">RM <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- Section 2: Specialty Performance --%>
                    <div class="col-md-5">
                        <div class="card shadow-sm border-0 h-100">
                            <div class="card-header bg-transparent border-0 pt-4 px-4">
                                <h5 class="fw-bold">Top Specialties</h5>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-flush">
                                    <c:forEach items="${specialtyStats}" var="stat">
                                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                            <div>
                                                <h6 class="mb-0">${stat.specialityname}</h6>
                                                <small class="text-muted">${stat.department}</small>
                                            </div>
                                            <span class="badge rounded-pill bg-soft-info text-info">${stat.appointmentCount} Bookings</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Section 3: Monthly Growth Summary --%>
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-transparent border-0 pt-4 px-4">
                                <h5 class="fw-bold">Patient Growth Trends</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="row text-center">
                                    <div class="col-md-3 border-end">
                                        <p class="text-muted mb-1">New Patients (30d)</p>
                                        <h4 class="fw-bold">${newPatientsCount}</h4>
                                    </div>
                                    <div class="col-md-3 border-end">
                                        <p class="text-muted mb-1">Avg. Bill Size</p>
                                        <h4 class="fw-bold">RM ${avgBillAmount}</h4>
                                    </div>
                                    <div class="col-md-3 border-end">
                                        <p class="text-muted mb-1">Completed Appts</p>
                                        <h4 class="fw-bold text-success">${completedCount}</h4>
                                    </div>
                                    <div class="col-md-3">
                                        <p class="text-muted mb-1">Cancellation Rate</p>
                                        <h4 class="fw-bold text-danger">${cancellationRate}%</h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <%@ include file="/WEB-INF/jspf/footer.jspf" %>
    </main>

    <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
</body>
</html>