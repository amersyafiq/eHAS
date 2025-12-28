<%-- 
    Document   : book.jsp
    Created on : 28 Dec 2025, 9:49:31 pm
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
                            <button class="home-btn">Home</button>
                        </div>

                        <!-- Form -->
                        <div class="card">

                            <div class="form-group">
                                <label>Hospital Branch: <span class="required">*</span></label>
                                <select id="hospital" onchange="onHospitalChange()">
                                    <option value="">Select hospital/clinic</option>
                                    <option value="H1">Hospital A</option>
                                    <option value="H2">Hospital B</option>
                                </select>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label>Specialisation: <span class="required">*</span></label>
                                    <select id="specialisation" disabled onchange="onSpecialisationChange()">
                                        <option value="">Select specialisation</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Doctor Name: <span class="required">*</span></label>
                                    <select id="doctor" disabled onchange="onDoctorChange()">
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
                                    <select id="timeSlot" disabled onchange="onTimeChange()">
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

        function resetSelect(id, label) {
            const el = document.getElementById(id);
            el.innerHTML = `<option value="">Select ${label}</option>`;
            el.disabled = true;
        }

        function onHospitalChange() {
            resetSelect("specialisation", "specialisation");
            resetSelect("doctor", "doctor");
            resetSelect("timeSlot", "time");

            document.getElementById("appointmentDate").value = "";
            document.getElementById("appointmentDate").disabled = true;
            document.getElementById("nextBtn").disabled = true;

            const hospital = document.getElementById("hospital").value;
            if (!hospital) return;

            const spec = document.getElementById("specialisation");
            spec.disabled = false;

            Object.keys(data[hospital]).forEach(s => {
                const opt = document.createElement("option");
                opt.value = s;
                opt.text = s;
                spec.appendChild(opt);
            });
        }

        function onSpecialisationChange() {
            resetSelect("doctor", "doctor");
            resetSelect("timeSlot", "time");

            document.getElementById("appointmentDate").value = "";
            document.getElementById("appointmentDate").disabled = true;
            document.getElementById("nextBtn").disabled = true;

            const hospital = document.getElementById("hospital").value;
            const spec = document.getElementById("specialisation").value;

            if (!hospital || !spec) return;

            const doctor = document.getElementById("doctor");
            doctor.disabled = false;

            data[hospital][spec].forEach(d => {
                const opt = document.createElement("option");
                opt.value = d;
                opt.text = d;
                doctor.appendChild(opt);
            });
        }

        function onDoctorChange() {
            resetSelect("timeSlot", "time");
            document.getElementById("appointmentDate").value = "";
            document.getElementById("nextBtn").disabled = true;

            if (document.getElementById("doctor").value) {
                document.getElementById("appointmentDate").disabled = false;
            }
        }

        function onDateChange() {
            resetSelect("timeSlot", "time");
            document.getElementById("nextBtn").disabled = true;

            if (document.getElementById("appointmentDate").value) {
                document.getElementById("timeSlot").disabled = false;
                generateTimeSlots();
            }
        }

        function onTimeChange() {
            const nextBtn = document.getElementById("nextBtn");
            const hasValue = document.getElementById("timeSlot").value !== "";

            nextBtn.disabled = !hasValue;

            if (hasValue) {
                nextBtn.classList.remove("btn-disabled");
                nextBtn.classList.add("btn-primary");
            } else {
                nextBtn.classList.remove("btn-primary");
                nextBtn.classList.add("btn-disabled");
            }
        }

        /* ===== Time Slot Generator ===== */
        function generateTimeSlots() {
            const timeSelect = document.getElementById("timeSlot");
            timeSelect.innerHTML = "";

            const bookedSlots = ["09:00", "10:30", "13:00", "15:30"];

            for (let hour = 8; hour < 17; hour++) {
                for (let min = 0; min < 60; min += 30) {

                    if (hour === 16 && min === 30) break;

                    const time = `${hour.toString().padStart(2, '0')}:${min.toString().padStart(2, '0')}`;
                    const opt = document.createElement("option");

                    opt.value = time;
                    opt.text = bookedSlots.includes(time)
                        ? `${time} - Booked`
                        : `${time} - Available`;

                    if (bookedSlots.includes(time)) {
                        opt.disabled = true;
                    }

                    timeSelect.appendChild(opt);
                }
            }
        }
        </script>
    </body>
</html>
