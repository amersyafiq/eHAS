<%-- 
    Document   : consultation
    Created on : Consultation Feature Implementation
    Author     : eHAS Team
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Conduct Consultation" />

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
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between">
                                    <div class="header-title">
                                        <h4 class="card-title">Conduct Consultation</h4>
                                    </div>
                                </div>
                                <div class="card-body">
                                    
                                    <%-- Error Message Display --%>
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <strong>Error:</strong> ${error}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                    </c:if>
                                    
                                    <%-- Success Message Display --%>
                                    <c:if test="${not empty success}">
                                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                            <strong>Success:</strong> ${success}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                    </c:if>
                                    
                                    <%-- Consultation Form --%>
                                    <form action="${pageContext.request.contextPath}/doctor/consultation" method="POST" class="needs-validation" novalidate>
                                        
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="appointmentId" class="form-label">Appointment ID <span class="text-danger">*</span></label>
                                                <input type="number" 
                                                       class="form-control" 
                                                       id="appointmentId" 
                                                       name="appointmentId" 
                                                       value="${param.appointmentId}" 
                                                       required>
                                                <div class="invalid-feedback">
                                                    Please provide a valid Appointment ID.
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-12 mb-3">
                                                <label for="symptoms" class="form-label">Symptoms</label>
                                                <textarea class="form-control" 
                                                          id="symptoms" 
                                                          name="symptoms" 
                                                          rows="4" 
                                                          placeholder="Enter patient symptoms...">${param.symptoms}</textarea>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-12 mb-3">
                                                <label for="diagnosis" class="form-label">Diagnosis</label>
                                                <textarea class="form-control" 
                                                          id="diagnosis" 
                                                          name="diagnosis" 
                                                          rows="4" 
                                                          placeholder="Enter diagnosis...">${param.diagnosis}</textarea>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-12 mb-3">
                                                <label for="treatment" class="form-label">Treatment</label>
                                                <textarea class="form-control" 
                                                          id="treatment" 
                                                          name="treatment" 
                                                          rows="4" 
                                                          placeholder="Enter treatment details...">${param.treatment}</textarea>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-12 mb-3">
                                                <label for="notes" class="form-label">Notes</label>
                                                <textarea class="form-control" 
                                                          id="notes" 
                                                          name="notes" 
                                                          rows="4" 
                                                          placeholder="Enter additional notes...">${param.notes}</textarea>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-md-12">
                                                <button type="submit" class="btn btn-primary">Submit Consultation</button>
                                                <a href="${pageContext.request.contextPath}/doctor/appointments" class="btn btn-secondary">Cancel</a>
                                            </div>
                                        </div>
                                        
                                    </form>
                                    
                                </div>
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
        
        <%-- Form Validation Script --%>
        <script>
            (function() {
                'use strict';
                var forms = document.querySelectorAll('.needs-validation');
                Array.prototype.slice.call(forms).forEach(function(form) {
                    form.addEventListener('submit', function(event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            })();
        </script>
    </body>
</html>

