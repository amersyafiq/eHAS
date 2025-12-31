<%-- 
    Document   : 404
    Created on : Dec 16, 2025, 11:48:42 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="404" />

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
            <script src="http://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/TweenMax.min.js"></script>

            <div class="gradient">
                <div class="container">
                    <img src="./vendor/assets/images/error/404.png" class="img-fluid mb-4 w-50" alt=""> 
                    <h2 class="mb-0 mt-4 text-white">Oops! This Page is Not Found.</h2>
                    <p class="mt-2 text-white">The requested page dose not exist.</p>
                    <a class="btn bg-white text-primary d-inline-flex align-items-center" href="./">Back to Home</a>
                </div>
                <div class="box">
                    <div class="c xl-circle">
                        <div class="c lg-circle">
                            <div class="c md-circle">
                                <div class="c sm-circle">
                                    <div class="c xs-circle">                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>    
            </div>
        </div>
        <!-- Library Bundle Script -->
        <script src="./vendor/assets/js/core/libs.min.js"></script>

        <!-- External Library Bundle Script -->
        <script src="./vendor/assets/js/core/external.min.js"></script>

        <!-- Widgetchart Script -->
        <script src="./vendor/assets/js/charts/widgetcharts.js"></script>

        <!-- mapchart Script -->
        <script src="./vendor/assets/js/charts/vectore-chart.js"></script>
        <script src="./vendor/assets/js/charts/dashboard.js" ></script>

        <!-- fslightbox Script -->
        <script src="./vendor/assets/js/plugins/fslightbox.js"></script>

        <!-- Settings Script -->
        <script src="./vendor/assets/js/plugins/setting.js"></script>

        <!-- Slider-tab Script -->
        <script src="./vendor/assets/js/plugins/slider-tabs.js"></script>

        <!-- Form Wizard Script -->
        <script src="./vendor/assets/js/plugins/form-wizard.js"></script>

        <!-- AOS Animation Plugin-->

        <!-- App Script -->
        <script src="./vendor/assets/js/hope-ui.js" defer></script>


    </body>
</html>
</html>
