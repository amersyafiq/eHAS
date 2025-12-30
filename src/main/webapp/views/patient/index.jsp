<%-- 
    Document   : index
    Created on : Dec 23, 2025, 5:42:57 PM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Dashboard" />
    
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
                    <div class="row">
                        <div class="col-12">
                            <div class="card bg-primary py-4 px-5 mb-3" style="background: linear-gradient(90deg, #0048B2 0%, #3B8AFF 100%);">
                                <h4 class="text-white fw-bold">Welcome back, ${sessionScope.loggedUser.fullName}</h4>
                                <p class="text-white fs-5 m-0 fw-lighter">You are a ${sessionScope.loggedUser.accountType}</p>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 pe-md-1">
                            <div class="card py-4 px-5">
                                aaaa
                            </div>
                        </div>
                        <div class="col-12 col-md-6 pw-md-1">
                            <div class="card py-4 px-5">
                                ssss
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
    </body>
</html>

