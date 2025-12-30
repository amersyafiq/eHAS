<%-- 
    Document   : book.jsp
    Created on : 28 Dec 2025, 9:49:31 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Book Appointment" />
    <head>
        <style>
            body {
                margin: 0;
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f1f3f6;
            }

            .container {
                max-width: 1100px;
                margin: 30px auto;
                padding: 20px;
            }

            /* Header */
            .breadcrumb {
                background: #ffffff;
                padding: 15px 20px;
                border-radius: 6px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .breadcrumb span {
                color: #1f4ed8;
                font-weight: 500;
            }

            .home-btn {
                background: #1f4ed8;
                color: #fff;
                border: none;
                padding: 8px 16px;
                border-radius: 5px;
                cursor: pointer;
            }

            /* Card */
            .card {
                background: #ffffff;
                padding: 25px;
                border-radius: 6px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            label {
                font-weight: 500;
                display: block;
                margin-bottom: 8px;
            }

            .required {
                color: red;
            }

            select, input[type="date"] {
                width: 100%;
                padding: 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
                background: #fff;
            }

            h3 {
                margin: 30px 0 15px;
                font-size: 18px;
            }

            /* Buttons */
            .button-row {
                display: grid;
                grid-template-columns: 1fr;
                gap: 20px;
                margin-top: 30px;
            }

            .btn-primary {
                background: #3f5ae0;
                color: #fff;
                border: none;
                padding: 14px;
                font-size: 15px;
                border-radius: 6px;
                cursor: pointer;
            }

            .btn-disabled {
                background: #bdbdbd;
                color: #fff;
                border: none;
                padding: 14px;
                font-size: 15px;
                border-radius: 6px;
                cursor: not-allowed;
            }
            
            /* Force hide all Choices.js wrappers in this form */
            .card .choices {
                display: none !important;
            }
            
            /* Make sure native selects are visible */
            .card select {
                display: block !important;
            }
        </style>
    </head>
    <body class=" " data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
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
                    <%-- TODO: Use Case Here --%>
                    <div class="container">

                        <!-- Header -->
                        <div class="breadcrumb">
                            <span>Appointments / Book Appointment</span>
                            <button class="home-btn" onclick="location.href='./'">Home</button>
                        </div>

                        <!-- Form -->
                        <div class="card">
                            <div class="form-group">
                                <label>Hospital Branch: <span class="required">*</span></label>
                                <select id="hospital" class="no-choices" data-trigger="" onchange="onHospitalChange()">
                                    <option value="H1" selected>Hospital A</option> <!-- Always selected -->
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Doctor Name: <span class="required">*</span></label>
                                <select id="doctor" class="no-choices" data-trigger="" onchange="onDoctorChange()">
                                <option value="">Select doctor</option>
                                <option value="11" <c:if test="${selectedDoctor == '11'}">selected</c:if>>Dr Farid Hassan</option>
                            </select>
                            </div>

                            <h3>Select Date and Time</h3>

                            <div class="form-row">
                                <div class="form-group">
                                    <label>Date: <span class="required">*</span></label>
                                    <input type="date" id="appointmentDate" disabled onchange="onDateChange()">
                                </div>

                                <div class="form-group">
                                    <label>Time: <span class="required">*</span></label>
                                    <select id="timeSlot" class="no-choices" data-trigger="" disabled onchange="onTimeChange()">
                                        <option value="">Select time</option>
                                    </select>
                                </div>
                            </div>

                            <div class="button-row" style="grid-template-columns: 1fr 1fr;">
                                <button type="button" class="btn-primary"
                                        onclick="fetchTimeslot()">Fetch Timeslot</button>
                                <button type="button" onclick="location.href='${pageContext.request.contextPath}/appointment/summary'" 
                                        class="btn-disabled" id="nextBtn" disabled>Next</button>
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
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
       <script>
        document.addEventListener('DOMContentLoaded', () => {
            const doctor = document.getElementById('doctor');
            const appointmentDate = document.getElementById('appointmentDate');
            const hospital = document.getElementById('hospital');

            // Doctor is always enabled
            doctor.disabled = false;

            // Enable date input if a doctor is selected
            if (doctor.value) {
                appointmentDate.disabled = false;
            }

            // If hospital is already selected, make sure doctor is enabled
            if (hospital && hospital.value) {
                doctor.disabled = false;
            }

            // Preserve previously selected doctor
            const selectedDoctor = '${selectedDoctor}';
            if (selectedDoctor && doctor) {
                doctor.value = selectedDoctor;
            }
        });

        function resetSelect(id, placeholderText) {
            const el = document.getElementById(id);
            el.innerHTML = '';
            const placeholder = document.createElement('option');
            placeholder.value = '';
            placeholder.textContent = placeholderText;
            placeholder.selected = true;
            el.appendChild(placeholder);
            el.disabled = true;
        }

        function onHospitalChange() {
            // Just clear date and time, but don't disable doctor
            const appointmentDate = document.getElementById('appointmentDate');
            const timeSlot = document.getElementById('timeSlot');

            // Reset timeslot and date
            timeSlot.innerHTML = '<option value="">Select time</option>';
            timeSlot.disabled = true;

            appointmentDate.value = '';
            appointmentDate.disabled = true;

            disableNext();
        }


        // Initialize on page load
        document.addEventListener('DOMContentLoaded', () => {
            const hospital = document.getElementById('hospital');
            const doctor = document.getElementById('doctor');

            // If hospital is already selected (after page reload), enable doctor
            if (hospital && hospital.value) {
                doctor.disabled = false;
            }

            // If a doctor was previously selected, make sure it's selected
            const selectedDoctor = '${selectedDoctor}';
            if (selectedDoctor && doctor) {
                doctor.value = selectedDoctor;
            }
        });

        function onDoctorChange() {
            const timeSlot = document.getElementById('timeSlot');
            timeSlot.innerHTML = '<option value="">Select time</option>';
            timeSlot.disabled = true;

            document.getElementById('appointmentDate').value = '';
            document.getElementById('appointmentDate').disabled = false;
            disableNext();
        }

        function onDateChange() {
            const timeSlot = document.getElementById('timeSlot');
            timeSlot.innerHTML = '<option value="">Select time</option>';
            timeSlot.disabled = true;
            disableNext();

            const date = document.getElementById('appointmentDate').value;
            if (!date) return;

            generateTimeSlots();
        }

        function onTimeChange() {
            const nextBtn = document.getElementById('nextBtn');
            const hasValue = document.getElementById('timeSlot').value !== '';
            nextBtn.disabled = !hasValue;

            if (hasValue) {
                nextBtn.classList.remove('btn-disabled');
                nextBtn.classList.add('btn-primary');
            } else {
                nextBtn.classList.remove('btn-primary');
                nextBtn.classList.add('btn-disabled');
            }
        }

        function disableNext() {
            const nextBtn = document.getElementById('nextBtn');
            nextBtn.disabled = true;
            nextBtn.classList.remove('btn-primary');
            nextBtn.classList.add('btn-disabled');
        }

        function formatTime12(hour, min) {
            var period = "a.m.";
            if (hour > 12) {
                period = "p.m.";
                hour = hour - 12;
            } else if (hour === 12) {
                period = "p.m.";
            }
            if (min === 0) {
                return hour + ":" + min + "0 " + period;
            } else {
                return hour + ":" + min + " " + period;
            }
        }

        function generateTimeSlots() {
            const bookedSlots = <c:out value='${bookedSlots}' />; // list from servlet

            allTimeSlots.forEach(timeSlot => {
                const option = document.createElement('option');
                option.value = timeSlot;

                if (bookedSlots.includes(timeSlot)) {
                    option.textContent = formatTime12(...timeSlot.split(':')) + ' - Booked';
                    option.disabled = true;
                    option.style.color = '#999';
                    option.style.backgroundColor = '#f5f5f5';
                } else {
                    option.textContent = formatTime12(...timeSlot.split(':')) + ' - Available';
                }

                timeSelect.appendChild(option);
            });
            timeSelect.disabled = false;
        }
        function fetchTimeslot() {
            const doctor = document.getElementById('doctor').value;
            const date = document.getElementById('appointmentDate').value;

            if (!doctor || !date) {
                alert("Please select doctor and date first!");
                return;
            }

            // Hospital is always H1, so you can hardcode it
            const hospital = "H1";

            // Redirect back to servlet with parameters
            const url = `${window.location.pathname}?hospital=${encodeURIComponent(hospital)}&doctor=${encodeURIComponent(doctor)}&appointmentDate=${encodeURIComponent(date)}`;
            window.location.href = url;
        }
        </script>
    </body>
</html>
