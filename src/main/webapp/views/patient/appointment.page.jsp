<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Appointment Page" />

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
        
        <%-- Get Appointment Details --%>
        <sql:query var="appointment" dataSource="${myDatasource}">
            SELECT 
                A.APPOINTMENTID, A.STATUS, A.CONCERN, A.PATIENTID, A.DOCTORID, A.TIMESLOTID, A.DIAGNOSIS, A.TREATMENT, A.NOTES, A.CONSULTATIONFEE, A.TREATMENTFEE, A.TOTALAMOUNT, A.CREATEDAT,
                P.MEDICALRECORDNO, P.BLOODGROUP, P.ALLERGY,
                PA.FULLNAME AS PATIENT_NAME, PA.EMAIL AS PATIENT_EMAIL, PA.PHONENO AS PATIENT_PHONE, PA.GENDER AS PATIENT_GENDER, PA.DATEOFBIRTH AS PATIENT_DOB, PA.PICTUREPATH AS PATIENT_PICTURE,
                DA.FULLNAME AS DOCTOR_NAME, DA.PICTUREPATH AS DOCTOR_PICTURE,
                D.LICENSENO, S.SPECIALITYNAME,
                DS.SCHEDULEDATE, T.STARTTIME, T.ENDTIME
            FROM APPOINTMENT A
            LEFT JOIN PATIENT P ON A.PATIENTID = P.ACCOUNTID
            LEFT JOIN ACCOUNT PA ON P.ACCOUNTID = PA.ACCOUNTID
            LEFT JOIN DOCTOR D ON A.DOCTORID = D.ACCOUNTID
            LEFT JOIN ACCOUNT DA ON D.ACCOUNTID = DA.ACCOUNTID
            LEFT JOIN SPECIALITY S ON D.SPECIALITYID = S.SPECIALITYID
            LEFT JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID
            LEFT JOIN DOCTORSCHEDULE DS ON T.SCHEDULEID = DS.SCHEDULEID
            WHERE A.APPOINTMENTID = ?::Integer
            <sql:param value="${param.id}" />
        </sql:query>
        
        <c:if test="${appointment.rowCount == 0}">
            <c:redirect url="${pageContext.request.contextPath}/appointment">
                <c:param name="error" value="Appointment not found" />
            </c:redirect>
        </c:if>
        
        <c:set var="appt" value="${appointment.rows[0]}" />
        
        <main class="main-content">
            <div class="position-relative iq-banner">

                <!--Header Start-->
                <%@ include file="/WEB-INF/jspf/header.jspf" %>
                <%-- Header END --%>
            
                <%-- Main Section Start --%>
                <div class="container-fluid content-inner p-3">
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
                                            <li class="breadcrumb-item">
                                                <a href="${pageContext.request.contextPath}/appointment">My Appointments</a>
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

                    <div class="row">
                        <div class="col-md-8 pe-md-2">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <h5 class="card-title mb-3" style="font-size: 1.1rem;">Patient Information</h5>
                                            <div class="row px-4 g-2 mb-2">
                                                <div class="col-md-6 d-flex gap-3">
                                                    <img src="${appt.patient_picture}" alt="Patient Profile" class="theme-color-default-img img-fluid avatar avatar-50 avatar-rounded border border-3 border-light">
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Full Name</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">${appt.patient_name}</p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="25" height="25" viewBox="0 0 502 502" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M251 20.9167C205.494 20.9167 161.01 34.4108 123.173 59.6927C85.336 84.9746 55.8456 120.909 38.4311 162.951C21.0167 204.993 16.4603 251.255 25.3381 295.887C34.2159 340.519 56.1292 381.516 88.3069 413.693C120.485 445.871 161.482 467.785 206.113 476.662C250.745 485.54 297.007 480.984 339.05 463.569C381.092 446.155 417.026 416.664 442.308 378.827C467.59 340.99 481.084 296.506 481.084 251C481.012 190 456.748 131.519 413.614 88.386C370.481 45.2526 312 20.9886 251 20.9167ZM251 439.25C213.768 439.25 177.372 428.209 146.414 407.524C115.457 386.839 91.3283 357.438 77.0801 323.04C62.8319 288.642 59.1039 250.791 66.3676 214.274C73.6313 177.757 91.5603 144.214 117.888 117.887C144.215 91.5599 177.758 73.6308 214.275 66.3672C250.792 59.1035 288.642 62.8315 323.041 77.0797C357.439 91.3279 386.839 115.456 407.525 146.414C428.21 177.371 439.25 213.768 439.25 251C439.19 300.908 419.337 348.755 384.046 384.046C348.756 419.336 300.909 439.189 251 439.25ZM285.868 216.132H355.584V285.868H285.868V355.583H216.132V285.868H146.417V216.132H216.132V146.417H285.868V216.132Z" fill="#3a57e8"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Medical Record No.</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">${appt.medicalrecordno}</p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="23" height="23" viewBox="0 0 667 667" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M33.333 116.691C33.333 402.037 264.653 633.357 550 633.357C562.873 633.357 575.636 632.887 588.276 631.96C602.78 630.897 610.03 630.367 616.633 626.567C622.1 623.421 627.283 617.841 630.023 612.157C633.333 605.297 633.333 597.294 633.333 581.29V487.381C633.333 473.921 633.333 467.191 631.116 461.424C629.163 456.327 625.983 451.79 621.863 448.21C617.2 444.157 610.873 441.857 598.226 437.257L491.333 398.387C476.616 393.037 469.256 390.36 462.276 390.814C456.12 391.214 450.196 393.317 445.163 396.884C439.456 400.927 435.43 407.641 427.373 421.071L400 466.691C311.67 426.687 240.063 354.987 200 266.691L245.621 239.318C259.048 231.262 265.762 227.233 269.806 221.526C273.373 216.493 275.476 210.569 275.876 204.414C276.33 197.433 273.653 190.075 268.303 175.359L229.433 68.4642C224.833 55.8159 222.533 49.4915 218.48 44.8272C214.9 40.7069 210.363 37.5289 205.267 35.5722C199.498 33.3572 192.769 33.3572 179.31 33.3572H85.4C69.3957 33.3572 61.3933 33.3572 54.5323 36.6655C48.8497 39.4059 43.271 44.5909 40.123 50.0582C36.3223 56.6595 35.7913 63.9112 34.7293 78.4149C33.804 91.0525 33.333 103.817 33.333 116.691Z" stroke="#3a57e8" stroke-width="66.6667" stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Contact Number</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">${appt.patient_phone}</p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="25" height="25" viewBox="0 0 203 174" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M198.945 47.2872L104.781 0.764904C103.76 0.261717 102.638 0 101.5 0C100.362 0 99.2398 0.261717 98.2194 0.764904L4.07812 47.2872C2.86076 47.8795 1.83354 48.8008 1.11279 49.9468C0.392047 51.0928 0.00656474 52.4177 0 53.7715V166.749C0.00533913 167.707 0.199363 168.654 0.570985 169.537C0.942607 170.42 1.48454 171.221 2.16583 171.894C2.84711 172.567 3.65438 173.1 4.54152 173.461C5.42866 173.822 6.37827 174.005 7.33609 173.999H195.664C196.622 174.005 197.571 173.822 198.458 173.461C199.346 173.1 200.153 172.567 200.834 171.894C201.515 171.221 202.057 170.42 202.429 169.537C202.801 168.654 202.995 167.707 203 166.749V53.7715C202.996 52.4201 202.613 51.0969 201.897 49.9511C201.18 48.8054 200.158 47.8827 198.945 47.2872ZM101.5 15.3555L179.891 54.0705L100.277 93.3927L21.8859 54.6777L101.5 15.3555Z" fill="#3a57e8"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Email Address</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">${appt.patient_email}</p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="23" height="23" viewBox="0 0 23 23" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M8.21429 0L6.57143 0.383333V1.53333H8.21429V0ZM8.21429 1.53333V3.06667H6.57143V1.53333H6.56157C4.49321 1.5548 2.98014 1.48733 1.74471 2.12213C1.127 2.44107 0.635786 2.9808 0.364714 3.65393C0.0952857 4.32553 0 5.12593 0 6.13333V18.4C0 19.4074 0.0952857 20.2063 0.364714 20.8794C0.635786 21.5525 1.127 22.0877 1.74471 22.4066C2.98179 23.0429 4.49486 22.977 6.56157 23H16.4384C18.5051 22.977 20.0166 23.0429 21.2536 22.4066C21.8937 22.0678 22.3822 21.5259 22.6304 20.8794C22.9014 20.2063 23 19.3614 23 18.4V6.13333C23 5.1244 22.9014 4.32553 22.6304 3.65393C22.3816 3.00696 21.8933 2.46425 21.2536 2.12367C20.0166 1.4858 18.5051 1.55633 16.4384 1.53333H16.4286V3.06667H14.7857V1.53333H8.21429ZM14.7857 1.53333H16.4286V0L14.7857 0.383333V1.53333ZM6.58129 7.66667H16.4286C18.4986 7.68813 19.8572 7.75867 20.4585 8.06687C20.7591 8.22327 20.9333 8.39347 21.0926 8.79213C21.2536 9.1908 21.3555 10.7333 21.3555 10.7333V18.4C21.3555 19.3077 21.2536 19.941 21.0926 20.3397C20.9333 20.7383 20.7591 20.9101 20.4585 21.0649C19.8572 21.3747 18.4969 21.4437 16.4286 21.4667H6.57143C4.50143 21.4437 3.14279 21.3747 2.53986 21.0649C2.23921 20.9101 2.06507 20.7383 1.90571 20.3397C1.74471 19.941 1.64286 19.3077 1.64286 18.4V10.7333C1.64286 9.82407 1.74471 9.1908 1.90571 8.79213C2.06507 8.39347 2.23921 8.22327 2.53986 8.06687C3.14279 7.75713 4.50471 7.68813 6.58129 7.66667Z" fill="#3a57e8"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Date of Birth</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">${appt.patient_dob}</p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="25" height="25" viewBox="0 0 182 224" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M126.438 0V20.4531H146.375L129.129 37.6942C122.246 29.6596 113.705 23.2105 104.092 18.79C94.4804 14.3695 84.0252 12.0824 73.4453 12.0859C32.9481 12.0859 0 45.0341 0 85.5312C0 122.561 27.5466 153.268 63.2188 158.261V175.711H39.9766V196.164H63.2188V223.125H83.6719V196.164H106.914V175.711H83.6719V158.261C119.344 153.268 146.891 122.561 146.891 85.5312C146.895 75.1218 144.677 64.8315 140.383 55.3489L160.836 34.8958V54.8516H181.289V0H126.438ZM73.4453 138.523C62.9644 138.523 52.719 135.416 44.0044 129.593C35.2899 123.77 28.4978 115.494 24.4869 105.81C20.4761 96.1274 19.4266 85.4725 21.4714 75.193C23.5161 64.9135 28.5631 55.4712 35.9742 48.0601C43.3853 40.649 52.8276 35.602 63.1071 33.5573C73.3865 31.5126 84.0415 32.562 93.7245 36.5729C103.408 40.5837 111.684 47.3758 117.507 56.0904C123.33 64.8049 126.438 75.0504 126.438 85.5312C126.422 99.5807 120.833 113.05 110.899 122.985C100.964 132.919 87.4948 138.507 73.4453 138.523Z" fill="#3a57e8"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Gender</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">${appt.patient_gender}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <div class="row mb-3">
                                                <h5 class="col-md-6 card-title" style="font-size: 1.1rem;">Appointment Information</h5>
                                                <div class="col-md-6 d-flex justify-content-end gap-4 align-items-center">
                                                    <fmt:formatDate value="${appt.SCHEDULEDATE}" pattern="yyyyMMdd" var="datePart"/>
                                                    <fmt:formatDate value="${appt.STARTTIME}" pattern="HHmmss" var="startTimePart"/>
                                                    <fmt:formatDate value="${appt.ENDTIME}" pattern="HHmmss" var="endTimePart"/>
                                                    <c:set var="startFormatted" value="${datePart}T${startTimePart}"/>
                                                    <c:set var="endFormatted" value="${datePart}T${endTimePart}"/>
                                                    <c:set var="icsPeriod" value="${startFormatted}/${endFormatted}" />
                                                    <c:set var="encodedIcsPeriod" value="${startFormatted}%2F${endFormatted}" />
                                                    <a 
                                                        href="https://calendar.google.com/calendar/render?action=TEMPLATE&dates=${encodedIcsPeriod}&text=Appointment%20with%20${appt.DOCTOR_NAME}&details=Concern:%20${appt.CONCERN}"
                                                        target="_blank" class="d-flex align-items-center gap-2"
                                                    >
                                                        <svg width="13" height="13" viewBox="0 0 13 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <g clip-path="url(#clip0_333_687)">
                                                                <path d="M6.49989 1.44446C3.71552 1.44446 1.44434 3.85524 1.44434 6.80955C1.44434 8.40529 2.10774 9.84154 3.15594 10.8259L2.44421 11.5971C2.29988 11.7535 2.22002 11.9644 2.22218 12.1833C2.22433 12.4022 2.30834 12.6112 2.45571 12.7643C2.60309 12.9175 2.80176 13.0023 3.00803 13C3.21429 12.9977 3.41125 12.9085 3.55558 12.7521L4.49609 11.7329C5.11113 12.0165 5.78855 12.1746 6.49989 12.1746C7.21123 12.1746 7.88866 12.0165 8.50369 11.7329L9.44421 12.7521C9.58853 12.9085 9.78549 12.9977 9.99175 13C10.198 13.0023 10.3967 12.9175 10.5441 12.7643C10.6914 12.6112 10.7754 12.4022 10.7776 12.1833C10.7798 11.9644 10.6999 11.7535 10.5556 11.5971L9.84384 10.8259C10.892 9.84154 11.5554 8.40529 11.5554 6.80955C11.5554 3.85524 9.28426 1.44446 6.49989 1.44446ZM6.49989 2.87472C8.55494 2.87472 10.2069 4.62767 10.2069 6.80955C10.2069 8.99143 8.55494 10.7444 6.49989 10.7444C4.44484 10.7444 2.79288 8.99143 2.79288 6.80955C2.79288 4.62767 4.44484 2.87472 6.49989 2.87472Z" fill="#3A57E8"/>
                                                                <path d="M6.49957 5.77777C6.10754 5.77777 5.77734 6.10796 5.77734 6.49999C5.77734 6.89202 6.10754 7.22222 6.49957 7.22222C6.89159 7.22222 7.22179 6.89202 7.22179 6.49999C7.22179 6.10796 6.89159 5.77777 6.49957 5.77777Z" fill="#3A57E8"/>
                                                                <path d="M2.34761 2.25373e-05C2.2759 -0.000645155 2.20478 0.0135291 2.13829 0.041736C1.23431 0.425395 0.494357 1.14267 0.0578051 2.05844C0.0256948 2.12579 0.00652791 2.19913 0.00139871 2.27426C-0.0037305 2.34939 0.00527847 2.42485 0.0279112 2.49633C0.050544 2.56781 0.0863573 2.6339 0.133306 2.69084C0.180256 2.74778 0.237421 2.79444 0.301539 2.82817C0.365659 2.8619 0.435475 2.88204 0.507002 2.88742C0.578529 2.89281 0.650365 2.88334 0.718409 2.85956C0.786453 2.83578 0.849372 2.79816 0.903573 2.74884C0.957775 2.69952 1.0022 2.63946 1.0343 2.57211C1.3519 1.90587 1.88974 1.38457 2.5474 1.10545C2.61389 1.07723 2.67443 1.03553 2.72558 0.982728C2.77673 0.929929 2.81747 0.867064 2.84549 0.797723C2.8735 0.728382 2.88825 0.653923 2.88887 0.578598C2.88949 0.503272 2.87598 0.428556 2.84912 0.358714C2.80866 0.253532 2.73942 0.163314 2.65015 0.0994681C2.56088 0.035622 2.4556 0.00101485 2.34761 2.25373e-05Z" fill="#3A57E8"/>
                                                                <path d="M10.6524 2.25373e-05C10.7241 -0.000645155 10.7952 0.0135291 10.8617 0.041736C11.7657 0.425395 12.5056 1.14267 12.9422 2.05844C12.9743 2.12579 12.9935 2.19913 12.9986 2.27426C13.0037 2.34939 12.9947 2.42485 12.9721 2.49633C12.9495 2.56781 12.9136 2.6339 12.8667 2.69084C12.8197 2.74778 12.7626 2.79444 12.6985 2.82817C12.6343 2.8619 12.5645 2.88204 12.493 2.88742C12.4215 2.89281 12.3496 2.88334 12.2816 2.85956C12.2135 2.83578 12.1506 2.79816 12.0964 2.74884C12.0422 2.69952 11.9978 2.63946 11.9657 2.57211C11.6481 1.90587 11.1103 1.38457 10.4526 1.10545C10.3861 1.07723 10.3256 1.03553 10.2744 0.982728C10.2233 0.929929 10.1825 0.867064 10.1545 0.797723C10.1265 0.728382 10.1118 0.653923 10.1111 0.578597C10.1105 0.503272 10.124 0.428556 10.1509 0.358714C10.1913 0.253532 10.2606 0.163314 10.3498 0.0994681C10.4391 0.035622 10.5444 0.00101485 10.6524 2.25373e-05Z" fill="#3A57E8"/>
                                                                <path d="M6.49957 2.88892C6.30802 2.88892 6.12432 2.96586 5.98888 3.10282C5.85343 3.23979 5.77734 3.42555 5.77734 3.61924V5.04748C5.77734 5.24117 5.85343 5.42693 5.98888 5.5639C6.12432 5.70086 6.30802 5.7778 6.49957 5.7778C6.69111 5.7778 6.87481 5.70086 7.01025 5.5639C7.1457 5.42693 7.22179 5.24117 7.22179 5.04748V3.61924C7.22179 3.42555 7.1457 3.23979 7.01025 3.10282C6.87481 2.96586 6.69111 2.88892 6.49957 2.88892Z" fill="#3A57E8"/>
                                                                <path d="M7.74176 7.22709C7.61795 7.20278 7.49398 7.27027 7.39713 7.4147C7.30027 7.55913 7.23846 7.76867 7.22529 7.99722C7.21212 8.22578 7.24867 8.45464 7.3269 8.63346L7.83247 9.78901C7.9107 9.96782 8.0242 10.0819 8.148 10.1063C8.27181 10.1306 8.39577 10.0631 8.49263 9.91868C8.58948 9.77425 8.65129 9.56471 8.66446 9.33615C8.67764 9.10759 8.64109 8.87874 8.56286 8.69992L8.05729 7.54436C7.97906 7.36554 7.86556 7.25142 7.74176 7.22709Z" fill="#3A57E8"/>
                                                            </g>
                                                            <defs>
                                                                <clipPath id="clip0_333_687">
                                                                <rect width="13" height="13" fill="white"/>
                                                                </clipPath>
                                                            </defs>
                                                        </svg>
                                                        <small>Add to Google Calendar</small>
                                                    </a>
                                                    <span class="badge px-3 py-2 fw-normal
                                                        <c:choose>
                                                            <c:when test="${appt.status == 'PENDING'}">bg-primary bg-opacity-25 text-primary</c:when>
                                                            <c:when test="${appt.status == 'CONFIRMED'}">bg-primary text-white</c:when>
                                                            <c:when test="${appt.status == 'COMPLETED'}">bg-secondary text-white</c:when>
                                                            <c:when test="${appt.status == 'CANCELLED'}">bg-danger text-white</c:when>
                                                            <c:otherwise>bg-dark text-white</c:otherwise>
                                                        </c:choose>">
                                                        ${appt.status}
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="row px-4 g-2 mb-2">
                                                <div class="col-md-6 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="23" height="23" viewBox="0 0 23 23" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M8.21429 0L6.57143 0.383333V1.53333H8.21429V0ZM8.21429 1.53333V3.06667H6.57143V1.53333H6.56157C4.49321 1.5548 2.98014 1.48733 1.74471 2.12213C1.127 2.44107 0.635786 2.9808 0.364714 3.65393C0.0952857 4.32553 0 5.12593 0 6.13333V18.4C0 19.4074 0.0952857 20.2063 0.364714 20.8794C0.635786 21.5525 1.127 22.0877 1.74471 22.4066C2.98179 23.0429 4.49486 22.977 6.56157 23H16.4384C18.5051 22.977 20.0166 23.0429 21.2536 22.4066C21.8937 22.0678 22.3822 21.5259 22.6304 20.8794C22.9014 20.2063 23 19.3614 23 18.4V6.13333C23 5.1244 22.9014 4.32553 22.6304 3.65393C22.3816 3.00696 21.8933 2.46425 21.2536 2.12367C20.0166 1.4858 18.5051 1.55633 16.4384 1.53333H16.4286V3.06667H14.7857V1.53333H8.21429ZM14.7857 1.53333H16.4286V0L14.7857 0.383333V1.53333ZM6.58129 7.66667H16.4286C18.4986 7.68813 19.8572 7.75867 20.4585 8.06687C20.7591 8.22327 20.9333 8.39347 21.0926 8.79213C21.2536 9.1908 21.3555 10.7333 21.3555 10.7333V18.4C21.3555 19.3077 21.2536 19.941 21.0926 20.3397C20.9333 20.7383 20.7591 20.9101 20.4585 21.0649C19.8572 21.3747 18.4969 21.4437 16.4286 21.4667H6.57143C4.50143 21.4437 3.14279 21.3747 2.53986 21.0649C2.23921 20.9101 2.06507 20.7383 1.90571 20.3397C1.74471 19.941 1.64286 19.3077 1.64286 18.4V10.7333C1.64286 9.82407 1.74471 9.1908 1.90571 8.79213C2.06507 8.39347 2.23921 8.22327 2.53986 8.06687C3.14279 7.75713 4.50471 7.68813 6.58129 7.66667Z" fill="#3a57e8"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Appointment Date</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">
                                                            <fmt:formatDate value="${appt.scheduledate}" pattern="EEEE, MMMM d, yyyy" />
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="23" height="23" viewBox="0 0 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M17.25 33.5C8.27537 33.5 1 26.2246 1 17.25C1 8.27537 8.27537 1 17.25 1C26.2246 1 33.5 8.27537 33.5 17.25C33.5 26.2246 26.2246 33.5 17.25 33.5Z" stroke="#3A57E8" stroke-width="2"/>
                                                            <path d="M17.25 10.75V17.25L13.1875 21.3125" stroke="#3A57E8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Appointment Time</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">
                                                            <fmt:formatDate value="${appt.starttime}" pattern="hh:mm a" type="time" /> 
                                                            -
                                                            <fmt:formatDate value="${appt.endtime}" pattern="hh:mm a" type="time" />
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 d-flex gap-3">
                                                    <img src="${appt.doctor_picture}" alt="Doctor Profile" class="theme-color-default-img img-fluid avatar avatar-50 avatar-rounded border border-3 border-light">
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Doctor Name</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">${appt.doctor_name}</p>
                                                        <p class="m-0 text-dark fw-lighter">${appt.specialityname}</p>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="25" height="25" viewBox="0 0 28 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M14 1C10.5522 1 7.24558 2.32117 4.80761 4.67288C2.36964 7.02459 1 10.2142 1 13.54C1 13.8277 1 14.1154 1 14.3862V14.4538C1.52632 21.3246 7.4386 26.85 14 34C20.8509 26.5369 27 20.8846 27 13.54C27 10.2142 25.6304 7.02459 23.1924 4.67288C20.7544 2.32117 17.4478 1 14 1ZM14 7.51538C15.2374 7.51539 16.4469 7.86943 17.4757 8.53273C18.5044 9.19603 19.306 10.1388 19.7791 11.2417C20.2523 12.3446 20.3756 13.558 20.1336 14.7286C19.8915 15.8991 19.295 16.9741 18.4194 17.8175C17.5438 18.6609 16.4286 19.2348 15.2148 19.4666C14.001 19.6985 12.7432 19.5778 11.6005 19.1199C10.4578 18.6619 9.48159 17.8873 8.7954 16.8941C8.10922 15.9009 7.74388 14.7336 7.74561 13.54C7.74794 11.9414 8.40791 10.409 9.58058 9.27944C10.7533 8.14985 12.3428 7.51538 14 7.51538Z" stroke="#3A57E8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Address</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">Pantai Medical Centre, Kuala Lumpur </p>
                                                        <p class="m-0 text-dark fw-lighter lh-1 mt-1">No. 8, Jalan Bukit Pantai, Taman Bukit Pantai, 59100 Kuala Lumpur</p>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 d-flex gap-3">
                                                    <div style="background-color: #f3f3f3; height: fit-content;" class="rounded-2 p-3 d-flex justify-content-center align-items-center">
                                                        <svg width="25" height="25" viewBox="0 0 132 174" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M4.40892 174C2.01833 174 0 172.016 0 169.673V4.3964C0 1.972 1.9718 0 4.40892 0H89.9466C91.0983 0 92.2383 0.4872 93.1224 1.3688L130.633 38.8426C131.506 39.5966 132 40.7218 132 41.9456V169.667C132 172.016 129.982 174 127.591 174H4.40892ZM8.82366 165.277H123.246V46.3362H89.9408C87.5037 46.3362 85.526 44.3642 85.526 41.9456V8.7232H8.82366V165.277ZM94.3555 37.613H117.04L94.3555 14.9118V37.613Z" fill="#3A57E8"/>
                                                        </svg>
                                                    </div>
                                                    <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                        <p class="text-muted mb-1"><small>Concern</small></p>
                                                        <p class="m-0 text-dark fw-normal lh-1">${appt.concern}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 ps-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title mb-3" style="font-size: 1.1rem;">Actions</h5>
                                    <div class="row px-4 g-2">

                                        <c:if test="${appt.status == 'PENDING' || appt.status == 'CONFIRMED'}">
                                        <button data-appointment-id="${appt.appointmentID}" class="btn-cancel-appointment btn btn-danger col-12 d-flex flex-column align-items-center rounded-3 justify-content-center py-3 gap-2" >
                                            <svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M6.8397 14.988C6.0389 14.8447 4.8587 13.5407 5.3795 13.0447L8.5806 9.99733L5.3795 6.95C4.739 6.34 6.6598 4.51267 7.3003 5.122L10.5014 8.16933L13.7025 5.122C14.343 4.512 16.2631 6.34133 15.6233 6.95L12.4222 9.99733L15.6233 13.0447C16.2638 13.6547 14.343 15.482 13.7025 14.8727L10.5014 11.8253L7.3003 14.8727C7.1792 14.9867 7.0245 15.0213 6.8404 14.988H6.8397ZM10.5 20C4.7005 20 0 15.5227 0 10C0 4.47733 4.7005 0 10.5 0C16.2995 0 21 4.47733 21 10C21 15.5227 16.2995 20 10.5 20ZM10.5 17.5C14.8491 17.5 18.375 14.142 18.375 10C18.375 5.858 14.8491 2.5 10.5 2.5C6.1509 2.5 2.625 5.858 2.625 10C2.6257 14.142 6.1509 17.5 10.5 17.5Z" fill="white"/>
                                            </svg>
                                            Cancel Appointment
                                        </button>
                                        <button class="btn btn-primary col-12 d-flex flex-column align-items-center rounded-3 justify-content-center py-3 gap-2"
                                                data-bs-toggle="modal" data-bs-target="#rescheduleModal">
                                            <svg width="23" height="23" viewBox="0 0 23 23" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M8.21429 0L6.57143 0.383333V1.53333H8.21429V0ZM8.21429 1.53333V3.06667H6.57143V1.53333H6.56157C4.49321 1.5548 2.98014 1.48733 1.74471 2.12213C1.127 2.44107 0.635786 2.9808 0.364714 3.65393C0.0952857 4.32553 0 5.12593 0 6.13333V18.4C0 19.4074 0.0952857 20.2063 0.364714 20.8794C0.635786 21.5525 1.127 22.0877 1.74471 22.4066C2.98179 23.0429 4.49486 22.977 6.56157 23H16.4384C18.5051 22.977 20.0166 23.0429 21.2536 22.4066C21.8937 22.0678 22.3822 21.5259 22.6304 20.8794C22.9014 20.2063 23 19.3614 23 18.4V6.13333C23 5.1244 22.9014 4.32553 22.6304 3.65393C22.3816 3.00696 21.8933 2.46425 21.2536 2.12367C20.0166 1.4858 18.5051 1.55633 16.4384 1.53333H16.4286V3.06667H14.7857V1.53333H8.21429ZM14.7857 1.53333H16.4286V0L14.7857 0.383333V1.53333ZM6.58129 7.66667H16.4286C18.4986 7.68813 19.8572 7.75867 20.4585 8.06687C20.7591 8.22327 20.9333 8.39347 21.0926 8.79213C21.2536 9.1908 21.3555 10.7333 21.3555 10.7333V18.4C21.3555 19.3077 21.2536 19.941 21.0926 20.3397C20.9333 20.7383 20.7591 20.9101 20.4585 21.0649C19.8572 21.3747 18.4969 21.4437 16.4286 21.4667H6.57143C4.50143 21.4437 3.14279 21.3747 2.53986 21.0649C2.23921 20.9101 2.06507 20.7383 1.90571 20.3397C1.74471 19.941 1.64286 19.3077 1.64286 18.4V10.7333C1.64286 9.82407 1.74471 9.1908 1.90571 8.79213C2.06507 8.39347 2.23921 8.22327 2.53986 8.06687C3.14279 7.75713 4.50471 7.68813 6.58129 7.66667Z" fill="white"/>
                                            </svg>
                                            Reschedule Appointment
                                        </button>
                                        </c:if>
                                    <div class="w-100"><hr class="border border-1 border-light"></div>
                                    <button class="btn btn-outline-light col-12 rounded-3" 
                                            ${appt.status != 'COMPLETED' ? 'disabled' : ''}>    
                                        View Medical Report
                                    </button>
                                    <button class="btn btn-outline-light col-12 rounded-3" 
                                            ${appt.status != 'COMPLETED' ? 'disabled' : ''}>    
                                        View Invoice
                                    </button>
                                </div>
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

    <%-- Reschedule Modal --%>
    <div class="modal fade" id="rescheduleModal" tabindex="-1" aria-labelledby="rescheduleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="rescheduleModalLabel">Reschedule Appointment</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="rescheduleForm">
                        <input type="hidden" id="reschedule_appointmentID" value="${appt.appointmentID}">
                        <input type="hidden" id="reschedule_doctorID" value="${appt.doctorID}">
                        <input type="hidden" id="reschedule_scheduleID">
                        
                        <div class="mb-3">
                            <label for="reschedule_date" class="form-label text-dark"><small>New Date<small></label>
                            <input type="text" class="form-control" id="reschedule_date" placeholder="Select new date" readonly required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="reschedule_timeslot" class="form-label text-dark"><small>New Time Slot</small></label>
                            <select class="form-select" id="reschedule_timeslot" disabled required>
                                <option value="">-- Select Time Slot --</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary btn-reschedule-appointment">Confirm Reschedule</button>
                </div>
            </div>
        </div>
    </div>

    <%-- Error Toast Start --%>
    <c:if test="${not empty error}">
    <div id="errorToastContainer" style="position: fixed; bottom: 20px; right: 20px; z-index: 9999; max-width: 400px;">
        <div class="bg-danger text-white px-3 py-1">
            ${error}
        </div>
    </div>
    </c:if>
    <%-- Error Toast END --%>
    
    <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

    <script>
        $(document).ready(function() {
            var $rescheduleDateInput = $('#reschedule_date');
            var $rescheduleScheduleIDInput = $('#reschedule_scheduleID');
            var $rescheduleTimeslotSelect = $('#reschedule_timeslot');
            var $rescheduleDoctorIDInput = $('#reschedule_doctorID');
            var $rescheduleAppointmentIDInput = $('#reschedule_appointmentID');

            var availableDates = [];
            var dateScheduleMap = {};
            var flatpickrInstance = null;

            // Initialize Flatpickr (disabled initially)
            flatpickrInstance = flatpickr("#reschedule_date", {
                dateFormat: "Y-m-d",
                minDate: "today",
                disable: [
                    function(date) {
                        var dateString = formatDateForComparison(date);
                        return availableDates.indexOf(dateString) === -1;
                    }
                ],
                onDayCreate: function(dObj, dStr, fp, dayElem) {
                    var dateString = formatDateForComparison(dayElem.dateObj);
                    if (availableDates.indexOf(dateString) !== -1) {
                        dayElem.classList.add("available-date");
                    }
                },
                onChange: function(selectedDates, dateStr, instance) {
                    if (dateStr) {
                        var scheduleID = dateScheduleMap[dateStr];
                        if (scheduleID) {
                            $rescheduleScheduleIDInput.val(scheduleID);
                            loadRescheduleTimeslots(scheduleID);
                        }
                    }
                },
                onReady: function(selectedDates, dateStr, instance) {
                    instance.input.disabled = true;
                }
            });

            // Load available dates when modal opens
            $('#rescheduleModal').on('show.bs.modal', function() {
                var doctorID = $rescheduleDoctorIDInput.val();
                loadRescheduleDates(doctorID);
            });

            // Reset when modal closes
            $('#rescheduleModal').on('hidden.bs.modal', function() {
                resetDatePicker();
                resetSelect($rescheduleTimeslotSelect, '-- Select Time Slot --');
            });

            function loadRescheduleDates(doctorID) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/appointment/book/dates',
                    type: 'GET',
                    data: { doctorID: doctorID },
                    dataType: 'json',
                    success: function(response) {
                        availableDates = [];
                        dateScheduleMap = {};

                        if (response && response.length > 0) {
                            response.forEach(function(schedule) {
                                availableDates.push(schedule.scheduleDate);
                                dateScheduleMap[schedule.scheduleDate] = schedule.scheduleID;
                            });

                            flatpickrInstance.input.disabled = false;
                            flatpickrInstance.redraw();
                            $rescheduleDateInput.attr('placeholder', 'Click to select date');
                        } else {
                            $rescheduleDateInput.attr('placeholder', 'No dates available');
                        }
                    },
                    error: function() {
                        alert('Error loading available dates');
                    }
                });
            }

            function loadRescheduleTimeslots(scheduleID) {
                resetSelect($rescheduleTimeslotSelect, '-- Select Time Slot --');

                $.ajax({
                    url: '${pageContext.request.contextPath}/appointment/book/timeslots',
                    type: 'GET',
                    data: { scheduleID: scheduleID },
                    dataType: 'html',
                    success: function(htmlResponse) {
                        $rescheduleTimeslotSelect.html(htmlResponse);
                        $rescheduleTimeslotSelect.prop('disabled', false);
                    },
                    error: function() {
                        alert('Error loading time slots');
                    }
                });
            }

            $(document).on('click', '.btn-reschedule-appointment', function() {
                submitReschedule();
            });

            function submitReschedule() {
                var appointmentID = $rescheduleAppointmentIDInput.val();
                var timeslotID = $rescheduleTimeslotSelect.val();

                if (!timeslotID) {
                    alert('Please select a date and time slot');
                    return;
                }

                $.ajax({
                    url: '${pageContext.request.contextPath}/appointment/page/reschedule',
                    type: 'GET',
                    data: {
                        appointmentID: appointmentID,
                        timeslotID: timeslotID
                    },
                    success: function(response) {
                        if (response.success) {
                            window.location.reload();
                        } else {
                            alert(response.message || 'Failed to reschedule appointment');
                        }
                    },
                    error: function() {
                        alert('Error rescheduling appointment');
                    }
                });
            }

            $(document).on('click', '.btn-cancel-appointment', function() {
                var appointmentID = $(this).data('appointment-id');
                cancelAppointment(appointmentID);
            });

            function cancelAppointment(appointmentID) {
                if (!confirm('Are you sure you want to cancel this appointment?')) {
                    return;
                }

                $.ajax({
                    url: '${pageContext.request.contextPath}/appointment/page/cancel',
                    type: 'GET',
                    data: { appointmentID: appointmentID },
                    success: function(response) {
                        if (response.success) {
                            window.location.reload();
                        } else {
                            alert(response.message || 'Failed to cancel appointment');
                        }
                    },
                    error: function() {
                        alert('Error cancelling appointment');
                    }
                });
            }

            // Helper function to reset select dropdown
            function resetSelect($select, defaultText) {
                $select.html('<option value="">' + defaultText + '</option>');
                $select.prop('disabled', true);
            }

            // Helper function to reset datepicker
            function resetDatePicker() {
                availableDates = [];
                dateScheduleMap = {};
                flatpickrInstance.clear();
                $rescheduleScheduleIDInput.val('');
                flatpickrInstance.input.disabled = true;
                flatpickrInstance.redraw();
                $rescheduleDateInput.attr('placeholder', 'Select Date');
            }

            function formatDateForComparison(date) {
                var year = date.getFullYear();
                var month = String(date.getMonth() + 1).padStart(2, '0');
                var day = String(date.getDate()).padStart(2, '0');
                return year + '-' + month + '-' + day;
            }
        });
    </script>
    <style>
        /* Highlight available dates in Flatpickr */
        .flatpickr-day.available-date {
            background-color: #3a57e831 !important;
            border-color: #3a57e8 !important;
        }
        
        .flatpickr-day.available-date:hover {
            background-color: #3a57e8 !important;
            color: white !important;
        }
    </style>
</body>