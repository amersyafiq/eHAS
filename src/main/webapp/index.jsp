<%-- 
    Document   : index
    Created on : Dec 16, 2025, 11:16:50 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Home" />

    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">        
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
                            <img src="${pageContext.request.contextPath}/vendor/assets/images/logo.png" alt="Taman Medical Centre Logo" class="h-100">
                        </a>

                        <nav class="d-none d-lg-flex gap-4">
                            <a class="text-reset" href="#about-us">About Uss</a>
                            <a class="text-reset" href="#services">Our Services</a>
                            <a class="text-reset" href="#book-appointment">Book Appointment</a>
                            <a class="text-reset" href="#contact-us">Contact Us</a>
                        </nav>

                        <button 
                            onclick="location.href='${pageContext.request.contextPath}/login'"
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
                    <img src="${pageContext.request.contextPath}/vendor/assets/images/banner.png" alt="Hospital Banner"
                         class="img-fluid user-select-none non-selectable-img">
                    <a href="#about-us" role="button" class="position-absolute bottom-0 start-50 translate-middle mb-3">
                        <img src="${pageContext.request.contextPath}/vendor/assets/images/down-aerrow.gif" alt="down button" style="width: 40px">
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
                            <img src="${pageContext.request.contextPath}/vendor/assets/images/index_img.png" alt="CEO Image"
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
            <div id="book-appointment" class="bg-white">
                <div class="container">
                    <div class="row">
                        <div class="col-12 col-lg-6 text-start pt-5 px-5">
                            <h1 class="h3 text-primary">Ready to Book your Appointment?</h1>
                            <p class="h5 pt-2 text-dark fw-light">
                                Create your account and start booking your first appointment in less than 1 minute!
                            </p>
                            <button
                                class="btn btn-primary mt-4"
                                onClick="location.href='${pageContext.request.contextPath}/appointment/book'"
                            >
                                Book Appointment
                            </button>
                        </div>
                        <div class="col-12 col-lg-6 text-start pt-5 d-flex justify-content-center">
                            <img src="${pageContext.request.contextPath}/vendor/assets/images/index_img2.png" alt="Patient UI" class="img col-10 shadow-lg">
                        </div>
                    </div>
                </div>
            </div>
            <!-- Book Appointment END -->

            <footer id="contact-us">
                <div class="bg-secondary inner-box p-5">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="${pageContext.request.contextPath}/" class="navbar-brand  d-flex align-items-center">
                                    <svg width="40" height="50" viewBox="0 0 40 50" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M19.934 28.5253C19.513 30.2641 19.0557 30.6437 18.4808 29.7322C18.0824 29.1004 17.6523 27.1275 17.6523 25.9319C17.6523 24.8795 16.9347 23.8658 16.19 23.8658C15.769 23.8658 15.5788 24.0976 15.2076 25.0591C14.9541 25.716 14.6847 26.5342 14.61 26.882C14.4357 27.6843 13.8245 28.4048 13.442 28.2571C12.6045 27.9343 12.978 23.9772 14.1075 21.1815C15.2891 18.2653 17.0434 16.1083 20.8507 12.8989C25.9053 8.6349 26.7338 7.84847 27.3925 6.69155C28.1554 5.35279 28.7371 3.614 28.7416 2.66392C28.7462 1.65473 29.3234 1.66155 30.3126 2.68437C31.3448 3.75265 31.7454 4.43453 31.8065 5.23233C31.8654 5.9733 32.7482 7.71436 33.1421 7.86665C33.3096 7.93257 33.4024 8.15986 33.3458 8.37351C33.1715 9.04175 34.1946 12.458 34.6541 12.7444C34.9552 12.9307 35.2178 19.7745 34.9326 19.9655C34.636 20.1655 33.9366 22.7339 33.9909 23.4294C34.0384 24.0454 32.9474 26.6888 32.3543 27.3888C32.1438 27.6389 31.931 27.9457 31.8812 28.0707C31.5598 28.8912 30.6725 30.0027 30.3375 30.0027C30.1179 30.0027 29.6471 29.5822 29.2939 29.0708C28.9386 28.5571 28.4111 28.0457 28.1191 27.9343C27.3291 27.632 26.3105 28.2389 26.0751 29.1526C25.808 30.1914 25.1244 30.2823 25.1176 29.2799C25.1176 28.8662 24.9682 27.9116 24.7871 27.1615C24.606 26.4115 24.4566 24.8636 24.4521 23.7226C24.4431 21.3974 24.6875 20.5951 25.9936 18.6676C27.5283 16.397 28.6352 14.3581 28.9748 13.1648C29.2645 12.1557 28.9205 12.367 28.0535 13.7354C27.517 14.5854 27.0779 15.015 26.6501 15.1173C26.2992 15.2014 26.0276 15.4196 26.0276 15.6196C26.0276 15.8128 25.6156 16.422 25.1131 16.9697C24.6083 17.5198 24.2529 18.0607 24.3231 18.1744C24.3933 18.2858 24.3457 18.4449 24.2167 18.5244C23.5037 18.9676 21.274 23.3158 21.274 24.2658C21.274 24.4386 21.1246 24.7295 20.9435 24.9114C20.7625 25.0955 20.5474 25.625 20.4659 26.0887C20.3867 26.5547 20.1468 27.6502 19.934 28.5253ZM26.1453 47.2838C26.6003 47.7884 26.4305 47.8247 25.5137 47.4156C25.1674 47.2611 24.9478 47.0724 25.0271 46.9951C25.104 46.9179 24.9433 46.911 24.6717 46.9838C24.2642 47.0906 23.7119 46.6451 21.6272 44.5245C20.226 43.1016 18.938 41.6674 18.7614 41.3378C18.5871 41.0105 18.0529 40.1468 17.5708 39.4217C17.0909 38.6944 16.5884 37.8398 16.4526 37.5193C16.3168 37.1965 16.0859 36.7829 15.941 36.5942C15.4475 35.9646 14.7096 33.6326 14.7096 32.7075C14.7096 31.2915 15.3525 29.5481 15.8731 29.5481C16.1719 29.5481 16.3462 29.7572 16.4413 30.23C16.516 30.605 16.654 30.9119 16.7468 30.9119C16.9438 30.9119 17.2403 32.9439 17.2086 34.094C17.1814 35.0622 17.6296 37.0488 17.8741 37.0488C17.9714 37.0488 18.105 37.2533 18.1706 37.5011C18.5441 38.933 20.3505 37.5238 20.3618 35.7941C20.3686 34.9418 20.7692 33.203 21.6475 30.23C22.2904 28.0503 22.7476 27.9503 23.1121 29.9141C23.223 30.5118 23.4267 31.071 23.5625 31.1551C23.721 31.2528 23.8047 32.2211 23.7911 33.8235C23.773 35.9532 23.687 36.526 23.2298 37.567C22.7657 38.6194 22.7046 39.0421 22.802 40.4809C22.8721 41.4901 23.0962 42.5152 23.3611 43.0471C23.6055 43.5312 23.8409 44.2199 23.8862 44.5745C23.9813 45.3313 24.8143 46.5383 25.3598 46.7133C25.5703 46.7792 25.9235 47.036 26.1453 47.2838ZM27.8656 32.9416C27.6189 33.0757 27.3133 33.1848 27.1865 33.1848C26.7972 33.1848 26.6818 32.7666 27.019 32.5734C27.1979 32.4734 27.3767 32.1347 27.4197 31.8211C27.4876 31.3369 27.5985 31.2642 28.178 31.3324C28.5515 31.3778 31.3018 31.4597 34.2897 31.5142C37.2776 31.571 39.8151 31.7097 39.9283 31.8233C40.0505 31.9461 40.0143 32.1734 39.8378 32.387C39.582 32.6961 38.7761 32.7416 33.9298 32.7234C30.3488 32.7075 28.1531 32.7893 27.8656 32.9416ZM11.5406 32.0483C11.3097 32.4825 11.0675 32.5029 6.38184 32.5029C1.70752 32.5029 1.44947 32.4802 1.18011 32.0483C0.901684 31.5983 0.953746 31.5938 6.3411 31.5938C11.7126 31.5938 11.7805 31.6006 11.5406 32.0483ZM19.1938 31.1528C19.1395 31.3165 18.9606 31.496 18.7977 31.5506C18.6279 31.6074 18.5441 31.5233 18.6007 31.3528C18.6551 31.1892 18.8339 31.0096 18.9969 30.9551C19.1666 30.8982 19.2504 30.9823 19.1938 31.1528Z" fill="white"/>
                                        <path d="M14.4312 27.4047C14.3225 27.7502 14.2161 28.0911 14.1211 28.4116C13.7657 29.6004 13.3039 31.03 13.0957 31.5937L12.7176 32.6165L6.86625 32.6802C3.64742 32.7165 0.786237 32.687 0.505551 32.6188C-0.0852467 32.4733 -0.187108 31.7142 0.353891 31.5051C0.550824 31.4278 3.28751 31.3664 6.43617 31.3664H12.1585L12.5275 30.3936C12.7539 29.8004 12.8987 28.7412 12.8987 27.6843C12.8987 26.1182 13.0889 24.6113 13.4692 23.1771C12.8716 25.5636 12.7923 28.007 13.442 28.2571C13.7363 28.3707 14.1686 27.9661 14.4312 27.4047ZM11.5406 32.0483C11.7805 31.6005 11.7126 31.5937 6.3411 31.5937C0.953743 31.5937 0.901681 31.5983 1.1801 32.0483C1.44947 32.4802 1.70752 32.5029 6.38184 32.5029C11.0675 32.5029 11.3097 32.4824 11.5406 32.0483ZM22.8721 41.1673C22.8427 40.9423 22.8178 40.7104 22.802 40.4809C22.7046 39.0421 22.7657 38.6193 23.2298 37.567C23.687 36.526 23.773 35.9532 23.7911 33.8235C23.8047 32.221 23.721 31.2528 23.5625 31.155C23.4267 31.0709 23.223 30.5118 23.1121 29.914C22.7476 27.9502 22.2904 28.0502 21.6475 30.23C20.7692 33.203 20.3686 34.9417 20.3618 35.7941C20.3573 36.6328 19.9294 37.3965 19.4473 37.7965C19.6488 37.4942 19.8299 36.9987 19.9996 36.2941C20.1852 35.5213 20.5021 34.3258 20.7013 33.6394C20.9005 32.9529 21.1586 31.8256 21.2763 31.1391C21.5502 29.5231 22.4013 25.6977 22.6118 25.1341C22.7114 24.8681 22.9695 26.1523 23.275 28.4298C24.0424 34.1394 24.2348 35.3077 24.4793 35.7668C24.649 36.0873 24.5947 36.3032 24.2484 36.676C23.395 37.5852 22.8676 39.1171 22.8676 40.6854C22.8653 40.8627 22.8676 41.0218 22.8721 41.1673ZM26.1453 47.2837C25.9234 47.036 25.5703 46.7792 25.3598 46.7132C24.8143 46.5382 23.9813 45.3313 23.8862 44.5744C23.8409 44.2198 23.6055 43.5311 23.3611 43.047C23.3248 42.972 23.2886 42.8902 23.2547 42.7993C23.3792 43.0675 23.5421 43.372 23.7549 43.7539C24.8324 45.6722 26.0728 47.0428 28.1825 48.6361C29.0517 49.293 29.8055 49.8703 29.8576 49.9181C29.9096 49.9658 29.8078 50.0022 29.6312 49.9999C29.1038 49.9908 26.7723 48.9634 25.4322 48.1497C23.5512 47.0087 20.9684 44.4039 19.2436 41.9605C19.7778 42.5879 20.6764 43.5584 21.6271 44.5244C23.7119 46.6451 24.2642 47.0905 24.6717 46.9837C24.9433 46.911 25.104 46.9178 25.0271 46.9951C24.9478 47.0724 25.1674 47.261 25.5137 47.4156C26.4305 47.8247 26.6003 47.7883 26.1453 47.2837ZM19.934 28.5253C20.1468 27.6502 20.3867 26.5546 20.4659 26.0887C20.5474 25.625 20.7625 25.0954 20.9435 24.9113C21.1246 24.7295 21.274 24.4385 21.274 24.2658C21.274 23.8908 21.6204 22.9884 22.0844 22.0065C21.48 23.5112 20.9843 25.5318 20.226 28.923C19.6193 31.6414 19.0648 33.8666 18.9901 33.8666C18.9176 33.8666 18.6822 32.7665 18.4694 31.4232C18.0167 28.5866 17.229 24.8136 16.9845 24.3203C16.8894 24.134 16.559 23.9476 16.2466 23.9112C16.104 23.893 15.9931 23.893 15.898 23.9226C15.984 23.8817 16.0791 23.8658 16.19 23.8658C16.9347 23.8658 17.6523 24.8795 17.6523 25.9318C17.6523 27.1274 18.0824 29.1003 18.4808 29.7322C19.0557 30.6436 19.5129 30.2641 19.934 28.5253ZM28.3183 4.62996C28.3998 4.15037 28.4043 3.53895 28.4043 2.4434C28.4043 1.1001 28.4609 0 28.5266 0C28.7303 0 30.3488 2.21383 31.4172 3.94808C32.7437 6.10509 33.8551 8.96671 34.6541 12.2738C34.7537 12.6852 34.8284 13.3353 34.8805 14.1149C34.8148 13.3421 34.7356 12.7943 34.6541 12.7443C34.1946 12.4579 33.1715 9.04171 33.3458 8.37347C33.4024 8.15982 33.3096 7.93252 33.142 7.86661C32.7482 7.71432 31.8654 5.97326 31.8065 5.23228C31.7454 4.43449 31.3448 3.75261 30.3126 2.68433C29.3234 1.66151 28.7462 1.65469 28.7416 2.66387C28.7394 3.16164 28.5786 3.87307 28.3183 4.62996ZM25.5726 19.3063C24.6332 20.8064 24.4431 21.6724 24.4521 23.7226C24.4566 24.8636 24.606 26.4114 24.7871 27.1615C24.9682 27.9116 25.1176 28.8662 25.1176 29.2799C25.1244 30.2822 25.808 30.1913 26.0751 29.1526C26.3105 28.2389 27.3291 27.632 28.1191 27.9343C28.1576 27.9502 28.2029 27.9729 28.2504 28.0025C27.4966 27.632 26.8832 28.4798 26.0276 30.7641C25.7152 31.5937 25.4006 32.2733 25.3259 32.2733C25.2489 32.2756 25.1199 31.5846 25.0361 30.7414C24.8709 29.0571 24.6174 27.0138 24.2212 24.1749C23.927 22.0656 24.0243 21.6451 25.5726 19.3063ZM16.9121 31.271C16.8555 31.0482 16.7966 30.9118 16.7468 30.9118C16.654 30.9118 16.5159 30.605 16.4413 30.23C16.3462 29.7572 16.1719 29.5481 15.8731 29.5481C15.3525 29.5481 14.7096 31.2914 14.7096 32.7074C14.7096 33.3689 15.0876 34.7485 15.4815 35.7123C15.477 35.7032 15.4724 35.6941 15.4656 35.685C15.1442 35.1213 14.7096 34.203 14.5014 33.6394C14.1279 32.637 14.1324 32.5847 14.7096 31.0255C15.0333 30.1504 15.434 28.948 15.5992 28.3548C15.7644 27.7616 15.975 27.2752 16.0678 27.2752C16.2466 27.2752 16.353 27.7797 16.8736 31.0255C16.8872 31.1073 16.8985 31.1891 16.9121 31.271ZM27.8656 32.9416C27.9448 32.9006 28.1644 32.8643 28.513 32.8347L27.3857 33.9803C26.7089 34.6667 26.0819 35.2304 25.9914 35.2304C25.9008 35.2304 26.1136 34.4372 26.4622 33.4689C27.3857 30.9187 27.7909 30.0004 27.9969 30.0118C28.0965 30.0163 28.384 30.3482 28.6352 30.7505L29.0291 31.3778C28.5854 31.3619 28.2844 31.346 28.178 31.3323C27.5985 31.2641 27.4876 31.3369 27.4197 31.821C27.3767 32.1347 27.1979 32.4733 27.019 32.5733C26.6818 32.7665 26.7972 33.1848 27.1865 33.1848C27.3133 33.1848 27.6189 33.0757 27.8656 32.9416ZM23.1732 19.9381C23.5942 19.2222 23.9858 18.6676 24.2167 18.5244C24.3457 18.4448 24.3933 18.2857 24.3231 18.1743C24.2529 18.0607 24.6083 17.5197 25.1131 16.9697C25.6156 16.4219 26.0276 15.8128 26.0276 15.6196C26.0276 15.4196 26.2992 15.2013 26.6501 15.1173C26.9466 15.0468 27.2477 14.8195 27.5849 14.4013C26.9104 15.3991 25.7808 16.8492 25.0316 17.6698C24.2529 18.5244 23.6599 19.2199 23.1732 19.9381ZM34.8941 20.0018C34.8307 21.0791 34.7311 21.9588 34.593 22.3884C34.3214 23.2362 33.8551 24.3976 33.4046 25.3954C33.7487 24.5635 34.0158 23.7385 33.9909 23.4294C33.9388 22.7611 34.5794 20.37 34.8941 20.0018ZM18.6867 38.0852C18.4559 38.0511 18.2657 37.8693 18.1706 37.5011C18.105 37.2533 17.9714 37.0487 17.8741 37.0487C17.6296 37.0487 17.1814 35.0622 17.2086 34.0939C17.2199 33.6257 17.1792 33.0098 17.1135 32.4461C17.6636 35.5463 18.2612 37.8215 18.6007 38.0375C18.6301 38.0557 18.6596 38.0716 18.6867 38.0852ZM19.1938 31.1528C19.2504 30.9823 19.1666 30.8982 18.9968 30.955C18.8339 31.0096 18.655 31.1891 18.6007 31.3528C18.5441 31.5233 18.6279 31.6074 18.7977 31.5505C18.9606 31.496 19.1395 31.3164 19.1938 31.1528ZM16.2443 17.4652C17.272 16.0855 18.4943 14.8854 20.8507 12.8989C18.7931 14.6331 17.3354 16.0605 16.2443 17.4652ZM16.0383 36.7351C16.1764 36.9487 16.3462 37.2624 16.4526 37.5192C16.5884 37.8397 17.0909 38.6943 17.5708 39.4217C17.6636 39.5581 17.7564 39.7013 17.8492 39.8444C17.7541 39.7013 17.6568 39.5558 17.5617 39.408C17.0751 38.6739 16.5363 37.7647 16.3643 37.3897C16.2919 37.2283 16.1741 36.9942 16.0383 36.7351ZM15.4407 24.5044C15.3751 24.6499 15.3049 24.8295 15.2234 25.0477C15.0831 25.4159 14.8681 26.0478 14.644 26.741C14.7481 26.3455 14.9835 25.6386 15.2076 25.059C15.2936 24.8386 15.3683 24.6545 15.4407 24.5044ZM34.0837 32.7302H31.4262C32.1597 32.7211 32.9972 32.7188 33.9298 32.7234C34.7356 32.7256 35.4283 32.7279 36.0259 32.7256C35.4668 32.7279 34.8239 32.7302 34.0837 32.7302ZM28.3047 13.3512C28.7303 12.717 28.9861 12.4488 29.0563 12.5579C28.9838 12.4829 28.7416 12.7398 28.3047 13.3512ZM27.8724 15.6241C27.4265 16.4356 26.8742 17.3424 26.2404 18.2971C26.9081 17.272 27.4468 16.3878 27.8724 15.6241ZM26.435 7.96662C26.9353 7.42793 27.2069 7.01653 27.5102 6.48239C27.4717 6.55286 27.4333 6.62332 27.3925 6.6915C27.1571 7.10518 26.9013 7.47112 26.435 7.96662ZM39.9215 31.8165C39.9238 31.8187 39.926 31.821 39.9283 31.8233C39.8649 31.7596 39.0681 31.6915 37.8639 31.6301C39.0591 31.6824 39.8559 31.7505 39.9215 31.8165ZM29.0449 28.7435C29.1332 28.848 29.217 28.9594 29.2939 29.0708C29.3211 29.1117 29.3505 29.1526 29.3822 29.1935C29.3279 29.123 29.2736 29.0526 29.2215 28.9798C29.1604 28.8957 29.1015 28.8162 29.0449 28.7435ZM30.3397 30.0027C30.5367 29.9981 30.9192 29.6208 31.2655 29.1458C30.9192 29.6231 30.5367 30.0027 30.3442 30.0027C30.3442 30.0027 30.342 30.0027 30.3397 30.0027ZM32.3815 27.357C32.3724 27.3683 32.3634 27.3797 32.3543 27.3888C32.1959 27.5774 32.0374 27.7957 31.9469 27.9457C32.0374 27.7957 32.1959 27.5752 32.3543 27.3888C32.3634 27.3774 32.3724 27.3683 32.3815 27.357Z" fill="white"/>
                                    </svg>
                                    <h4 class="logo-title ms-3 text-white col-6 text-wrap">Taman Medical Centre</h4>
                                </a>
                                <p class="mb-4 mt-4">
                                    Pantai Medical Centre is part of the IHH Healthcare network, one of Asia’s largest and most awarded private healthcare groups. 
                                </p>
                                <div class="d-flex align-items-center pt-2 mb-3">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M1 6V22L8 18L16 22L23 18V2L16 6L8 2L1 6Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                        <path d="M16 6V22" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                        <path d="M8 2V18" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                    <p class="ms-4 mb-0 text-white">No. 8, Jalan Bukit Pantai, Taman Bukit Pantai, 59100 Kuala Lumpur</p>
                                </div>
                                <div class="d-flex align-items-center">
                                    <svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M21 15.9201V18.9201C21.0011 19.1986 20.9441 19.4743 20.8325 19.7294C20.7209 19.9846 20.5573 20.2137 20.3521 20.402C20.1468 20.5902 19.9046 20.7336 19.6407 20.8228C19.3769 20.912 19.0974 20.9452 18.82 20.9201C15.7428 20.5857 12.787 19.5342 10.19 17.8501C7.77382 16.3148 5.72533 14.2663 4.18999 11.8501C2.49997 9.2413 1.44824 6.27109 1.11999 3.1801C1.095 2.90356 1.12787 2.62486 1.21649 2.36172C1.30512 2.09859 1.44756 1.85679 1.63476 1.65172C1.82196 1.44665 2.0498 1.28281 2.30379 1.17062C2.55777 1.05843 2.83233 1.00036 3.10999 1.0001H6.10999C6.5953 0.995321 7.06579 1.16718 7.43376 1.48363C7.80173 1.80008 8.04207 2.23954 8.10999 2.7201C8.23662 3.68016 8.47144 4.62282 8.80999 5.5301C8.94454 5.88802 8.97366 6.27701 8.8939 6.65098C8.81415 7.02494 8.62886 7.36821 8.35999 7.6401L7.08999 8.9101C8.51355 11.4136 10.5864 13.4865 13.09 14.9101L14.36 13.6401C14.6319 13.3712 14.9751 13.1859 15.3491 13.1062C15.7231 13.0264 16.1121 13.0556 16.47 13.1901C17.3773 13.5286 18.3199 13.7635 19.28 13.8901C19.7658 13.9586 20.2094 14.2033 20.5265 14.5776C20.8437 14.9519 21.0122 15.4297 21 15.9201Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                    <p class="ms-4 mb-0 text-white">(808) 555-0111</p>
                                </div>
                            </div>
                            <div class="col-md-2 mt-md-0 mt-4">
                                <h5 class="mb-4 text-white">Links</h5>
                                <ul class="m-0 p-0 list-unstyled text-white">
                                    <li class="mb-3">
                                        <svg class="me-2 text-primary" width="7" height="8" viewBox="0 0 7 8" fill="none">
                                            <circle cx="3.5" cy="4" r="3.5" fill="currentColor" />
                                        </svg>About us
                                    </li>
                                    <li class="mb-3">
                                        <svg class="me-2 text-primary" width="7" height="8" viewBox="0 0 7 8" fill="none">
                                            <circle cx="3.5" cy="4" r="3.5" fill="currentColor" />
                                        </svg>Our Services
                                    </li>
                                    <li class="mb-3">
                                        <svg class="me-2 text-primary" width="7" height="8" viewBox="0 0 7 8" fill="none">
                                            <circle cx="3.5" cy="4" r="3.5" fill="currentColor" />
                                        </svg>Book Appointment
                                    </li>
                                    <li>
                                        <svg class="me-2 text-primary" width="7" height="8" viewBox="0 0 7 8" fill="none">
                                            <circle cx="3.5" cy="4" r="3.5" fill="currentColor" />
                                        </svg>Contact Us
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-2 mt-md-0 mt-4">
                                <h5 class="mb-4 text-white">Help</h5>
                                <ul class="m-0 p-0 list-unstyled text-white">
                                    <li class="mb-3">
                                        <svg class="me-2 text-primary" width="7" height="8" viewBox="0 0 7 8" fill="none">
                                            <circle cx="3.5" cy="4" r="3.5" fill="currentColor" />
                                        </svg>My Account
                                    </li>
                                    <li class="mb-3">
                                        <svg class="me-2 text-primary" width="7" height="8" viewBox="0 0 7 8" fill="none">
                                            <circle cx="3.5" cy="4" r="3.5" fill="currentColor" />
                                        </svg>Privacy Policy
                                    </li>
                                    <li class="mb-3">
                                        <svg class="me-2 text-primary" width="7" height="8" viewBox="0 0 7 8" fill="none">
                                            <circle cx="3.5" cy="4" r="3.5" fill="currentColor" />
                                        </svg>Payment Policy
                                    </li>
                                    <li>
                                        <svg class="me-2 text-primary" width="7" height="8" viewBox="0 0 7 8" fill="none">
                                            <circle cx="3.5" cy="4" r="3.5" fill="currentColor" />
                                        </svg>FAQ
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-md-0 mt-4">
                                <h5 class="mb-4 text-white">Newsletter</h5>
                                <div class="input-group mb-4">
                                    <input type="text" class="form-control input-email ps-0"
                                        placeholder="firstname.lastname@mail.com" aria-label="email"
                                        aria-describedby="basic-addon1">
                                    <span class="input-group-text input-email-btn" id="basic-addon1">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                            fill="none">
                                            <path
                                                d="M10.0522 6C10.3204 6 10.59 6.10376 10.795 6.31127L15.6911 11.2433C15.8891 11.4437 16 11.7152 16 11.9995C16 12.2823 15.8891 12.5538 15.6911 12.7542L10.795 17.6891C10.3836 18.1041 9.71803 18.1041 9.30662 17.6862C8.89662 17.2684 8.89803 16.5932 9.30943 16.1782L13.4558 11.9995L9.30943 7.82073C8.89803 7.4057 8.89662 6.73199 9.30662 6.31412C9.51162 6.10376 9.78262 6 10.0522 6"
                                                fill="#EBEEFD" />
                                        </svg>
                                    </span>
                                </div>
                                <h5 class="pt-2 text-white">Social</h5>
                                <ul class="list-unstyled p-0 m-0 d-flex mt-4 social-icon">
                                    <li>
                                        <a href="#">
                                            <svg width="30" height="30" viewBox="0 0 30 30" fill="none">
                                                <path d="M27.5 15C27.5 8.1 21.9 2.5 15 2.5C8.1 2.5 2.5 8.1 2.5 15C2.5 21.05 6.8 26.0875 12.5 27.25V18.75H10V15H12.5V11.875C12.5 9.4625 14.4625 7.5 16.875 7.5H20V11.25H17.5C16.8125 11.25 16.25 11.8125 16.25 12.5V15H20V18.75H16.25V27.4375C22.5625 26.8125 27.5 21.4875 27.5 15Z" fill="white" />
                                            </svg>
                                        </a>
                                    </li>
                                    <li class="ps-3">
                                        <a href="#">
                                            <svg width="30" height="30" viewBox="0 0 30 30" fill="none">
                                                <path d="M16.285 2.50105C17.1972 2.49755 18.1093 2.50672 19.0212 2.52855L19.2637 2.5373C19.5437 2.5473 19.82 2.5598 20.1537 2.5748C21.4837 2.6373 22.3912 2.8473 23.1875 3.15605C24.0125 3.47355 24.7075 3.90355 25.4025 4.59855C26.038 5.22306 26.5298 5.97848 26.8437 6.8123C27.1525 7.60855 27.3625 8.5173 27.425 9.8473C27.44 10.1798 27.4525 10.4573 27.4625 10.7373L27.47 10.9798C27.4922 11.8913 27.5018 12.803 27.4987 13.7148L27.5 14.6473V16.2848C27.5031 17.197 27.4935 18.1091 27.4712 19.0211L27.4637 19.2636C27.4537 19.5436 27.4412 19.8198 27.4262 20.1536C27.3637 21.4836 27.1512 22.3911 26.8437 23.1873C26.5308 24.022 26.0389 24.7781 25.4025 25.4023C24.7774 26.0377 24.0216 26.5295 23.1875 26.8436C22.3912 27.1523 21.4837 27.3623 20.1537 27.4248C19.82 27.4398 19.5437 27.4523 19.2637 27.4623L19.0212 27.4698C18.1093 27.492 17.1972 27.5016 16.285 27.4986L15.3525 27.4998H13.7162C12.8041 27.5029 11.8919 27.4933 10.98 27.4711L10.7375 27.4636C10.4408 27.4528 10.1441 27.4403 9.84749 27.4261C8.51749 27.3636 7.60999 27.1511 6.81249 26.8436C5.97834 26.5302 5.22279 26.0383 4.59874 25.4023C3.96255 24.7777 3.47027 24.0218 3.15624 23.1873C2.84749 22.3911 2.63749 21.4836 2.57499 20.1536C2.56107 19.8569 2.54857 19.5603 2.53749 19.2636L2.53124 19.0211C2.50819 18.1092 2.49778 17.197 2.49999 16.2848V13.7148C2.4965 12.8031 2.50567 11.8913 2.52749 10.9798L2.53624 10.7373C2.54624 10.4573 2.55874 10.1798 2.57374 9.8473C2.63624 8.51605 2.84624 7.6098 3.15499 6.8123C3.4692 5.97808 3.96244 5.22286 4.59999 4.5998C5.22361 3.96324 5.97869 3.47052 6.81249 3.15605C7.60999 2.8473 8.51624 2.6373 9.84749 2.5748L10.7375 2.5373L10.98 2.53105C11.8915 2.50802 12.8032 2.4976 13.715 2.4998L16.285 2.50105ZM15 8.75105C14.1719 8.73934 13.3497 8.89233 12.5812 9.20114C11.8127 9.50994 11.1133 9.9684 10.5235 10.5499C9.93379 11.1313 9.46549 11.8242 9.14585 12.5883C8.82621 13.3523 8.6616 14.1722 8.6616 15.0004C8.6616 15.8286 8.82621 16.6486 9.14585 17.4126C9.46549 18.1766 9.93379 18.8695 10.5235 19.451C11.1133 20.0325 11.8127 20.4909 12.5812 20.7997C13.3497 21.1085 14.1719 21.2615 15 21.2498C16.6576 21.2498 18.2473 20.5913 19.4194 19.4192C20.5915 18.2471 21.25 16.6574 21.25 14.9998C21.25 13.3422 20.5915 11.7525 19.4194 10.5804C18.2473 9.40828 16.6576 8.75105 15 8.75105ZM15 11.2511C15.4981 11.2419 15.9931 11.332 16.456 11.5163C16.9189 11.7006 17.3404 11.9752 17.696 12.3242C18.0515 12.6732 18.334 13.0896 18.5268 13.549C18.7196 14.0084 18.819 14.5016 18.8191 14.9998C18.8192 15.498 18.72 15.9912 18.5273 16.4507C18.3346 16.9102 18.0523 17.3266 17.6969 17.6757C17.3414 18.0248 16.92 18.2996 16.4571 18.4841C15.9943 18.6685 15.4994 18.7588 15.0012 18.7498C14.0067 18.7498 13.0528 18.3547 12.3496 17.6515C11.6463 16.9482 11.2512 15.9944 11.2512 14.9998C11.2512 14.0052 11.6463 13.0514 12.3496 12.3482C13.0528 11.6449 14.0067 11.2498 15.0012 11.2498L15 11.2511ZM21.5625 6.87605C21.1592 6.89219 20.7779 7.06374 20.4982 7.35476C20.2186 7.64579 20.0625 8.03372 20.0625 8.4373C20.0625 8.84088 20.2186 9.22881 20.4982 9.51984C20.7779 9.81086 21.1592 9.98241 21.5625 9.99855C21.9769 9.99855 22.3743 9.83393 22.6673 9.54091C22.9604 9.24788 23.125 8.85045 23.125 8.43605C23.125 8.02165 22.9604 7.62422 22.6673 7.3312C22.3743 7.03817 21.9769 6.87355 21.5625 6.87355V6.87605Z" fill="white" />
                                            </svg>
                                        </a>
                                    </li>
                                    <li class="ps-3">
                                        <a href="#">
                                            <svg width="30" height="30" viewBox="0 0 30 30" fill="none">
                                                <path d="M23.75 3.75C24.413 3.75 25.0489 4.01339 25.5178 4.48223C25.9866 4.95107 26.25 5.58696 26.25 6.25V23.75C26.25 24.413 25.9866 25.0489 25.5178 25.5178C25.0489 25.9866 24.413 26.25 23.75 26.25H6.25C5.58696 26.25 4.95107 25.9866 4.48223 25.5178C4.01339 25.0489 3.75 24.413 3.75 23.75V6.25C3.75 5.58696 4.01339 4.95107 4.48223 4.48223C4.95107 4.01339 5.58696 3.75 6.25 3.75H23.75ZM23.125 23.125V16.5C23.125 15.4192 22.6957 14.3828 21.9315 13.6185C21.1672 12.8543 20.1308 12.425 19.05 12.425C17.9875 12.425 16.75 13.075 16.15 14.05V12.6625H12.6625V23.125H16.15V16.9625C16.15 16 16.925 15.2125 17.8875 15.2125C18.3516 15.2125 18.7967 15.3969 19.1249 15.7251C19.4531 16.0533 19.6375 16.4984 19.6375 16.9625V23.125H23.125ZM8.6 10.7C9.15695 10.7 9.6911 10.4788 10.0849 10.0849C10.4788 9.6911 10.7 9.15695 10.7 8.6C10.7 7.4375 9.7625 6.4875 8.6 6.4875C8.03973 6.4875 7.50241 6.71007 7.10624 7.10624C6.71007 7.50241 6.4875 8.03973 6.4875 8.6C6.4875 9.7625 7.4375 10.7 8.6 10.7ZM10.3375 23.125V12.6625H6.875V23.125H10.3375Z" fill="white" />
                                            </svg>
                                        </a>
                                    </li>
                                    <li class="ps-3">
                                        <a href="#">
                                            <svg width="30" height="30" viewBox="0 0 30 30" fill="none">
                                                <path d="M28.075 7.5C27.1125 7.9375 26.075 8.225 25 8.3625C26.1 7.7 26.95 6.65 27.35 5.3875C26.3125 6.0125 25.1625 6.45 23.95 6.7C22.9625 5.625 21.575 5 20 5C17.0625 5 14.6625 7.4 14.6625 10.3625C14.6625 10.7875 14.7125 11.2 14.8 11.5875C10.35 11.3625 6.38749 9.225 3.74999 5.9875C3.28749 6.775 3.02499 7.7 3.02499 8.675C3.02499 10.5375 3.96249 12.1875 5.41249 13.125C4.52499 13.125 3.69999 12.875 2.97499 12.5V12.5375C2.97499 15.1375 4.82499 17.3125 7.27499 17.8C6.4884 18.0153 5.66261 18.0452 4.86249 17.8875C5.202 18.9531 5.86691 19.8855 6.76376 20.5537C7.66061 21.2218 8.7443 21.5921 9.86249 21.6125C7.96702 23.1131 5.61748 23.9241 3.19999 23.9125C2.77499 23.9125 2.34999 23.8875 1.92499 23.8375C4.29999 25.3625 7.12499 26.25 10.15 26.25C20 26.25 25.4125 18.075 25.4125 10.9875C25.4125 10.75 25.4125 10.525 25.4 10.2875C26.45 9.5375 27.35 8.5875 28.075 7.5Z" fill="white" />
                                            </svg>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                      </div>
                  </div>
                </div>
                <div class="footer-bottom bg-secondary ">
                    <div class="container py-4 footer-border">
                        <div class="row">
                            <div class="col-md-12 text-center text-white">
                                <p class="mb-0">©
                                    <script>document.write(new Date().getFullYear())</script> Taman Medical Centre, All Rights Reserved.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>

            <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        </main>

    </body>

</html>
