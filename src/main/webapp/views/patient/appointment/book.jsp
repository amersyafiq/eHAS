<%-- 
    Document   : book.jsp
    Created on : 28 Dec 2025, 9:49:31 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="../../partials/head.jsp" %>
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
        <%@ include file="../../partials/nav.jsp" %>
        <%-- Navigation END --%>
        
        <main class="main-content">
            <div class="position-relative iq-banner">

                <!--Header Start-->
                <%@ include file="../../partials/header.jsp" %>
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
                                    <option value="H1">Hospital A</option>
                                    <option value="H2">Hospital B</option>
                                </select>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label>Specialisation: <span class="required">*</span></label>
                                    <select id="specialisation" class="no-choices" data-trigger="" disabled onchange="onSpecialisationChange()">
                                        <option value="">Select specialisation</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Doctor Name: <span class="required">*</span></label>
                                    <select id="doctor" class="no-choices" data-trigger="" disabled onchange="onDoctorChange()">
                                        <option value="">Select doctor</option>
                                    </select>
                                </div>
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
                                <button type="button" onclick="location.href='${pageContext.request.contextPath}/appointment/summary'" class="btn-disabled" id="nextBtn" disabled>Next</button>
                            </div>

                        </div>
                    </div>
                    
                </div>
                <%-- Main Section END --%>

            </div>
        
        
            <!-- Footer Section Start -->
            <footer class="footer">
                <div class="footer-body">
                    <ul class="left-panel list-inline mb-0 p-0">
                        <li class="list-inline-item"><a href="${pageContext.request.contextPath}/vendor/dashboard/extra/privacy-policy.html">Privacy Policy</a></li>
                        <li class="list-inline-item"><a href="${pageContext.request.contextPath}/vendor/dashboard/extra/terms-of-service.html">Terms of Use</a></li>
                    </ul>
                    <div class="right-panel">
                        ©<script>document.write(new Date().getFullYear());</script> Taman Medical Center
                    </div>
                </div>
            </footer>
            <!-- Footer Section END -->    

        </main>
        
        <%@ include file="../../partials/scripts.jsp" %>
        <script>
        const data = {
            H1: {
                Cardiology: ["Dr. Ali", "Dr. Ahmad"],
                Dermatology: ["Dr. Siti"]
            },
            H2: {
                Cardiology: ["Dr. Zainal"],
                Orthopedic: ["Dr. Amin"]
            }
        };

        // Prevent Choices.js from interfering
        document.addEventListener('DOMContentLoaded', () => {
            const selectIds = ['hospital', 'specialisation', 'doctor', 'timeSlot'];
            selectIds.forEach(id => {
                const el = document.getElementById(id);
                if (el) {
                    el.setAttribute('data-choice', 'false');
                    // Clear any existing Choices.js instances
                    if (el.choices) {
                        try { el.choices.destroy(); } catch(e) {}
                    }
                }
            });
        });

        // FIXED: Reset select with proper placeholder (not disabled)
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

        // Hospital changed - FIXED: Use proper placeholder text
        function onHospitalChange() {
            resetSelect('specialisation', 'Select specialisation');
            resetSelect('doctor', 'Select doctor');
            resetSelect('timeSlot', 'Select time');

            document.getElementById('appointmentDate').value = '';
            document.getElementById('appointmentDate').disabled = true;
            disableNext();

            const hospital = document.getElementById('hospital').value;
            if (!hospital) return;

            const spec = document.getElementById('specialisation');
            spec.disabled = false;

            Object.keys(data[hospital]).forEach(s => {
                const opt = document.createElement('option');
                opt.value = s;
                opt.textContent = s;
                spec.appendChild(opt);
            });
        }

        // Specialisation changed - FIXED: Use proper placeholder text
        function onSpecialisationChange() {
            resetSelect('doctor', 'Select doctor');
            resetSelect('timeSlot', 'Select time');

            document.getElementById('appointmentDate').value = '';
            document.getElementById('appointmentDate').disabled = true;
            disableNext();

            const hospital = document.getElementById('hospital').value;
            const spec = document.getElementById('specialisation').value;
            if (!hospital || !spec) return;

            const doctor = document.getElementById('doctor');
            doctor.disabled = false;

            data[hospital][spec].forEach(d => {
                const opt = document.createElement('option');
                opt.value = d;
                opt.textContent = d;
                doctor.appendChild(opt);
            });
        }

        // Doctor changed - FIXED: Don't reset timeSlot here, just disable it
        function onDoctorChange() {
            const timeSlot = document.getElementById('timeSlot');
            timeSlot.innerHTML = '<option value="">Select time</option>';
            timeSlot.disabled = true;

            document.getElementById('appointmentDate').value = '';
            document.getElementById('appointmentDate').disabled = false;
            disableNext();
        }

        // Date changed - FIXED: Clear time slot properly
        function onDateChange() {
            const timeSlot = document.getElementById('timeSlot');
            timeSlot.innerHTML = '<option value="">Select time</option>';
            timeSlot.disabled = true;
            disableNext();

            const date = document.getElementById('appointmentDate').value;
            if (!date) return;

            generateTimeSlots();
        }

        // Time changed
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

        // Disable next button
        function disableNext() {
            const nextBtn = document.getElementById('nextBtn');
            nextBtn.disabled = true;
            nextBtn.classList.remove('btn-primary');
            nextBtn.classList.add('btn-disabled');
        }

        // FIXED: Format time properly
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

        // FIXED: Generate time slots - ensure proper display
        function generateTimeSlots() {
            const timeSelect = document.getElementById('timeSlot');
            timeSelect.innerHTML = '<option value="">Select time</option>';

            // Define all possible time slots (8:00 AM to 5:00 PM, 30-minute intervals)
            const allTimeSlots = [
                "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
                "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                "16:00", "16:30", "17:00"
            ];

            // Define booked time slots (replace with dynamic data from server if needed)
            const bookedSlots = ["09:00", "10:30", "13:00", "15:30"];

            console.log("All time slots:", allTimeSlots);
            console.log("Booked slots:", bookedSlots);

            // Loop through all time slots and create options
            allTimeSlots.forEach(timeSlot => {
                const [hourStr, minuteStr] = timeSlot.split(':');
                const hour = parseInt(hourStr, 10);
                const minute = parseInt(minuteStr, 10);
                // Format for display (12-hour format)
                const displayTime = formatTime12(hour, minute);
                console.log(displayTime);

                // Check if this slot is booked
                const isBooked = bookedSlots.includes(timeSlot);

                // Create option element
                const option = document.createElement('option');
                option.value = timeSlot;

                // Set display text based on availability
                if (isBooked) {
                    option.textContent = displayTime + ' - Booked';
                    option.disabled = true;
                    option.style.color = '#999';
                    option.style.backgroundColor = '#f5f5f5';
                } else {
                    option.textContent = displayTime + ' - Available';
                }

                // Add to select
                timeSelect.appendChild(option);
            });

            // Enable the select
            timeSelect.disabled = false;

            // Log for debugging
            console.log(`Generated ${allTimeSlots.length} time slots`);
            console.log(`${bookedSlots.length} slots are booked`);
        }
        </script>
    </body>
</html>