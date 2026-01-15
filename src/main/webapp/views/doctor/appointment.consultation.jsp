<%-- 
    Document   : consultation
    Created on : Consultation Feature Implementation
    Author     : eHAS Team
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Consultation" />

    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body"></div>
            </div>    
        </div>

        <%@ include file="/WEB-INF/jspf/nav.jspf" %>

        <%-- Get Appointment Details --%>
        <sql:query var="appointment" dataSource="${myDatasource}">
            SELECT 
                A.APPOINTMENTID, A.STATUS, A.CONCERN, A.PATIENTID, A.DOCTORID, A.TIMESLOTID, A.DIAGNOSIS, A.TREATMENT, A.NOTES, A.CONSULTATIONFEE, A.TREATMENTFEE, A.TOTALAMOUNT, A.CREATEDAT,
                P.MEDICALRECORDNO, P.BLOODGROUP, P.ALLERGY,
                PA.FULLNAME AS PATIENT_NAME, PA.EMAIL AS PATIENT_EMAIL, PA.PHONENO AS PATIENT_PHONE, PA.GENDER AS PATIENT_GENDER, PA.DATEOFBIRTH AS PATIENT_DOB, PA.PICTUREPATH AS PATIENT_PICTURE,
                DA.FULLNAME AS DOCTOR_NAME, DA.PICTUREPATH AS DOCTOR_PICTURE,
                D.LICENSENO, S.SPECIALITYNAME,
                DS.SCHEDULEDATE, T.STARTTIME, T.ENDTIME
            FROM APPOINTMENT A
            LEFT JOIN PATIENT P ON A.PATIENTID = P.ACCOUNTID
            LEFT JOIN ACCOUNT PA ON P.ACCOUNTID = PA.ACCOUNTID
            LEFT JOIN DOCTOR D ON A.DOCTORID = D.ACCOUNTID
            LEFT JOIN ACCOUNT DA ON D.ACCOUNTID = DA.ACCOUNTID
            LEFT JOIN SPECIALITY S ON D.SPECIALITYID = S.SPECIALITYID
            LEFT JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID
            LEFT JOIN DOCTORSCHEDULE DS ON T.SCHEDULEID = DS.SCHEDULEID
            WHERE A.APPOINTMENTID = ?::Integer
            <sql:param value="${param.id}" />
        </sql:query>
        
        <c:if test="${appointment.rowCount == 0}">
            <c:redirect url="${pageContext.request.contextPath}/appointment">
                <c:param name="error" value="Appointment not found" />
            </c:redirect>
        </c:if>
        
        <c:set var="appt" value="${appointment.rows[0]}" />
        
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
                        <!-- Main Content -->
                        <div class="col-md-8 pe-md-2">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title mb-4">Consultation Form</h5>
                                    
                                    <form method="post" action="${pageContext.request.contextPath}/appointment/consultation" onsubmit="return validateForm()">
                                        
                                        <!-- Chief Complaint -->
                                        <div class="mb-4">
                                            <label class="form-label">Chief Complaint</label>
                                            <textarea class="form-control" rows="3" readonly>${appt.concern}</textarea>
                                        </div>

                                        <!-- Diagnosis -->
                                        <div class="mb-4">
                                            <label class="form-label">Diagnosis</label>
                                            <textarea class="form-control" id="diagnosis" name="diagnosis" value="${consultation.diagnosis}" rows="4" placeholder="Enter diagnosis..." required>${appt.diagnosis}</textarea>
                                        </div>

                                        <!-- Treatment & Prescription -->
                                        <div class="mb-4">
                                            <label class="form-label">Treatment & Prescription</label>
                                            <textarea class="form-control" id="treatment" name="treatment" value="${consultation.treatment}" rows="4" placeholder="Enter treatment plan and prescriptions..." required>${appt.treatment}</textarea>
                                        </div>

                                        <!-- Additional Notes -->
                                        <div class="mb-4">
                                            <label class="form-label">Additional Notes</label>
                                            <textarea class="form-control" id="notes" name="notes" value="${consultation.notes}" rows="3" placeholder="Enter any additional notes...">${appt.notes}</textarea>
                                        </div>

                                        <hr>

                                        <!-- Follow-up Appointment -->
                                        <div class="form-check form-switch mb-3">
                                            <label class="form-check-label" for="enableFollowUp">Schedule Follow-up Appointment?</label>
                                            <input class="form-check-input" type="checkbox" id="enableFollowUp" name="enableFollowUp" value="true">
                                        </div>

                                        <div id="followUpContainer" style="display: none;">
                                            <div class="row mb-4">
                                                <input type="hidden" id="followup_appointmentID" name="appointmentID" value="${appt.appointmentid}">
                                                <input type="hidden" id="followup_doctorID" name="doctorID" value="${appt.doctorid}">
                                                <input type="hidden" name="patientID" value="${appt.patientid}">
                                                <input type="hidden" id="followup_scheduleID">
                                                
                                                <div class="col-12 mb-3">
                                                    <label for="concern" class="form-label">Concern</label>
                                                    <textarea class="form-control" id="followup_concern" name="concern" rows="3" placeholder="Enter follow up concern..."></textarea>
                                                </div>

                                                <div class="col-12 col-md-6 mb-3">
                                                    <label for="followup_date" class="form-label">New Date</label>
                                                    <input type="text" class="form-control" id="followup_date" placeholder="Select new date" readonly>
                                                </div>
                                                
                                                <div class="col-12 col-md-6 mb-3">
                                                    <label for="followup_timeslot" class="form-label">New Time Slot</label>
                                                    <select class="form-select" id="followup_timeslot" name="timeslotID" disabled>
                                                        <option value="">-- Select Time Slot --</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Submit Button -->
                                        <div class="mt-4">
                                            <button type="submit" class="btn btn-primary btn-lg w-100">Complete Consultation</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Right Sidebar -->
                        <div class="col-md-4 ps-md-2">
                            <!-- Timer Card -->
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title mb-3">Consultation Time</h5>
                                    <div class="text-center">
                                        <div id="timer" style="font-size: 3rem; font-weight: bold; color: #3a57e8; font-family: 'Courier New';">
                                            30:00
                                        </div>
                                        <p class="text-muted mt-2 mb-0">Time Remaining</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Patient Information Card -->
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title mb-3">Patient Information</h5>
                                    <div class="row g-2 mb-2">
                                        <div class="col-12 d-flex gap-3">
                                            <img src="${appt.patient_picture}" alt="Patient Profile" onerror="this.onerror=null; this.src='https://placehold.co/500x500?text=No+Image';" class="theme-color-default-img img-fluid avatar avatar-50 avatar-rounded border border-3 border-light">
                                            <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                <p class="text-muted mb-1"><small>Full Name</small></p>
                                                <p class="m-0 text-dark fw-normal lh-1">${appt.patient_name}</p>
                                            </div>
                                        </div>
                                        <div class="col-12 d-flex gap-3">
                                            <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                <svg width="25" height="25" viewBox="0 0 502 502" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M251 20.9167C205.494 20.9167 161.01 34.4108 123.173 59.6927C85.336 84.9746 55.8456 120.909 38.4311 162.951C21.0167 204.993 16.4603 251.255 25.3381 295.887C34.2159 340.519 56.1292 381.516 88.3069 413.693C120.485 445.871 161.482 467.785 206.113 476.662C250.745 485.54 297.007 480.984 339.05 463.569C381.092 446.155 417.026 416.664 442.308 378.827C467.59 340.99 481.084 296.506 481.084 251C481.012 190 456.748 131.519 413.614 88.386C370.481 45.2526 312 20.9886 251 20.9167ZM251 439.25C213.768 439.25 177.372 428.209 146.414 407.524C115.457 386.839 91.3283 357.438 77.0801 323.04C62.8319 288.642 59.1039 250.791 66.3676 214.274C73.6313 177.757 91.5603 144.214 117.888 117.887C144.215 91.5599 177.758 73.6308 214.275 66.3672C250.792 59.1035 288.642 62.8315 323.041 77.0797C357.439 91.3279 386.839 115.456 407.525 146.414C428.21 177.371 439.25 213.768 439.25 251C439.19 300.908 419.337 348.755 384.046 384.046C348.756 419.336 300.909 439.189 251 439.25ZM285.868 216.132H355.584V285.868H285.868V355.583H216.132V285.868H146.417V216.132H216.132V146.417H285.868V216.132Z" fill="#3a57e8"/>
                                                </svg>
                                            </div>
                                            <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                <p class="text-muted mb-1"><small>Medical Record No.</small></p>
                                                <p class="m-0 text-dark fw-normal lh-1">${appt.medicalrecordno}</p>
                                            </div>
                                        </div>
                                        <div class="col-12 d-flex gap-3">
                                            <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                <svg width="23" height="23" viewBox="0 0 667 667" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M33.333 116.691C33.333 402.037 264.653 633.357 550 633.357C562.873 633.357 575.636 632.887 588.276 631.96C602.78 630.897 610.03 630.367 616.633 626.567C622.1 623.421 627.283 617.841 630.023 612.157C633.333 605.297 633.333 597.294 633.333 581.29V487.381C633.333 473.921 633.333 467.191 631.116 461.424C629.163 456.327 625.983 451.79 621.863 448.21C617.2 444.157 610.873 441.857 598.226 437.257L491.333 398.387C476.616 393.037 469.256 390.36 462.276 390.814C456.12 391.214 450.196 393.317 445.163 396.884C439.456 400.927 435.43 407.641 427.373 421.071L400 466.691C311.67 426.687 240.063 354.987 200 266.691L245.621 239.318C259.048 231.262 265.762 227.233 269.806 221.526C273.373 216.493 275.476 210.569 275.876 204.414C276.33 197.433 273.653 190.075 268.303 175.359L229.433 68.4642C224.833 55.8159 222.533 49.4915 218.48 44.8272C214.9 40.7069 210.363 37.5289 205.267 35.5722C199.498 33.3572 192.769 33.3572 179.31 33.3572H85.4C69.3957 33.3572 61.3933 33.3572 54.5323 36.6655C48.8497 39.4059 43.271 44.5909 40.123 50.0582C36.3223 56.6595 35.7913 63.9112 34.7293 78.4149C33.804 91.0525 33.333 103.817 33.333 116.691Z" stroke="#3a57e8" stroke-width="66.6667" stroke-linecap="round" stroke-linejoin="round"/>
                                                </svg>
                                            </div>
                                            <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                <p class="text-muted mb-1"><small>Contact Number</small></p>
                                                <p class="m-0 text-dark fw-normal lh-1">${appt.patient_phone}</p>
                                            </div>
                                        </div>
                                        <div class="col-12 d-flex gap-3">
                                            <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                <svg width="25" height="25" viewBox="0 0 203 174" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M198.945 47.2872L104.781 0.764904C103.76 0.261717 102.638 0 101.5 0C100.362 0 99.2398 0.261717 98.2194 0.764904L4.07812 47.2872C2.86076 47.8795 1.83354 48.8008 1.11279 49.9468C0.392047 51.0928 0.00656474 52.4177 0 53.7715V166.749C0.00533913 167.707 0.199363 168.654 0.570985 169.537C0.942607 170.42 1.48454 171.221 2.16583 171.894C2.84711 172.567 3.65438 173.1 4.54152 173.461C5.42866 173.822 6.37827 174.005 7.33609 173.999H195.664C196.622 174.005 197.571 173.822 198.458 173.461C199.346 173.1 200.153 172.567 200.834 171.894C201.515 171.221 202.057 170.42 202.429 169.537C202.801 168.654 202.995 167.707 203 166.749V53.7715C202.996 52.4201 202.613 51.0969 201.897 49.9511C201.18 48.8054 200.158 47.8827 198.945 47.2872ZM101.5 15.3555L179.891 54.0705L100.277 93.3927L21.8859 54.6777L101.5 15.3555Z" fill="#3a57e8"/>
                                                </svg>
                                            </div>
                                            <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                <p class="text-muted mb-1"><small>Email Address</small></p>
                                                <p class="m-0 text-dark fw-normal lh-1">${appt.patient_email}</p>
                                            </div>
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
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

        <script>
        $(document).ready(function() {
            // Initialize 30-minute timer
            let timeRemaining = 30 * 60; // 30 minutes in seconds
            const timerInterval = setInterval(function() {
                if (timeRemaining <= 0) {
                    clearInterval(timerInterval);
                    $('#timer').html('00:00').css('color', '#dc3545');
                    alert('Consultation time has ended!');
                    return;
                }
                
                timeRemaining--;
                const minutes = Math.floor(timeRemaining / 60);
                const seconds = timeRemaining % 60;
                const timeString = String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');
                $('#timer').html(timeString);
                
                // Change color when time is running low
                if (timeRemaining <= 5 * 60) { // 5 minutes or less
                    $('#timer').css('color', '#dc3545');
                }
            }, 1000);

            var $followUpDateInput = $('#followup_date');
            var $followUpScheduleIDInput = $('#followup_scheduleID');
            var $followUpTimeslotSelect = $('#followup_timeslot');
            var $followUpDoctorIDInput = $('#followup_doctorID');
            var $followUpAppointmentIDInput = $('#followup_appointmentID');
            var doctorID = $followUpDoctorIDInput.val();

            var availableDates = [];
            var dateScheduleMap = {};
            var flatpickrInstance = null;

            // Initialize Flatpickr (disabled initially)
            flatpickrInstance = flatpickr("#followup_date", {
                dateFormat: "Y-m-d",
                minDate: "today",
                disable: [
                    function(date) {
                        var dateString = formatDateForComparison(date);
                        return availableDates.indexOf(dateString) === -1;
                    }
                ],
                onDayCreate: function(dObj, dStr, fp, dayElem) {
                    var dateString = formatDateForComparison(dayElem.dateObj);
                    if (availableDates.indexOf(dateString) !== -1) {
                        dayElem.classList.add("available-date");
                    }
                },
                onChange: function(selectedDates, dateStr, instance) {
                    if (dateStr) {
                        var scheduleID = dateScheduleMap[dateStr];
                        if (scheduleID) {
                            $followUpScheduleIDInput.val(scheduleID);
                            loadFollowUpTimeslots(scheduleID);
                        }
                    }
                },
                onReady: function(selectedDates, dateStr, instance) {
                    instance.input.disabled = true;
                }
            });

            $('#enableFollowUp').on('change', function() {
                if ($(this).is(':checked')) {
                    loadFollowUpDates(doctorID)
                    $('#followUpContainer').slideDown();
                    $('#followup_concern').prop('required', true);
                    $('#followup_date').prop('required', true);
                    $('#followup_timeslot').prop('required', true);
                } else {
                    $('#followUpContainer').slideUp();
                    $('#followup_concern').prop('required', false).val('');
                    $('#followup_date').prop('required', false).val('');
                    $('#followup_timeslot').prop('required', false).val('');
                    $('#followup_scheduleID').val('');
                    if (flatpickrInstance) flatpickrInstance.clear();
                }
            });

            function loadFollowUpDates(doctorID) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/appointment/book/dates',
                    type: 'GET',
                    data: { doctorID: doctorID },
                    dataType: 'json',
                    success: function(response) {
                        availableDates = [];
                        dateScheduleMap = {};

                        if (response && response.length > 0) {
                            response.forEach(function(schedule) {
                                availableDates.push(schedule.scheduleDate);
                                dateScheduleMap[schedule.scheduleDate] = schedule.scheduleID;
                            });

                            flatpickrInstance.input.disabled = false;
                            flatpickrInstance.redraw();
                            $followUpDateInput.attr('placeholder', 'Click to select date');
                        } else {
                            $followUpDateInput.attr('placeholder', 'No dates available');
                        }
                    },
                    error: function() {
                        alert('Error loading available dates');
                    }
                });
            }

            function loadFollowUpTimeslots(scheduleID) {
                resetSelect($followUpTimeslotSelect, '-- Select Time Slot --');

                $.ajax({
                    url: '${pageContext.request.contextPath}/appointment/book/timeslots',
                    type: 'GET',
                    data: { scheduleID: scheduleID },
                    dataType: 'html',
                    success: function(htmlResponse) {
                        $followUpTimeslotSelect.html(htmlResponse);
                        $followUpTimeslotSelect.prop('disabled', false);
                    },
                    error: function() {
                        alert('Error loading time slots');
                    }
                });
            }

            // Helper function to reset select dropdown
            function resetSelect($select, defaultText) {
                $select.html('<option value="">' + defaultText + '</option>');
                $select.prop('disabled', true);
            }

            // Helper function to reset datepicker
            function resetDatePicker() {
                availableDates = [];
                dateScheduleMap = {};
                flatpickrInstance.clear();
                $followUpScheduleIDInput.val('');
                flatpickrInstance.input.disabled = true;
                flatpickrInstance.redraw();
                $followUpDateInput.attr('placeholder', 'Select Date');
            }

            function formatDateForComparison(date) {
                var year = date.getFullYear();
                var month = String(date.getMonth() + 1).padStart(2, '0');
                var day = String(date.getDate()).padStart(2, '0');
                return year + '-' + month + '-' + day;
            }
        });

        function validateForm() {
            const diagnosis = $('#diagnosis').val().trim();
            const treatment = $('#treatment').val().trim();
            const isFollowUpChecked = $('#enableFollowUp').is(':checked');
            const followUpConcern = $('#followup_concern').val();
            const followUpDate = $('#followup_date').val();
            const followUpTime = $('#followup_timeslot').val();

            if (!diagnosis) {
                alert('Please fill in the Diagnosis field');
                return false;
            }
            if (!treatment) {
                alert('Please fill in the Treatment & Prescription field');
                return false;
            }
            
            if (isFollowUpChecked) {
                if (!followUpDate || !followUpTime) {
                    alert('Please select both a date and a time slot for the follow-up appointment.');
                    return false;
                }
            }

            if (!confirm("NOTICE: Are you sure you want to COMPLETE this consultation?")) {
                return false; 
            }
            
            return true;
        }
        </script>
        <style>
            /* Highlight available dates in Flatpickr */
            .flatpickr-day.available-date {
                background-color: #3a57e831 !important;
                border-color: #3a57e8 !important;
            }
            
            .flatpickr-day.available-date:hover {
                background-color: #3a57e8 !important;
                color: white !important;
            }
        </style>
        
    </body>
</html>