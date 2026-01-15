<%-- 
    Document   : login
    Created on : Dec 17, 2025, 8:26:23 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Login" />
    
    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
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
                    <div class="col-md-6">
                        <div class="row justify-content-center">
                            <div class="col-md-10">
                                <div class="card card-transparent shadow-none d-flex justify-content-center mb-0 auth-card">
                                    <div class="card-body z-3 px-md-0 px-lg-4">
                                        <a href="${pageContext.request.contextPath}/" class="navbar-brand d-flex align-items-center justify-content-center mb-3">
                                            <img src="${pageContext.request.contextPath}/vendor/assets/images/logo.png" alt="Taman Medical Centre Logo" style="height: 7rem;">
                                        </a>
                                        <h2 class="mb-2 text-center">Log In</h2>
                                        <p class="text-center">Login to stay connected.</p>

                                        <% String error = (String) request.getAttribute("error"); %>
                                        <% if (error != null && !error.isEmpty()) { %>
                                            <div class="alert alert-danger mb-5">
                                                <ul class="mb-0">
                                                    <%= error %>
                                                </ul>
                                            </div>
                                        <% } %>
                                        
                                        <%-- Login Form Start --%>
                                        <form action="${pageContext.request.contextPath}/login" method="POST"  class="row g-3 needs-validation" novalidate>
                                            <div class="row w-100">
                                                <div class="col-lg-12">
                                                    <div class="form-group">
                                                        <label for="email" class="form-label">Email</label>
                                                        <input type="email" name="email" class="form-control" id="email" required aria-describedby="email" placeholder=" ">
                                                        <div class="invalid-feedback">
                                                            Email cannot be empty.
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12">
                                                    <div class="form-group">
                                                        <label for="password" class="form-label">Password</label>
                                                        <input type="password" name="password" class="form-control" id="password" required aria-describedby="password" placeholder=" ">
                                                        <div class="invalid-feedback">
                                                            Password cannot be empty.
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12 d-flex justify-content-between">
                                                    <div class="form-check mb-3">
                                                        <input type="checkbox" class="form-check-input" id="customCheck1">
                                                        <label class="form-check-label" for="customCheck1">Remember Me</label>
                                                    </div>
                                                    <a href="recoverpw.html">Forgot Password?</a>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-center">
                                                <button type="submit" class="btn btn-primary">Sign In</button>
                                            </div>
                                            <p class="mt-3 text-center">
                                                Don’t have an account? <a href="${pageContext.request.contextPath}/register" class="text-underline">Click here to sign up.</a>
                                            </p>
                                        </form>
                                        <%-- Login Form END --%>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="sign-bg">
                            <svg width="280" height="230" viewBox="0 0 431 398" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <g opacity="0.05">
                            <rect x="-157.085" y="193.773" width="543" height="77.5714" rx="38.7857" transform="rotate(-45 -157.085 193.773)" fill="#3B8AFF"/>
                            <rect x="7.46875" y="358.327" width="543" height="77.5714" rx="38.7857" transform="rotate(-45 7.46875 358.327)" fill="#3B8AFF"/>
                            <rect x="61.9355" y="138.545" width="310.286" height="77.5714" rx="38.7857" transform="rotate(45 61.9355 138.545)" fill="#3B8AFF"/>
                            <rect x="62.3154" y="-190.173" width="543" height="77.5714" rx="38.7857" transform="rotate(45 62.3154 -190.173)" fill="#3B8AFF"/>
                            </g>
                            </svg>
                        </div>
                    </div>
                    <div class="col-md-6 d-md-block d-none bg-primary p-0 mt-n1 vh-100 overflow-hidden">
                        <img src="${pageContext.request.contextPath}/vendor/assets/images/auth/01.png" class="img-fluid gradient-main animated-scaleX" alt="images">
                    </div>
                </div>
            </section>
        </div>

        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
