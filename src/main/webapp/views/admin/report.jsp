<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Reports" />

    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
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
                    <%-- Breadcrumb Start --%> 
                    <div class="col-12">
                        <div class="card py-3 px-5 mb-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item active" aria-current="page">System Revenue & Activity Analysis</li>
                                        </ol>
                                    </nav>
                                </div>
                                <div class="col-auto d-flex gap-2">
                                    <button onclick="downloadAsPDF()" class="btn btn-sm btn-outline-primary">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="me-1">
                                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                                            <polyline points="7 10 12 15 17 10"/>
                                            <line x1="12" y1="15" x2="12" y2="3"/>
                                        </svg>
                                        Download as PDF
                                    </button>
                                    <button onclick="window.location.href='${pageContext.request.contextPath}/'" class="btn btn-sm btn-primary">Home</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Breadcrumb END --%>

                    <%-- Professional Report Container --%>
                    <div class="col-12">
                        <div class="card shadow-sm border-0" id="professional_report">
                            <%-- Report Header --%>
                            <div class="card-body p-0">
                                <%-- Title Section with Logo --%>
                                <div class="bg-primary text-white p-5 rounded-top-3">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <h2 class="fw-bold mb-2 text-white">Taman Medical Centre</h2>
                                            <h5 class="mb-0 opacity-75 text-white">Financial & Operations Analysis Report</h5>
                                        </div>
                                        <div class="col-auto">
                                            <div class="text-end">
                                                <p class="mb-1 small opacity-75">Report Generated</p>
                                                <h6 class="mb-0 text-white"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/></h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%-- Executive Summary Cards --%>
                                <div class="p-5 bg-light">
                                    <h5 class="fw-bold mb-4 text-uppercase text-muted" style="letter-spacing: 1px; font-size: 0.875rem;">Executive Summary</h5>
                                    <div class="row g-4">
                                        <div class="col-md-3">
                                            <div class="card border-0 shadow-sm h-100 d-flex justify-content-center align-items-center">
                                                <div class="card-body text-center p-4 d-flex flex-column justify-content-center align-items-center">
                                                    <div class="mb-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-success">
                                                            <line x1="12" y1="1" x2="12" y2="23"/>
                                                            <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
                                                        </svg>
                                                    </div>
                                                    <p class="text-muted small text-uppercase mb-2" style="letter-spacing: 0.5px;">Total Revenue</p>
                                                    <h3 class="fw-bold text-success mb-0">RM <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/></h3>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card border-0 shadow-sm h-100 d-flex justify-content-center align-items-center">
                                                <div class="card-body text-center p-4 d-flex flex-column justify-content-center align-items-center">
                                                    <div class="mb-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary">
                                                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                                                            <circle cx="9" cy="7" r="4"/>
                                                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                                                            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                                                        </svg>
                                                    </div>
                                                    <p class="text-muted small text-uppercase mb-2" style="letter-spacing: 0.5px;">New Patients (30d)</p>
                                                    <h3 class="fw-bold text-primary mb-0">${newPatientsCount}</h3>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card border-0 shadow-sm h-100 d-flex justify-content-center align-items-center">
                                                <div class="card-body text-center p-4 d-flex flex-column justify-content-center align-items-center">
                                                    <div class="mb-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-info">
                                                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                                                            <polyline points="22 4 12 14.01 9 11.01"/>
                                                        </svg>
                                                    </div>
                                                    <p class="text-muted small text-uppercase mb-2" style="letter-spacing: 0.5px;">Completed Appointments</p>
                                                    <h3 class="fw-bold text-info mb-0">${completedCount}</h3>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card border-0 shadow-sm h-100 d-flex justify-content-center align-items-center">
                                                <div class="card-body text-center p-4 d-flex flex-column justify-content-center align-items-center">
                                                    <div class="mb-3">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-warning">
                                                            <rect x="1" y="4" width="22" height="16" rx="2" ry="2"/>
                                                            <line x1="1" y1="10" x2="23" y2="10"/>
                                                        </svg>
                                                    </div>
                                                    <p class="text-muted small text-uppercase mb-2" style="letter-spacing: 0.5px;">Average Bill Size</p>
                                                    <h3 class="fw-bold text-warning mb-0">RM ${avgBillAmount}</h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%-- Main Analysis Section --%>
                                <div class="p-5">
                                    <div class="row g-4 mb-5">
                                        <%-- Revenue Breakdown --%>
                                        <div class="col-lg-7">
                                            <div class="card border-0 shadow-sm h-100 d-flex justify-content-center align-items-center">
                                                <div class="card-body p-4">
                                                    <div class="d-flex align-items-center mb-4">
                                                        <div class="bg-primary bg-opacity-10 rounded p-2 me-3">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary">
                                                                <line x1="12" y1="20" x2="12" y2="10"/>
                                                                <line x1="18" y1="20" x2="18" y2="4"/>
                                                                <line x1="6" y1="20" x2="6" y2="16"/>
                                                            </svg>
                                                        </div>
                                                        <div>
                                                            <h5 class="fw-bold mb-0">Revenue Breakdown by Category</h5>
                                                            <p class="text-muted small mb-0">Detailed analysis of revenue streams</p>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="table-responsive">
                                                        <table class="table table-borderless align-middle">
                                                            <thead>
                                                                <tr class="border-bottom">
                                                                    <th class="rounded-start-5 bg-primary text-white small text-uppercase pb-3" style="letter-spacing: 0.5px;">Revenue Stream</th>
                                                                    <th class="bg-primary text-white small text-uppercase text-end pb-3" style="letter-spacing: 0.5px;">Amount (MYR)</th>
                                                                    <th class="rounded-end-5 bg-primary text-white small text-uppercase text-end pb-3" style="letter-spacing: 0.5px;">% of Total</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:set var="consultPercent" value="${(totalConsultFees / totalRevenue) * 100}" />
                                                                <c:set var="treatmentPercent" value="${(totalTreatmentFees / totalRevenue) * 100}" />
                                                                
                                                                <tr>
                                                                    <td class="py-3">
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="bg-info bg-opacity-10 rounded-circle p-2 me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                                                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-info">
                                                                                    <path d="M16 20V4a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/>
                                                                                    <rect x="4" y="20" width="16" height="2" rx="1"/>
                                                                                </svg>
                                                                            </div>
                                                                            <span class="fw-semibold">Consultation Fees</span>
                                                                        </div>
                                                                    </td>
                                                                    <td class="text-end py-3">
                                                                        <span class="fw-bold">RM <fmt:formatNumber value="${totalConsultFees}" pattern="#,##0.00"/></span>
                                                                    </td>
                                                                    <td class="text-end py-3">
                                                                        <span class="badge bg-info bg-opacity-10 text-info px-3 py-2">
                                                                            <fmt:formatNumber value="${consultPercent}" pattern="#0.0"/>%
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="py-3">
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="bg-success bg-opacity-10 rounded-circle p-2 me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                                                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-success">
                                                                                    <path d="M22 12h-4l-3 9L9 3l-3 9H2"/>
                                                                                </svg>
                                                                            </div>
                                                                            <span class="fw-semibold">Treatment Fees</span>
                                                                        </div>
                                                                    </td>
                                                                    <td class="text-end py-3">
                                                                        <span class="fw-bold">RM <fmt:formatNumber value="${totalTreatmentFees}" pattern="#,##0.00"/></span>
                                                                    </td>
                                                                    <td class="text-end py-3">
                                                                        <span class="badge bg-success bg-opacity-10 text-success px-3 py-2">
                                                                            <fmt:formatNumber value="${treatmentPercent}" pattern="#0.0"/>%
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                                <tr class="border-top">
                                                                    <td class="pt-3 pb-0">
                                                                        <span class="fw-bold text-primary fs-6">Total System Revenue</span>
                                                                    </td>
                                                                    <td class="text-end pt-3 pb-0">
                                                                        <span class="fw-bold text-primary fs-5">RM <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/></span>
                                                                    </td>
                                                                    <td class="text-end pt-3 pb-0">
                                                                        <span class="badge bg-primary px-3 py-2">100%</span>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <%-- Top Performing Specialties --%>
                                        <div class="col-lg-5">
                                            <div class="card border-0 shadow-sm h-100 d-flex justify-content-center align-items-center">
                                                <div class="card-body p-4">
                                                    <div class="d-flex align-items-center mb-4">
                                                        <div class="bg-success bg-opacity-10 rounded p-2 me-3">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-success">
                                                                <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                                                            </svg>
                                                        </div>
                                                        <div>
                                                            <h5 class="fw-bold mb-0">Top Performing Specialties</h5>
                                                            <p class="text-muted small mb-0">By appointment volume</p>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="specialty-list">
                                                        <c:forEach items="${specialtyStats}" var="stat" varStatus="status">
                                                            <div class="d-flex align-items-center mb-3 pb-3 ${status.last ? '' : 'border-bottom'}">
                                                                <div class="me-3">
                                                                    <div class="bg-primary bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center" 
                                                                        style="width: 45px; height: 45px;">
                                                                        <span class="fw-bold text-primary">#${status.index + 1}</span>
                                                                    </div>
                                                                </div>
                                                                <div class="flex-grow-1">
                                                                    <h6 class="mb-1 fw-semibold">${stat.specialityname}</h6>
                                                                    <small class="text-muted">${stat.department}</small>
                                                                </div>
                                                                <div class="text-end">
                                                                    <div class="fw-bold text-primary">${stat.appointmentCount}</div>
                                                                    <small class="text-muted">Bookings</small>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <%-- Performance Metrics --%>
                                    <div class="card border-0 shadow-sm">
                                        <div class="card-body p-4">
                                            <div class="d-flex align-items-center mb-4">
                                                <div class="bg-warning bg-opacity-10 rounded p-2 me-3">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-warning">
                                                        <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
                                                    </svg>
                                                </div>
                                                <div>
                                                    <h5 class="fw-bold mb-0">Key Performance Indicators</h5>
                                                    <p class="text-muted small mb-0">Operational metrics and trends</p>
                                                </div>
                                            </div>

                                            <div class="row g-4">
                                                <div class="col-md-3">
                                                    <div class="text-center p-3 rounded" style="background-color: #f8f9fa;">
                                                        <p class="text-muted small text-uppercase mb-2" style="letter-spacing: 0.5px;">New Patients</p>
                                                        <h4 class="fw-bold mb-1">${newPatientsCount}</h4>
                                                        <small class="text-success">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                                <polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/>
                                                                <polyline points="17 6 23 6 23 12"/>
                                                            </svg>
                                                            Last 30 days
                                                        </small>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="text-center p-3 rounded" style="background-color: #f8f9fa;">
                                                        <p class="text-muted small text-uppercase mb-2" style="letter-spacing: 0.5px;">Avg. Bill Size</p>
                                                        <h4 class="fw-bold mb-1">RM ${avgBillAmount}</h4>
                                                        <small class="text-muted">Per appointment</small>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="text-center p-3 rounded" style="background-color: #f8f9fa;">
                                                        <p class="text-muted small text-uppercase mb-2" style="letter-spacing: 0.5px;">Completed</p>
                                                        <h4 class="fw-bold mb-1 text-success">${completedCount}</h4>
                                                        <small class="text-success">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                                <polyline points="20 6 9 17 4 12"/>
                                                            </svg>
                                                            Appointments
                                                        </small>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="text-center p-3 rounded" style="background-color: #f8f9fa;">
                                                        <p class="text-muted small text-uppercase mb-2" style="letter-spacing: 0.5px;">Cancellation</p>
                                                        <h4 class="fw-bold mb-1 text-danger">${cancellationRate}%</h4>
                                                        <small class="text-muted">Rate</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%-- Report Footer --%>
                                <div class="bg-light p-4 border-top">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <p class="text-muted small mb-0">
                                                <strong>Taman Medical Centre</strong> | Analytics Dashboard<br>
                                                Generated on <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy 'at' HH:mm"/>
                                            </p>
                                        </div>
                                        <div class="col-auto">
                                            <p class="text-muted small mb-0 text-end">
                                                Page 1 of 1<br>
                                                Confidential Report
                                            </p>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

        <script>
            async function downloadAsPDF() {
                // Show loading state
                const btn = event.target.closest('button');
                const originalText = btn.innerHTML;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Generating...';
                btn.disabled = true;

                try {
                    const { jsPDF } = window.jspdf;
                    const element = document.querySelector('#professional_report');

                    const canvas = await html2canvas(element, {
                        scale: 2,
                        useCORS: true,
                        logging: false,
                        backgroundColor: '#ffffff'
                    });

                    const imgData = canvas.toDataURL('image/png');

                    // Get image dimensions
                    const imgProps = canvas;
                    const imgWidthPx = imgProps.width;
                    const imgHeightPx = imgProps.height;

                    // Set A4 width (210mm) and calculate height based on aspect ratio
                    const pdfWidth = 210;
                    const ratio = pdfWidth / imgWidthPx;
                    const pdfHeight = imgHeightPx * ratio;

                    // Create PDF with custom height to fit content exactly
                    const pdf = new jsPDF({
                        orientation: pdfHeight > pdfWidth ? 'portrait' : 'landscape',
                        unit: 'mm',
                        format: [pdfWidth, pdfHeight]
                    });

                    // Add image to fill entire page
                    pdf.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight);

                    const today = new Date();
                    const dateStr = today.toISOString().split('T')[0];
                    pdf.save('TMC-Analytics-Report-' + dateStr + '.pdf');

                } catch (error) {
                    console.error('Error generating PDF:', error);
                    alert('Failed to generate PDF. Please try again.');
                } finally {
                    // Restore button state
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            }
        </script>
    </body>
</html>