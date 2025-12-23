<%-- 
    Document   : register
    Created on : Dec 22, 2025, 4:23:54 PM
    Author     : SYAFIQ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.List"%>
<!DOCTYPE html>
<html>
    <%@ include file="partials/head.jsp" %>
    <body class=" " data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
        <!-- loader Start -->
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body">
                </div>
            </div>    
        </div>
        <!-- loader END -->
        
        <div class="wrapper">
            <section class="login-content">
                <div class="row m-0 align-items-center bg-white vh-100">            
                    <div class="col-md-6 d-md-block d-none bg-primary p-0 mt-n1 h-100 overflow-hidden">
                        <img src="${pageContext.request.contextPath}/vendor/assets/images/auth/05.png" class="h-100 gradient-main" alt="images">
                    </div>
                    <div class="col-md-6 vh-100 overflow-auto">               
                        <div class="row justify-content-center">
                            <div class="col-md-10">
                                <div class="card card-transparent shadow-none d-flex justify-content-center mb-0">
                                    <div class="card-body">
                                        <a href="${pageContext.request.contextPath}/" class="navbar-brand d-flex align-items-center justify-content-center mb-3">
                                            <img src="${pageContext.request.contextPath}/vendor/assets/images/logo.png" alt="Taman Medical Centre Logo" style="height: 7rem;">
                                        </a>
                                        <h2 class="mb-2 text-center">Sign Up</h2>
                                        <p class="text-center">Create your Taman Medical Account.</p>
                                        
                                        <%-- Register Form Start --%>
                                        <div class="card-body">
                                            <%
                                                List<String> errors = (List<String>) request.getAttribute("errors");
                                                String fullNameVal = request.getAttribute("fullName") != null ? request.getAttribute("fullName").toString() : "";
                                                String dateOfBirthVal = request.getAttribute("dateOfBirth") != null ? request.getAttribute("dateOfBirth").toString() : "";
                                                String emailVal = request.getAttribute("email") != null ? request.getAttribute("email").toString() : "";
                                                String icVal = request.getAttribute("ic_passport") != null ? request.getAttribute("ic_passport").toString() : "";
                                                String phoneVal = request.getAttribute("phoneNo") != null ? request.getAttribute("phoneNo").toString() : "";
                                                String picturePath = request.getAttribute("picturePath") != null ? request.getAttribute("picturePath").toString() : "";
                                            %>

                                            <% if (errors != null && !errors.isEmpty()) { %>
                                                <div class="alert alert-danger">
                                                    <strong>There were errors with your submission:</strong>
                                                    <ul class="mb-0">
                                                    <% for (String err : errors) { %>
                                                        <li><%= err %></li>
                                                    <% } %>
                                                    </ul>
                                                </div>
                                            <% } %>

                                            <form action="${pageContext.request.contextPath}/register" method="POST" enctype="multipart/form-data" class="row g-3 needs-validation" novalidate>
                                                <div class="col-md-12">
                                                    <label for="fullName" class="form-label">Full Name</label>
                                                    <input type="text" name="fullName" class="form-control" id="fullName" required>
                                                    <div class="invalid-feedback">
                                                        Please enter a full name (more than 6 characters).
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="dateOfBirth" class="form-label">Birth Date</label>
                                                    <div class="input-group has-validation">
                                                        <input type="text" name="dateOfBirth" class="form-control date_flatpicker" id="dateOfBirth" required>
                                                        <div class="invalid-feedback">
                                                            Please select a valid birth date.
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="email" class="form-label">Email Address</label>
                                                    <input type="text" name="email" class="form-control" id="email" required>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid email address.
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="ic_passport" class="form-label">IC or Passport Number</label>
                                                    <input type="text" name="ic_passport" class="form-control" id="ic_passport" required>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid IC / Passport.
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="phoneNo" class="form-label">Phone Number</label>
                                                    <input type="text" name="phoneNo" class="form-control" id="phoneNo" required>
                                                    <div class="invalid-feedback">
                                                        Please enter a valid phone number.
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="password" class="form-label">Password</label>
                                                    <input type="password" name="password" class="form-control" id="password" required>
                                                    <div class="invalid-feedback">
                                                        Must be at least 8 characters long.
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                                                    <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" required>
                                                    <div class="invalid-feedback">
                                                        Password do not match.
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <label for="profilePicture" class="form-label">Profile Picture</label>
                                                    <input type="file" name="profilePicture" class="form-control" id="profilePicture" required accept="image/*">
                                                    <% if (picturePath != null && !picturePath.isEmpty()) { %>
                                                        <div class="mt-2">
                                                            <img src="<%= picturePath %>" alt="Profile" style="max-height:120px;" />
                                                        </div>
                                                    <% } %>
                                                    <div class="invalid-feedback">
                                                        Choose an image. (maximum size: 5MB)
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
                                                        <label class="form-check-label" for="invalidCheck">
                                                            Agree to terms and conditions
                                                        </label>
                                                        <div class="invalid-feedback">
                                                            You must agree before submitting.
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 d-flex justify-content-center">
                                                    <button class="btn btn-primary" type="submit">Register</button>
                                                </div>
                                                <p class="mt-3 text-center">
                                                    Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-underline">Click here to login.</a>
                                                </p>
                                            </form>
                                        </div>
                                        <%-- Register Form END --%>

                                    </div>
                                </div>    
                            </div>
                        </div>           
                        <div class="sign-bg sign-bg-right">
                            <svg width="280" height="230" viewBox="0 0 421 359" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <g opacity="0.05">
                                    <rect x="-15.0845" y="154.773" width="543" height="77.5714" rx="38.7857" transform="rotate(-45 -15.0845 154.773)" fill="#3A57E8"/>
                                    <rect x="149.47" y="319.328" width="543" height="77.5714" rx="38.7857" transform="rotate(-45 149.47 319.328)" fill="#3A57E8"/>
                                    <rect x="203.936" y="99.543" width="310.286" height="77.5714" rx="38.7857" transform="rotate(45 203.936 99.543)" fill="#3A57E8"/>
                                    <rect x="204.316" y="-229.172" width="543" height="77.5714" rx="38.7857" transform="rotate(45 204.316 -229.172)" fill="#3A57E8"/>
                                </g>
                            </svg>
                        </div>
                    </div>   
                </div>
            </section>
        </div>

        <%@ include file="partials/scripts.jsp" %>
    </body>
</html>
