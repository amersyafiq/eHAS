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
                                    <option value="">Select hospital/clinic</option>
                                    <option value="H1">Taman Medical Center, Kuala Lumpur</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Doctor Name: <span class="required">*</span></label>
                                <select id="doctor" class="no-choices" data-trigger="" disabled onchange="onDoctorChange()">
                                    <option value="">Select doctor</option>
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

                            <div class="button-row">
                                <button type="button" onclick="goToSummary()" class="btn-disabled" id="nextBtn" disabled>Next</button>
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
        const data = {
            H1: ["Dr Farid Hassan"], // combine all doctors
        };

        // Prevent Choices.js from interfering
        document.addEventListener('DOMContentLoaded', () => {
            const selectIds = ['hospital', 'doctor', 'timeSlot'];
            selectIds.forEach(id => {
                const el = document.getElementById(id);
                if (el) {
                    el.setAttribute('data-choice', 'false');
                    if (el.choices) {
                        try { el.choices.destroy(); } catch(e) {}
                    }
                }
            });
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
            resetSelect('doctor', 'Select doctor');
            resetSelect('timeSlot', 'Select time');

            document.getElementById('appointmentDate').value = '';
            document.getElementById('appointmentDate').disabled = true;
            disableNext();

            const hospital = document.getElementById('hospital').value;
            if (!hospital) return;

            const doctor = document.getElementById('doctor');
            doctor.disabled = false;

            data[hospital].forEach(d => {
                const opt = document.createElement('option');
                opt.value = d;
                opt.textContent = d;
                doctor.appendChild(opt);
            });
        }

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
            const timeSelect = document.getElementById('timeSlot');
            timeSelect.innerHTML = '<option value="">Select time</option>';

            const allTimeSlots = [
                "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
                "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                "16:00", "16:30", "17:00"
            ];

            const bookedSlots = [];

            allTimeSlots.forEach(timeSlot => {
                const [hourStr, minuteStr] = timeSlot.split(':');
                const hour = parseInt(hourStr, 10);
                const minute = parseInt(minuteStr, 10);
                const displayTime = formatTime12(hour, minute);

                const isBooked = bookedSlots.includes(timeSlot);

                const option = document.createElement('option');

                // VALUE = what goes to servlet (FULL formatted time)
                option.value = displayTime;

                // TEXT = what user sees
                option.textContent = displayTime + (isBooked ? ' - Booked' : ' - Available');

                if (isBooked) {
                    option.disabled = true;
                    option.style.color = '#999';
                    option.style.backgroundColor = '#f5f5f5';
                }

                timeSelect.appendChild(option);
            });

            timeSelect.disabled = false;
        }
        function goToSummary() {
            const doctor = document.getElementById('doctor').value;
            const date = document.getElementById('appointmentDate').value;
            const time = document.getElementById('timeSlot').value;

            if (!doctor || !date || !time) {
                alert("Please complete all selections.");
                return;
            }

            const params = new URLSearchParams({
                doctor: doctor,
                date: date,
                time: time
            });

            window.location.href =
                "${pageContext.request.contextPath}/appointment/summary?" + params.toString();
        }
        </script>
    </body>
</html>
    