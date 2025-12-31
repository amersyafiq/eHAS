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

                    <form method="POST" class="row">
                        <div class="col-12">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="hospital">Hospital: <span class="text-danger">*</span></label>
                                        <select class="form-select" name="hospital" id="hospital" placeholder="Select Hospital / Clinic">
                                            <option value="">Taman Medical Center</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 pe-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="speciality">Specialization: <span class="text-danger">*</span></label>
                                        <select class="form-select" name="speciality" id="speciality">
                                            <option value="">All</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 ps-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="doctor_name">Doctor Name: <span class="text-danger">*</span></label>
                                        <select class="form-select border-none" name="doctor_name" id="doctor_name">
                                            <option value="">All</option>
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
                                        <select class="form-select" name="date" id="date">
                                            <option value="">All</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 ps-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="form-group mb-0">
                                        <label class="form-label text-dark" for="timeslot">Time slot: <span class="text-danger">*</span></label>
                                        <select class="form-select" name="timeslot" id="timeslot">
                                            <option value="">All</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary w-100">Book Appointment</button>
                        </div>
                    </form>
                <%-- Main Section END --%>

            </div>
        
        
            <!-- Footer Section Start -->
            <%@ include file="/WEB-INF/jspf/footer.jspf" %>
            <!-- Footer Section END -->    

        </main>
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>