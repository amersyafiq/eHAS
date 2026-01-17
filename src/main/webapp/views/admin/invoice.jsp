<%-- 
    Document   : invoice
    Created on : Jan 15, 2025, 9:47:06 AM
    Author     : Luqman
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Invoice" />   
    
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
                                            <li class="breadcrumb-item active" aria-current="page">Invoice</li>
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
                            <div class="row mb-3">
                                <div class="col-sm-12 col-md-6">
                                    <div class="dataTables_length">
                                        <label>Show 
                                            <select id="page-length" class="form-select form-select-sm" style="width: auto; display: inline-block;">
                                                <option value="10">10</option>
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                            </select>
                                            entries
                                        </label>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-6">
                                    <div class="d-flex flex-row justify-content-end align-items-center gap-2">
                                        <label for="global-search" class="m-0">Search:</label>
                                        <input type="text" id="global-search" class="form-control form-control-sm" placeholder="" style="max-width: 250px;">
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table id="appointmentTable" class="table" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th class="bg-primary text-white fw-normal rounded-start-5"><small>PATIENT NAME</small></th>
                                            <th class="bg-primary text-white fw-normal"><small>STATUS</small></th> 
                                            <th class="bg-primary text-white fw-normal"><small>DATE COMPLETED</small></th>
                                            <th class="bg-primary text-white fw-normal"><small>BILL STATUS</small></th> 
                                            <th class="bg-primary text-white fw-normal"><small>TOTAL AMOUNT</small></th> 
                                            <th class="bg-primary text-white fw-normal rounded-end-5 text-center"><small>ACTION</small></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <sql:query var="results" dataSource="${myDatasource}"> 
                                            SELECT 
                                                A.APPOINTMENTID, 
                                                UPPER(A.STATUS) AS STATUS, 
                                                A.BILLSTATUS,
                                                COALESCE(A.TOTALAMOUNT, 0) AS TOTALAMOUNT,
                                                COALESCE(A.CONSULTATIONFEE, 0) AS CONSULTATIONFEE,
                                                COALESCE(A.TREATMENTFEE, 0) AS TREATMENTFEE,
                                                PA.FULLNAME AS PATIENT_NAME,
                                                PA.PICTUREPATH AS PATIENT_PICTURE,
                                                DA.FULLNAME AS DOCTOR_NAME,
                                                TO_CHAR(T.STARTTIME, 'HH:MI AM') AS STARTTIME,
                                                TO_CHAR(T.ENDTIME, 'HH:MI AM') AS ENDTIME, 
                                                A.CONCERN,
                                                A.TREATMENT,
                                                A.DIAGNOSIS,
                                                A.NOTES,
                                                DS.SCHEDULEDATE
                                            FROM APPOINTMENT A
                                            INNER JOIN ACCOUNT PA ON A.PATIENTID = PA.ACCOUNTID
                                            INNER JOIN ACCOUNT DA ON A.DOCTORID = DA.ACCOUNTID
                                            INNER JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID
                                            INNER JOIN DOCTORSCHEDULE DS ON T.SCHEDULEID = DS.SCHEDULEID 
                                            WHERE A.STATUS = 'COMPLETED' 
                                            ORDER BY A.BILLSTATUS DESC, DS.SCHEDULEDATE DESC
                                        </sql:query>
                                        <c:forEach var="invoice" items="${results.rows}">
                                            <tr>
                                                <td class="py-2"><img src="${invoice.patient_picture}" onerror="this.onerror=null; this.src='https://placehold.co/500x500?text=No+Image';" alt="Patient Profile" class="theme-color-default-img img-fluid avatar avatar-rounded border border-1 border-primary" style="width: 35px; height: 35px;">&emsp;${invoice.patient_name}</td>
                                                <td class="py-2">
                                                    <span 
                                                        class="
                                                            badge 
                                                            px-3 py-2 fw-normal
                                                            <c:choose>
                                                                <c:when test="${invoice.STATUS == 'PENDING'}">
                                                                    bg-primary bg-opacity-25 text-primary
                                                                </c:when>
                                                                <c:when test="${invoice.STATUS == 'CONFIRMED'}">
                                                                    bg-primary text-white
                                                                </c:when>
                                                                <c:when test="${invoice.STATUS == 'COMPLETED'}">
                                                                    bg-secondary text-white
                                                                </c:when>
                                                                <c:when test="${invoice.STATUS == 'CANCELLED'}">
                                                                    bg-danger text-white
                                                                </c:when>
                                                                <c:otherwise>
                                                                    bg-dark text-white
                                                                </c:otherwise>
                                                            </c:choose>
                                                        "
                                                    >
                                                        ${invoice.STATUS}
                                                    </span>
                                                </td>
                                                <td class="py-2"><fmt:formatDate value="${invoice.SCHEDULEDATE}" pattern="MMMM d, yyyy"/></td>
                                                <td class="py-2">
                                                    <span 
                                                        class="
                                                            badge 
                                                            px-3 py-2 fw-normal
                                                            <c:choose>
                                                                <c:when test="${invoice.billstatus == 'PAID'}">
                                                                    bg-primary text-white
                                                                </c:when>
                                                                <c:when test="${invoice.billstatus == 'UNPAID'}">
                                                                    bg-danger
                                                                </c:when>
                                                                <c:otherwise>
                                                                    bg-dark text-white
                                                                </c:otherwise>
                                                            </c:choose>
                                                        "
                                                    >
                                                        ${invoice.billstatus}
                                                    </span>
                                                </td>
                                                <td class="py-2">
                                                    <c:choose>
                                                        <c:when test="${invoice.totalamount == 0 || empty invoice.totalamount}">
                                                            <span class="badge bg-light text-secondary border px-3 py-2 fw-normal">
                                                                Not Set
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="fw-bold text-primary">
                                                                <fmt:formatNumber value="${invoice.totalamount}" type="currency" currencyCode="MYR"/>
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="py-2">
                                                    <button class="btn btn-sm btn-outline-primary rounded-pill"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#setFeeModal"
                                                            data-appointmentid="${invoice.APPOINTMENTID}"
                                                            data-patientname="${invoice.patient_name}"
                                                            data-doctorname="${invoice.doctor_name}"
                                                            data-concern="${invoice.concern}"
                                                            data-treatment="${invoice.treatment}"
                                                            data-diagnosis="${invoice.diagnosis}"
                                                            data-notes="${invoice.notes}"
                                                            data-status="${invoice.STATUS}"
                                                            data-consultationfee="${invoice.CONSULTATIONFEE}"
                                                            data-treatmentfee="${invoice.TREATMENTFEE}">
                                                        <c:choose>
                                                            <c:when test="${invoice.totalamount == 0 || empty invoice.totalamount}">
                                                                Set Fees    
                                                            </c:when>
                                                            <c:otherwise>
                                                                View Fee
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </button>
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

        <%-- Error Toast Start --%>
        <c:if test="${not empty error or not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show rounded-4" role="alert" 
                style="position: fixed; bottom: 20px; right: 20px; z-index: 9999; max-width: 400px;">
                <strong>Error!</strong> 
                ${not empty error ? error : param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <%-- Error Toast END --%>

        <%-- Set Fees Modal --%>
        <div class="modal fade" id="setFeeModal" tabindex="-1" role="dialog" aria-labelledby="setFeeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="setFeeModalLabel">Consultation & Fees</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form method="POST" action="${pageContext.request.contextPath}/invoice" id="feeForm">
                        <div class="modal-body">
                            <input type="hidden" id="appointmentID" name="appointmentID">
                            <input type="hidden" id="hiddenTotalAmount" name="totalAmount">
                            
                            <div class="row">
                                <!-- Left Side: Consultation Data (Scrollable) -->
                                <div class="col-md-6 border-end pe-md-4">
                                    <h6 class="mb-3 position-sticky top-0 bg-white pb-2 text-primary">Consultation Details</h6>
                                    
                                    <div class="mb-3">
                                        <label class="form-label text-dark"><small>Concern</small></label>
                                        <p class="m-0 fw-normal" id="displayConcern" style="white-space: pre-wrap;"></p>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label text-dark"><small>Diagnosis</small></label>
                                        <p class="m-0 fw-normal" id="displayDiagnosis" style="white-space: pre-wrap;"></p>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label text-dark"><small>Treatment</small></label>
                                        <p class="m-0 fw-normal" id="displayTreatment" style="white-space: pre-wrap;"></p>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label text-dark"><small>Notes</small></label>
                                        <p class="m-0 fw-normal" id="displayNotes" style="white-space: pre-wrap;"></p>
                                    </div>
                                </div>

                                <!-- Right Side: Fee Setting -->
                                <div class="col-md-6 ps-md-4">
                                    <h6 class="mb-3 text-primary" id="feeTitle">Set Fees</h6>
                                    
                                    <div class="mb-3">
                                        <label for="consultationFee" class="form-label">Consultation Fee (RM) <span class="text-danger" id="consultationRequired">*</span></label>
                                        <input type="number" 
                                               class="form-control" 
                                               id="consultationFee" 
                                               name="consultationFee" 
                                               step="0.01" 
                                               min="0" 
                                               placeholder="0.00"
                                               required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="treatmentFee" class="form-label">Treatment Fee (RM) <span class="text-danger" id="treatmentRequired">*</span></label>
                                        <input type="number" 
                                               class="form-control" 
                                               id="treatmentFee" 
                                               name="treatmentFee" 
                                               step="0.01" 
                                               min="0" 
                                               placeholder="0.00"
                                               required>
                                    </div>

                                    <div class="p-3 bg-primary-subtle border border-1 border-primary rounded">
                                        <p class="text-dark mb-2"><small>Total Amount:</small></p>
                                        <p class="m-0 fs-5">RM <span id="totalAmount">0.00</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" id="saveFeeBtn">Save Fees</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        <script>
            $(document).ready(function () {
                const table = $('#appointmentTable').DataTable({
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
                        { orderable: false, targets: 5 }, 
                        { searchable: false, targets: 5 }
                    ],
                    language: {
                        search: "",
                        searchPlaceholder: "Search Appointment",
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

                $('#global-search').on('keyup', function () {
                    table.search(this.value).draw();
                });

                $('#page-length').on('change', function () {
                    table.page.len($(this).val()).draw();
                });

                $('#setFeeModal').on('show.bs.modal', function(e) {
                    const button = e.relatedTarget;
                    const appointmentID = $(button).data('appointmentid');
                    const concern = $(button).data('concern');
                    const diagnosis = $(button).data('diagnosis');
                    const treatment = $(button).data('treatment');
                    const notes = $(button).data('notes');
                    const consultationFee = $(button).data('consultationfee');
                    const treatmentFee = $(button).data('treatmentfee');
                    
                    $('#appointmentID').val(appointmentID);
                    
                    $('#displayConcern').text(concern || 'N/A');
                    $('#displayDiagnosis').text(diagnosis || 'N/A');
                    $('#displayTreatment').text(treatment || 'N/A');
                    $('#displayNotes').text(notes || 'N/A');
                    
                    const hasConsultationFee = consultationFee && parseFloat(consultationFee) > 0;
                    const hasTreatmentFee = treatmentFee && parseFloat(treatmentFee) > 0;
                    const feesAreSet = hasConsultationFee || hasTreatmentFee;
                    
                    if (feesAreSet) {
                        $('#feeTitle').text('View Fees');
                        $('#consultationFee').val(consultationFee || '0.00').prop('readonly', true).prop('required', false);
                        $('#treatmentFee').val(treatmentFee || '0.00').prop('readonly', true).prop('required', false);
                        
                        $('#consultationFee, #treatmentFee').css('background-color', '#f5f5f5').css('cursor', 'default');
                        
                        $('#consultationRequired, #treatmentRequired').hide();
                        
                        $('#saveFeeBtn').hide();
                    } else {
                        $('#feeTitle').text('Set Fees');
                        $('#consultationFee').val('').prop('readonly', false).prop('required', true).css('background-color', '').css('cursor', 'auto');
                        $('#treatmentFee').val('').prop('readonly', false).prop('required', true).css('background-color', '').css('cursor', 'auto');
                        
                        $('#consultationRequired, #treatmentRequired').show();
                        
                        $('#saveFeeBtn').show();
                    }
                    
                    const total = (parseFloat(consultationFee) || 0) + (parseFloat(treatmentFee) || 0);
                    $('#totalAmount').text(total.toFixed(2));
                });

                $('#consultationFee, #treatmentFee').on('input', function() {
                    const consultationFee = parseFloat($('#consultationFee').val()) || 0;
                    const treatmentFee = parseFloat($('#treatmentFee').val()) || 0;
                    const total = consultationFee + treatmentFee;
                    const formattedTotal = total.toFixed(2);

                    $('#totalAmount').text(formattedTotal);   
                    $('#hiddenTotalAmount').val(formattedTotal);
                });
            });
        </script>
        
    </body>
</html>