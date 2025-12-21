<%-- 
    Document   : index
    Created on : Dec 16, 2025, 11:16:50 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    <%@ include file="views/partials/head.jsp" %>
    <body class="uikit " data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">        
        <!-- loader Start -->
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body">
                </div>
            </div>
        </div>
        <!-- loader END -->

        <main>
            <div class="landing-page">

                <!-- Header Start -->
                <div class="container pt-2 col-11">
                    <div class="w-100 mx-auto d-flex justify-content-between align-items-center">
                        <a href="/" class="landing-logo">
                            <img src="./vendor/assets/images/logo.png" alt="Taman Medical Centre Logo" class="h-100">
                        </a>

                        <nav class="d-none d-lg-flex gap-4">
                            <a class="text-reset" href="#about-us">About Us</a>
                            <a class="text-reset" href="">Book Appointment</a>
                            <a class="text-reset" href="">Search Doctor</a>
                            <a class="text-reset" href="">Contact Us</a>
                        </nav>

                        <button 
                            onclick="location.href='./login'"
                            class="btn btn-md btn-primary rounded-pill d-flex gap-2 px-5 align-items-center"
                        >
                            Login
                            <svg width="13" height="12" viewBox="0 0 13 12" fill="none">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                  d="M6.71155 0.219668C6.99358 -0.0732226 7.45089 -0.0732226 7.73292 0.219668L12.7885 5.46968C13.0705 5.76256 13.0705 6.23746 12.7885 6.53034L7.73292 11.7803C7.45089 12.0732 6.99358 12.0732 6.71155 11.7803C6.42952 11.4875 6.42952 11.0126 6.71155 10.7197L10.5342 6.75001H0.722223C0.323354 6.75001 0 6.41424 0 6.00001C0 5.58578 0.323354 5.25001 0.722223 5.25001H10.5342L6.71155 1.28033C6.42952 0.987436 6.42952 0.512566 6.71155 0.219668Z"
                                  fill="#E8F5FF" />
                            </svg>
                        </button>
                    </div>
                </div>
                <!-- Header END -->

                <!-- Banner Start -->
                <div class="container-fluid p-0 position-relative">
                    <img src="./vendor/assets/images/banner.png" alt="Hospital Banner"
                         class="img-fluid user-select-none non-selectable-img">
                    <a href="#about-us" role="button" class="position-absolute bottom-0 start-50 translate-middle mb-3">
                        <img src="./vendor/assets/images/down-aerrow.gif" alt="down button" style="width: 40px">
                    </a>
                </div>
                <!-- Banner END -->
            </div>

            <!-- About Us Start -->
            <div id="about-us" class="bg-white d-flex flex-column gap-5 pb-5">
                <div class="container col-11">
                    <div class="w-100 mx-auto text-center pt-5">
                        <h1 class="h3">Your Health, One Tap Away</h1>
                        <p class="h5 col-12 col-md-8 mx-auto pt-2 text-dark fw-light">
                            Book appointments with Pantai Medical Centre's specialists in under 60 seconds — 24/7, from
                            anywhere.
                        </p>
                    </div>
                </div>

                <div class="container col-11">
                    <div class="row align-items-center justify-content-center gap-5">

                        <!-- LEFT CONTENT -->
                        <div class="col-12 col-lg-6">
                            <h2 class="h5 mb-2 fw-bold">About Us</h2>
                            <p class="text-justify text-dark fs-6">
                                Pantai Medical Centre is part of the IHH Healthcare network, one of Asia’s largest and most
                                awarded private healthcare groups. With over 50 years of excellence, we combine
                                international standards with genuine Malaysian warmth.
                            </p>
                            <div class="row">
                                <svg class="col-1 pe-0" width="28" height="21" viewBox="0 0 33 26" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M14.0846 1.85386L12.8872 0C4.60256 5.60755 0 12.4209 0 18.0284C0 23.4506 3.95894 26 7.31844 26C11.5528 26 14.5441 22.3842 14.5441 18.5846C14.5441 15.387 12.519 12.6522 9.80309 11.6319C9.02102 11.353 8.28461 11.1217 8.28461 9.77799C8.28461 8.06354 9.52767 5.5156 14.0846 1.85386ZM32.3564 1.85386L31.159 0C22.9657 5.60755 18.2718 12.4209 18.2718 18.0284C18.2718 23.4506 22.3221 26 25.6816 26C29.9616 26 33 22.3842 33 18.5846C33 15.387 30.9292 12.6522 28.1205 11.6319C27.3385 11.353 26.6477 11.1217 26.6477 9.77799C26.6477 8.06354 27.9364 5.51412 32.3549 1.85238L32.3564 1.85386Z"
                                    fill="#3A57E8" />
                                </svg>
                                <div class="col-11 mt-4">
                                    <p class="mb-1 text-justify">At Pantai Medical Centre, we don’t just treat illness — we
                                        care for lives with compassion and clinical excellence.</p>
                                    <h2 class="fs-6 text-end text-primary">Dato’ Dr. Amiruddin Hisan Group<br>Chief
                                        Executive Officer</h2>
                                </div>
                            </div>
                        </div>

                        <!-- RIGHT IMAGE -->
                        <div class="col-12 col-md-8 col-lg-2 p-0 text-center d-flex">
                            <img src="./vendor/assets/images/index_img.png" alt="CEO Image"
                                 class="img-fluid w-100 h-md-100 object-fit-cover non-selectable-img">
                        </div>

                    </div>
                </div>

            </div>
            <!-- About Us END -->

            <div class="bg-white py-3"></div>

            <!-- Our Services Start -->
            <div id="services" class="d-flex flex-column gap-5 bg-primary">
                <div class="container col-11">
                    <div class="w-100 mx-auto text-center pt-5">
                        <h1 class="h3 text-white">We Offer</h1>
                        <p class="h5 col-12 col-md-8 mx-auto pt-2 fw-light text-white">
                            What to expect from our services!
                        </p>
                    </div>
                </div>

                <div class="container col-11">
                    <div class="px-5 overflow-hidden slider-circle-btn app-slider">
                        <ul class="p-0 m-0 swiper-wrapper list-inline">
                            <li class="swiper-slide overflow-hidden">
                                <div class="col">
                                    <div class="card services-box py-5 rounded-1">
                                        <div class="card-body p-0">
                                            <h5 class="mb-3 ">200+ Consultants</h5>
                                            <p class="mb-3">Across 40+ specialties & subspecialties. <br>&nbsp;</p>
                                            <svg width="12" class="text-primary" height="13" viewBox="0 0 12 13" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M5.45109 0.343108L5.46396 1.36387L10.0063 1.42104L0.0568434 11.3704L0.787737 12.1013L10.7371 2.15194L10.7943 6.6942L11.8151 6.70706L11.736 0.422159L5.45109 0.343108Z"
                                                fill="currentColor" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="swiper-slide overflow-hidden">
                                <div class="col">
                                    <div class="card services-box py-5 rounded-1">
                                        <div class="card-body p-0">
                                            <h5 class="mb-3">Centres of Excellence</h5>
                                            <p>Cardiology, Oncology, Orthopaedic, Neurology, Fertility, Women & Children.
                                            </p>
                                            <svg class="text-primary" width="12" height="13" viewBox="0 0 12 13" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M5.45109 0.343108L5.46396 1.36387L10.0063 1.42104L0.0568434 11.3704L0.787737 12.1013L10.7371 2.15194L10.7943 6.6942L11.8151 6.70706L11.736 0.422159L5.45109 0.343108Z"
                                                fill="currentColor" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="swiper-slide overflow-hidden">
                                <div class="col">
                                    <div class="card services-box py-5 rounded-1">
                                        <div class="card-body p-0">
                                            <h5 class="mb-3">JCI and MSQH accreditation</h5>
                                            <p>Your guarantee of world-class safety and quality. </p>
                                            <svg class="text-primary" width="12" height="13" viewBox="0 0 12 13" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M5.45109 0.343108L5.46396 1.36387L10.0063 1.42104L0.0568434 11.3704L0.787737 12.1013L10.7371 2.15194L10.7943 6.6942L11.8151 6.70706L11.736 0.422159L5.45109 0.343108Z"
                                                fill="currentColor" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="swiper-slide overflow-hidden">
                                <div class="col">
                                    <div class="card services-box py-5 rounded-1">
                                        <div class="card-body p-0">
                                            <h5 class="mb-3 ">Cutting Edge Technology</h5>
                                            <p class="mb-3">da Vinci Robotic Surgery, PET-CT, 3T MRI, TomoTherapy</p>
                                            <svg width="12" class="text-primary" height="13" viewBox="0 0 12 13" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M5.45109 0.343108L5.46396 1.36387L10.0063 1.42104L0.0568434 11.3704L0.787737 12.1013L10.7371 2.15194L10.7943 6.6942L11.8151 6.70706L11.736 0.422159L5.45109 0.343108Z"
                                                fill="currentColor" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="swiper-slide overflow-hidden">
                                <div class="col">
                                    <div class="card services-box py-5 rounded-1">
                                        <div class="card-body p-0">
                                            <h5 class="mb-3 ">24-Hour Emergency</h5>
                                            <p class="mb-3">Comprehensive Emergency & Trauma services available around the clock</p>
                                            <svg width="12" class="text-primary" height="13" viewBox="0 0 12 13" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M5.45109 0.343108L5.46396 1.36387L10.0063 1.42104L0.0568434 11.3704L0.787737 12.1013L10.7371 2.15194L10.7943 6.6942L11.8151 6.70706L11.736 0.422159L5.45109 0.343108Z"
                                                fill="currentColor" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="swiper-slide overflow-hidden">
                                <div class="col">
                                    <div class="card services-box py-5 rounded-1">
                                        <div class="card-body p-0">
                                            <h5 class="mb-3 ">Online Appointment System</h5>
                                            <p class="mb-3">Use our online system and skip the phone queues</p>
                                            <svg width="12" class="text-primary" height="13" viewBox="0 0 12 13" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path
                                                d="M5.45109 0.343108L5.46396 1.36387L10.0063 1.42104L0.0568434 11.3704L0.787737 12.1013L10.7371 2.15194L10.7943 6.6942L11.8151 6.70706L11.736 0.422159L5.45109 0.343108Z"
                                                fill="currentColor" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <div class="swiper-button swiper-button-next"></div>
                        <div class="swiper-button swiper-button-prev"></div>
                    </div>
                </div>
            </div>
            <!-- Our Services END -->

            <div class="bg-white py-3"></div>

            <!-- Book Appointment Start -->
            <div id="book-appointment" class="bg-white d-flex justify-content-center">
                <div class="container row">
                    <div class="col text-start pt-5">
                        <h1 class="h3 text-primary">Ready to Book your Appointment?</h1>
                        <p class="h5 pt-2 text-dark fw-light">
                            Create your account and start booking your first appointment in less than 1 minute!
                        </p>
                    </div>
                    <div class="col text-start pt-5">
                        <img src="./vendor/assets/images/index_img2.png" alt="Patient UI" class="img col-6">
                    </div>
                </div>
            </div>
            <!-- Book Appointment END -->

            <%@ include file="views/partials/scripts.jsp" %>
        </main>

    </body>

</html>
