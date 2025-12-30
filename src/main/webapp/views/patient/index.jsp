<%-- 
    Document   : index
    Created on : Dec 23, 2025, 5:42:57 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="../partials/head.jsp" %>
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
        <%@ include file="../partials/nav.jsp" %>
        <%-- Navigation END --%>
        
        <main class="main-content">
            <div class="position-relative iq-banner">

                <!--Header Start-->
                <%@ include file="../partials/header.jsp" %>
                <%-- Header END --%>
            
                <%-- Main Section Start --%>
                <div class="conatiner-fluid content-inner p-3">
                    <div class="row m-2">
                        <div class="col-12 card bg-primary py-4 px-5 mb-4" style="background: linear-gradient(90deg, #0048B2 0%, #3B8AFF 100%);">
                            <h4 class="text-white fw-bold">Welcome back, <%= account.getFullName() %></h4>
                            <p class="text-white fs-5 m-0 fw-lighter">You are a <%= account.getAccountType() %></p>
                        </div>
                        <div class="col-6 card bg-white py-4 px-5">
                            <h4 class="text-white fw-bold">Welcome back, <%= account.getFullName() %></h4>
                            <p class="text-white fs-5 m-0 fw-lighter">You are a <%= account.getAccountType() %></p>
                        </div>
                        <div class="col-6 card bg-white py-4 px-5">
                            <h4 class="text-white fw-bold">Welcome back, <%= account.getFullName() %></h4>
                            <p class="text-white fs-5 m-0 fw-lighter">You are a <%= account.getAccountType() %></p>
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
                        ©<script>document.write(new Date().getFullYear())</script> TAMAN HOSPITAL
                    </div>
                </div>
            </footer>
            <!-- Footer Section END -->    

        </main>
        
        <%@ include file="../partials/scripts.jsp" %>
    </body>
</html>

