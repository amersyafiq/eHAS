<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Book Appointment" />

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
                <div class="conatiner-fluid content-inner p-3">
                    <%-- Breadcrumb Start --%> 
                    <div class="col-12">
                        <div class="card py-3 px-5 mb-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item">
                                                <a href="#">Appointments</a>
                                            </li>
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
                    <%-- Breadcrumb END --%>

                    <form method="POST" action="${pageContext.request.contextPath}/appointment/book" class="row">
                        <input type="hidden" name="patientID" value="${sessionScope.loggedUser.accountID}">
                        <div class="col-12">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="hospital">Hospital: <span class="text-danger">*</span></label>
                                        <select class="form-select" name="hospital" id="hospital" disabled>
                                            <option value="1">Taman Medical Center</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 pe-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="speciality">Speciality: <span class="text-danger">*</span></label>
                                        <select id="speciality" name="speciality" class="form-select" required>
                                            <option value="">-- Select Speciality --</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 ps-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="doctor">Doctor Name: <span class="text-danger">*</span></label>
                                        <select class="form-select" name="doctor" id="doctor" disabled required>
                                            <option value="">-- Select Doctor --</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="header-title my-3">
                            <h5 class="card-title px-2 fs-6 text-dark">Select Date and Time</h5>
                        </div>
                        <div class="col-md-6 pe-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="date">Date: <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="date" id="date" placeholder="Select Date" readonly required>
                                        <input type="hidden" name="scheduleID" id="scheduleID">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 ps-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="timeslot">Time slot: <span class="text-danger">*</span></label>
                                        <select class="form-select" name="timeslot" id="timeslot" disabled required>
                                            <option value="">-- Select Time Slot --</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-12 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="concern">Concern / Reason for Visit:</label>
                                        <textarea class="form-control" name="concern" id="concern" rows="3" placeholder="Describe your medical concern or reason for this appointment"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary w-100">Book Appointment</button>
                        </div>
                    </form>
                </div>
                <%-- Main Section END --%>

            </div>
        
        
            <!-- Footer Section Start -->
            <%@ include file="/WEB-INF/jspf/footer.jspf" %>
            <!-- Footer Section END -->    

        </main>
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

        <script>
            $(document).ready(function() {
                var $specialitySelect = $('#speciality');
                var $doctorSelect = $('#doctor');
                var $dateInput = $('#date');
                var $scheduleIDInput = $('#scheduleID');
                var $timeslotSelect = $('#timeslot');
                
                var availableDates = []; // Store available dates
                var dateScheduleMap = {}; // Map dates to schedule IDs
                var flatpickrInstance = null;

                // Initialize Flatpickr (disabled initially)
                flatpickrInstance = flatpickr("#date", {
                    dateFormat: "Y-m-d",
                    minDate: "today",
                    disable: [
                        function(date) {
                            // Disable all dates except those in availableDates
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
                                $scheduleIDInput.val(scheduleID);
                                loadTimeslots(scheduleID);
                            }
                        }
                    },
                    onReady: function(selectedDates, dateStr, instance) {
                        instance.input.disabled = true;
                    }
                });

                loadSpecialities();

                function loadSpecialities() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/appointment/book/specialities',
                        type: 'GET',
                        dataType: 'html', 
                        success: function(htmlResponse) {
                            $specialitySelect.html(htmlResponse);
                        },
                        error: function() {
                            $specialitySelect.html('<option value="">Error loading specialities</option>');
                        }
                    });
                }

                // When speciality changes, load doctors
                $specialitySelect.change(function() {
                    var selectedSpecialityID = $(this).val();

                    // Reset dependent fields
                    resetSelect($doctorSelect, '-- First choose a speciality --');
                    resetDatePicker();
                    resetSelect($timeslotSelect, '-- Select Time Slot --');

                    if (!selectedSpecialityID) {
                        return;
                    }

                    $.ajax({
                        url: '${pageContext.request.contextPath}/appointment/book/doctors',
                        type: 'GET',
                        data: { specialityID: selectedSpecialityID },
                        dataType: 'html', 
                        success: function(htmlResponse) {
                            $doctorSelect.html(htmlResponse);
                            $doctorSelect.prop('disabled', false);
                        },
                        error: function() {
                            $doctorSelect.html('<option value="">Error loading doctors</option>');
                        }
                    });
                });

                // When doctor changes, load dates
                $doctorSelect.change(function() {
                    var selectedDoctorID = $(this).val();

                    // Reset dependent fields
                    resetDatePicker();
                    resetSelect($timeslotSelect, '-- Select Time Slot --');

                    if (!selectedDoctorID) {
                        return;
                    }

                    $.ajax({
                        url: '${pageContext.request.contextPath}/appointment/book/dates',
                        type: 'GET',
                        data: { doctorID: selectedDoctorID },
                        dataType: 'json',
                        success: function(response) {
                            // Clear previous dates
                            availableDates = [];
                            dateScheduleMap = {};

                            // Parse the response and populate available dates
                            if (response && response.length > 0) {
                                response.forEach(function(schedule) {
                                    availableDates.push(schedule.scheduleDate);
                                    dateScheduleMap[schedule.scheduleDate] = schedule.scheduleID;
                                });

                                // Enable and refresh flatpickr
                                flatpickrInstance.input.disabled = false;
                                flatpickrInstance.redraw();
                                $dateInput.attr('placeholder', 'Click to select date');
                            } else {
                                $dateInput.attr('placeholder', 'No dates available');
                            }
                        },
                        error: function() {
                            alert('Error loading available dates');
                        }
                    });
                });

                // Load timeslots
                function loadTimeslots(scheduleID) {
                    resetSelect($timeslotSelect, '-- Select Time Slot --');

                    $.ajax({
                        url: '${pageContext.request.contextPath}/appointment/book/timeslots',
                        type: 'GET',
                        data: { scheduleID: scheduleID },
                        dataType: 'html', 
                        success: function(htmlResponse) {
                            $timeslotSelect.html(htmlResponse);
                            $timeslotSelect.prop('disabled', false);
                        },
                        error: function() {
                            $timeslotSelect.html('<option value="">Error loading timeslots</option>');
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
                    $scheduleIDInput.val('');
                    flatpickrInstance.input.disabled = true;
                    flatpickrInstance.redraw();
                    $dateInput.attr('placeholder', 'Select Date');
                }

                // Helper function to format date for comparison (yyyy-mm-dd)
                function formatDateForComparison(date) {
                    var year = date.getFullYear();
                    var month = String(date.getMonth() + 1).padStart(2, '0');
                    var day = String(date.getDate()).padStart(2, '0');
                    return year + '-' + month + '-' + day;
                }
            });
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