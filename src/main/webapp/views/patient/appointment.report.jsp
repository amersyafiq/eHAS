<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Medical Report" />

    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body"></div>
            </div>    
        </div>

        <%@ include file="/WEB-INF/jspf/nav.jspf" %>
        
        <%-- Get Appointment & Medical Report Details --%>
        <sql:query var="reportData" dataSource="${myDatasource}">
            SELECT 
                A.APPOINTMENTID, A.STATUS, A.CONCERN, A.DIAGNOSIS, A.TREATMENT, A.NOTES, A.CREATEDAT,
                A.PATIENTID, PA.FULLNAME AS PATIENT_NAME, PA.EMAIL AS PATIENT_EMAIL, PA.PHONENO AS PATIENT_PHONE, 
                PA.GENDER AS PATIENT_GENDER, PA.DATEOFBIRTH AS PATIENT_DOB, PA.PICTUREPATH AS PATIENT_PICTURE,
                P.MEDICALRECORDNO, P.BLOODGROUP, P.ALLERGY,
                DA.FULLNAME AS DOCTOR_NAME, DA.PICTUREPATH AS DOCTOR_PICTURE,
                D.LICENSENO, S.SPECIALITYNAME, S.DEPARTMENT,
                DS.SCHEDULEDATE, T.STARTTIME, T.ENDTIME
            FROM APPOINTMENT A
            LEFT JOIN PATIENT P ON A.PATIENTID = P.ACCOUNTID
            LEFT JOIN ACCOUNT PA ON P.ACCOUNTID = PA.ACCOUNTID
            LEFT JOIN DOCTOR D ON A.DOCTORID = D.ACCOUNTID 
            LEFT JOIN ACCOUNT DA ON D.ACCOUNTID = DA.ACCOUNTID 
            LEFT JOIN SPECIALITY S ON D.SPECIALITYID = S.SPECIALITYID 
            LEFT JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID
            LEFT JOIN DOCTORSCHEDULE DS ON T.SCHEDULEID = DS.SCHEDULEID
            WHERE A.APPOINTMENTID = ?::Integer AND A.STATUS = 'COMPLETED'
            <sql:param value="${param.id}" />
        </sql:query>
        
        <c:if test="${reportData.rowCount == 0}">
            <c:redirect url="/appointment">
                <c:param name="error" value="Medical report not found" />
            </c:redirect>
        </c:if>

        <c:set var="report" value="${reportData.rows[0]}" />

        <%-- Check if user is the patient who owns this appointment --%>
        <c:set var="loggedUser" value="${sessionScope.loggedUser}" />
        <c:if test="${loggedUser == null || loggedUser.accountID != report.patientid}">
            <c:redirect url="/appointment">
                <c:param name="error" value="Unauthorized access to medical report" />
            </c:redirect>
        </c:if>
        
        <main class="main-content">
            <div class="position-relative iq-banner">
                <%@ include file="/WEB-INF/jspf/header.jspf" %>
            
                <div class="container-fluid content-inner p-3">
                    <div class="col-12">
                        <div class="card py-3 px-5 mb-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/appointment">Appointments</a></li>
                                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/appointment/page?id=${param.id}">Appointment Page</a></li>
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

                    <div class="row">
                        <!-- Medical Report Document -->
                        <div class="col-12 col-md-9 pe-md-2" id="medical_report">
                            <div class="card shadow-sm">
                                <div class="card-body p-5">
                                    
                                    <!-- Header Section -->
                                    <div class="text-center border-bottom pb-4 mb-4">
                                        <h3 class="fw-bold mb-1 text-primary">Medical Consultation Report</h3>
                                        <p class="mb-0 text-primary-subtle">Confidential - For Medical Records</p>
                                    </div>

                                    <!-- Report Reference -->
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="row mb-2">
                                                <div class="col-sm-6 fw-bold text-dark">Report ID:</div>
                                                <div class="col-sm-6 text-dark fw-lighter">#MED-${report.appointmentid}</div>
                                            </div>

                                            <div class="row mb-2">
                                                <div class="col-sm-6 fw-bold text-dark">Date of Consultation:</div>
                                                <div class="col-sm-6 text-dark fw-lighter">
                                                    <fmt:formatDate value="${report.SCHEDULEDATE}" pattern="dd MMMM yyyy"/>
                                                </div>
                                            </div>

                                            <div class="row mb-2">
                                                <div class="col-sm-6 fw-bold text-dark">Time of Consultation:</div>
                                                <div class="col-sm-6 text-dark fw-lighter">
                                                    <fmt:formatDate value="${report.STARTTIME}" pattern="hh:mm a" type="time"/> -
                                                    <fmt:formatDate value="${report.ENDTIME}" pattern="hh:mm a" type="time"/>
                                                </div>
                                            </div>

                                            <div class="row mb-2">
                                                <div class="col-sm-6 fw-bold text-dark">Service Duration:</div>
                                                <div class="col-sm-6 text-dark fw-lighter">30 minutes</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row mb-2">
                                                <div class="col-sm-5 fw-bold text-dark">Report Generated:</div>
                                                <div class="col-sm-7 text-dark fw-lighter">
                                                    <fmt:formatDate value="${report.CREATEDAT}" pattern="dd MMMM yyyy"/>
                                                </div>
                                            </div>

                                            <div class="row mb-2 align-items-center">
                                                <div class="col-sm-5 fw-bold text-dark">Status:</div>
                                                <div class="col-sm-7">
                                                    <span class="badge bg-primary px-3 py-2">COMPLETED</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <hr class="my-4">

                                    <!-- Patient Information Section -->
                                    <div class="mb-5">
                                        <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">PATIENT INFORMATION</h5>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <img src="${report.patient_picture}" alt="Patient" class="img-fluid rounded border" onerror="this.src='https://placehold.co/150x150?text=No+Image';" style="max-width: 150px;">
                                            </div>
                                            <div class="col-md-9">
                                                <div class="row g-3">
                                                    <div class="col-md-6">
                                                        <p class="text-muted mb-1"><small>Full Name</small></p>
                                                        <p class="fw-normal text-dark">${report.patient_name}</p>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <p class="text-muted mb-1"><small>Medical Record No.</small></p>
                                                        <p class="fw-normal text-dark">${report.medicalrecordno}</p>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <p class="text-muted mb-1"><small>Date of Birth</small></p>
                                                        <p class="fw-normal text-dark"><fmt:formatDate value="${report.patient_dob}" pattern="dd MMMM yyyy"/></p>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <p class="text-muted mb-1"><small>Gender</small></p>
                                                        <p class="fw-normal text-dark">${report.patient_gender}</p>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <p class="text-muted mb-1"><small>Blood Group</small></p>
                                                        <p class="fw-normal text-dark">${report.bloodgroup != null ? report.bloodgroup : 'Not Recorded'}</p>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <p class="text-muted mb-1"><small>Known Allergies</small></p>
                                                        <p class="fw-normal text-dark">${report.allergy != null && !report.allergy.isEmpty() ? report.allergy : 'None Recorded'}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <hr class="my-4">

                                    <!-- Physician Information Section -->
                                    <div class="mb-5">
                                        <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">PHYSICIAN INFORMATION</h5>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <img src="${report.doctor_picture}" alt="Doctor" class="img-fluid rounded border" onerror="this.src='https://placehold.co/150x150?text=No+Image';" style="max-width: 150px;">
                                            </div>
                                            <div class="col-md-9">
                                                <div class="row g-3">
                                                    <div class="col-md-12">
                                                        <p class="text-muted mb-1"><small>Doctor Name</small></p>
                                                        <p class="fw-normal text-dark">${report.doctor_name}</p>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <p class="text-muted mb-1"><small>License Number</small></p>
                                                        <p class="fw-normal text-dark">${report.licenseno}</p>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <p class="text-muted mb-1"><small>Specialization</small></p>
                                                        <p class="fw-normal text-dark">${report.specialityname}</p>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <p class="text-muted mb-1"><small>Department</small></p>
                                                        <p class="fw-normal text-dark">${report.department}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <hr class="my-4">

                                    <!-- Clinical Findings Section -->
                                    <div class="mb-5">
                                        <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">CLINICAL FINDINGS</h5>
                                        
                                        <div class="mb-4">
                                            <h6 class="fw-semibold text-secondary">Chief Complaint / Reason for Visit</h6>
                                            <div class="mt-2 p-3 alert alert-light border border-1 rounded">
                                                <p class="m-0" style="white-space: pre-wrap;">${report.concern != null ? report.concern : 'Not documented'}</p>
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <h6 class="fw-semibold text-secondary">Diagnosis</h6>
                                            <div class="mt-2 p-3 alert alert-light border border-1 rounded">
                                                <p class="m-0" style="white-space: pre-wrap;">${report.diagnosis != null ? report.diagnosis : 'Not documented'}</p>
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <h6 class="fw-semibold text-secondary">Treatment & Recommendations</h6>
                                            <div class="mt-2 p-3 alert alert-light border border-1 rounded">
                                                <p class="m-0" style="white-space: pre-wrap;">${report.treatment != null ? report.treatment : 'Not documented'}</p>
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <h6 class="fw-semibold text-secondary">Additional Notes</h6>
                                            <div class="mt-2 p-3 alert alert-light border border-1 rounded">
                                                <p class="m-0" style="white-space: pre-wrap;">${report.notes != null && !report.notes.isEmpty() ? report.notes : 'None'}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <hr class="my-4">

                                    <!-- Follow-up Section -->
                                    <div class="mb-5">
                                        <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">FOLLOW-UP APPOINTMENT</h5>
                                        <c:if test="${report.followupappointmentid != null}">
                                            <p><strong>Follow-up appointment has been scheduled.</strong></p>
                                            <p class="text-muted">Please visit your appointments page or contact the clinic for details.</p>
                                        </c:if>
                                        <c:if test="${report.followupappointmentid == null}">
                                            <p class="text-muted">No follow-up appointment scheduled at this time.</p>
                                        </c:if>
                                    </div>

                                    <hr class="my-4">

                                    <!-- Medical Confidentiality & Consent Section -->
                                    <div class="mb-5">
                                        <h5 class="fw-bold mb-3 border-bottom pb-2 text-primary">CONFIDENTIALITY & CONSENT</h5>
                                        <div class="alert alert-primary" role="alert">
                                            <p class="small mb-0">
                                                <strong>Confidentiality Notice:</strong> This medical report contains confidential information protected by medical privacy laws and regulations. 
                                                This document is intended for the patient's personal medical records and should not be shared without explicit consent. 
                                                Unauthorized access, use, or disclosure of this information is prohibited.
                                            </p>
                                        </div>
                                        <div class="alert alert-light border" role="alert">
                                            <p class="small mb-2">
                                                <strong>Patient Consent:</strong> By accessing this medical report, you acknowledge that:
                                            </p>
                                            <ul class="small mb-0">
                                                <li>You have received the consultation services as documented herein</li>
                                                <li>You understand the diagnosis and treatment recommendations</li>
                                                <li>You have been given the opportunity to ask questions</li>
                                                <li>You consent to the retention of this record for medical and legal purposes</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Footer Section -->
                                    <div class="border-top pt-4 mt-5 text-center">
                                        <p class="text-muted small mb-1">This report is confidential and intended only for the patient.</p>
                                        <p class="text-muted small">Generated: <fmt:formatDate value="${report.SCHEDULEDATE}" pattern="dd MMMM yyyy 'at' hh:mm a"/></p>
                                        <p class="text-muted small mb-0">Report ID: #MED-${report.appointmentid}</p>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-3 ps-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title mb-3" style="font-size: 1.1rem;">Actions</h5>
                                    <div class="row px-4 g-2">
                                    
                                    <button class="btn col-12 rounded-3 btn-primary" onclick="downloadAsPDF()"> Download as PDF </button>

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
                const { jsPDF } = window.jspdf;
                const element = document.querySelector('#medical_report');  // ← your main report card

                const canvas = await html2canvas(element, {
                    scale: 2,               // higher = sharper text (but bigger file)
                    useCORS: true,
                    logging: false,
                    backgroundColor: '#ffffff'   // avoid transparent → white edges
                });

                const imgData = canvas.toDataURL('image/png');

                const pdf = new jsPDF({
                    orientation: 'portrait',
                    unit: 'mm',
                    format: 'a4'
                });

                // ── Key part: get real PDF page width ──
                const pdfWidth = pdf.internal.pageSize.getWidth();     // ≈ 210 mm for A4
                const pdfHeight = pdf.internal.pageSize.getHeight();   // ≈ 297 mm

                // Get original image dimensions (in pixels)
                const imgProps = pdf.getImageProperties(imgData);
                const imgWidthPx  = imgProps.width;
                const imgHeightPx = imgProps.height;

                // Scale so width fills the full page (no right margin/empty space)
                const ratio = pdfWidth / imgWidthPx;
                const finalImgWidth  = pdfWidth;
                const finalImgHeight = imgHeightPx * ratio;

                // If content is very long → add pages automatically
                let heightLeft = finalImgHeight;
                let position = 0;

                pdf.addImage(imgData, 'PNG', 0, position, finalImgWidth, finalImgHeight);

                heightLeft -= pdfHeight;

                while (heightLeft > 0) {
                    position = heightLeft - finalImgHeight;  // negative = continue from previous cut
                    pdf.addPage();
                    pdf.addImage(imgData, 'PNG', 0, position, finalImgWidth, finalImgHeight);
                    heightLeft -= pdfHeight;
                }

                pdf.save(`Medical-Report-\${${report.appointmentid}}.pdf`);
            }
        </script>
        
    </body>
</html>