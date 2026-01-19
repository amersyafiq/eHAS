<%-- 
    Document   : profile
    Created on : Jan 18, 2025
    Author     : SYAFIQ
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Profile" />   
    
    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
        <!-- loader Start -->
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body"></div>
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
                
                <%-- Get Current User Data --%>
                <sql:query var="userData" dataSource="${myDatasource}">
                    SELECT a.ACCOUNTID, a.FULLNAME, a.EMAIL, a.PHONENO, a.GENDER, 
                           a.DATEOFBIRTH, a.IC_PASSPORT, a.PICTUREPATH, a.ACCOUNTTYPE,
                           p.MEDICALRECORDNO, p.BLOODGROUP, p.ALLERGY
                    FROM ACCOUNT a
                    LEFT JOIN PATIENT p ON a.ACCOUNTID = p.ACCOUNTID
                    WHERE a.ACCOUNTID = ?
                    <sql:param value="${sessionScope.loggedUser.accountID}" />
                </sql:query>
                <c:set var="user" value="${userData.rows[0]}" />
                
                <%-- Calculate Age --%>
                <jsp:useBean id="today" class="java.util.Date" />
                <fmt:formatDate value="${user.dateofbirth}" pattern="yyyy" var="birthYear" />
                <fmt:formatDate value="${today}" pattern="yyyy" var="currentYear" />
                <c:set var="age" value="${currentYear - birthYear}" />
                
                <%-- Main Section Start --%> 
                <div class="container-fluid content-inner p-3">
                    <%-- Breadcrumb Start --%> 
                    <div class="col-12">
                        <div class="card py-3 px-5 mb-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item active" aria-current="page">Profile</li>
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
                        <%-- Profile Card --%>
                        <div class="col-lg-8 pe-md-2">
                            <div class="card mb-3">
                                <%-- Blue Header with Avatar --%>
                                <div class="card-body p-0">
                                    <div class="bg-primary position-relative" style="height: 180px; border-radius: 0.5rem 0.5rem 0 0;">
                                        <div class="position-absolute" style="bottom: -60px; left: 50%; transform: translateX(-50%);">
                                            <img src="${user.picturepath}" 
                                                 onerror="this.onerror=null; this.src='https://placehold.co/150x150?text=No+Image';" 
                                                 alt="Profile Picture" 
                                                 class="rounded-circle border border-5 border-white bg-white"
                                                 style="width: 120px; height: 120px; object-fit: cover;">
                                        </div>
                                    </div>
                                    
                                    <%-- Profile Information --%>
                                    <div class="px-4 pb-4" style="margin-top: 80px;">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="text-muted small mb-1">Full Name</label>
                                                <div class="fw-semibold">${user.fullname}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="text-muted small mb-1">Role</label>
                                                <div class="fw-semibold">${user.accounttype}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="text-muted small mb-1">Birth Date</label>
                                                <div class="fw-semibold">
                                                    <fmt:formatDate value="${user.dateofbirth}" pattern="dd MMMM yyyy"/> (${age})
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="text-muted small mb-1">Email Address</label>
                                                <div class="fw-semibold">${user.email}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="text-muted small mb-1">IC or Passport Number</label>
                                                <div class="fw-semibold">${user.ic_passport}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="text-muted small mb-1">Phone Number</label>
                                                <div class="fw-semibold">${user.phoneno}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="text-muted small mb-1">Gender</label>
                                                <div class="fw-semibold">${user.gender}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="text-muted small mb-1">Blood Group</label>
                                                <div class="fw-semibold">${not empty user.bloodgroup ? user.bloodgroup : 'Not specified'}</div>
                                            </div>
                                            <div class="col-12">
                                                <label class="text-muted small mb-1">Medical Record Number</label>
                                                <div class="fw-semibold">${user.medicalrecordno}</div>
                                            </div>
                                            <div class="col-12">
                                                <label class="text-muted small mb-1">Allergies</label>
                                                <div class="fw-semibold">${not empty user.allergy ? user.allergy : 'None'}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- Edit and Change Password Cards --%>
                        <div class="col-lg-4 ps-md-2">
                            <%-- Edit Personal Information Card --%>
                            <div class="card mb-3 text-center py-5">
                                <div class="card-body">
                                    <div class="mb-3">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-primary">
                                            <path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/>
                                            <path d="m15 5 4 4"/>
                                        </svg>
                                    </div>
                                    <h5 class="card-title mb-3">Edit Personal Informations</h5>
                                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                                        Edit Profile
                                    </button>
                                </div>
                            </div>

                            <%-- Change Password Card --%>
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title mb-4">Change Password</h5>
                                    <form method="POST" action="${pageContext.request.contextPath}/change-password">
                                        <div class="mb-3">
                                            <label for="currentPassword" class="form-label text-muted small">Current Password</label>
                                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="newPassword" class="form-label text-muted small">New Password</label>
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="confirmPassword" class="form-label text-muted small">Confirm New Password</label>
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary w-100">Change Password</button>
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

        <%-- Success Toast --%>
        <c:if test="${not empty success or not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show rounded-4" role="alert" 
                style="position: fixed; bottom: 20px; right: 20px; z-index: 9999; max-width: 400px;">
                <strong>Success!</strong> 
                ${not empty success ? success : param.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <%-- Error Toast --%>
        <c:if test="${not empty error or not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show rounded-4" role="alert" 
                style="position: fixed; bottom: 20px; right: 20px; z-index: 9999; max-width: 400px;">
                <strong>Error!</strong> 
                ${not empty error ? error : param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <%-- Edit Profile Modal --%>
        <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editProfileModalLabel">Edit Personal Information</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form method="POST" action="${pageContext.request.contextPath}/update-profile" enctype="multipart/form-data">
                        <input type="hidden" name="accountID" value="${user.accountid}">
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-12 text-center mb-3">
                                    <img src="${user.picturepath}" 
                                         onerror="this.onerror=null; this.src='https://placehold.co/150x150?text=No+Image';" 
                                         alt="Profile Picture" 
                                         id="profilePreview"
                                         class="rounded-circle border border-3 border-primary"
                                         style="width: 100px; height: 100px; object-fit: cover;">
                                    <div class="mt-2">
                                        <label for="profilePicture" class="btn btn-sm btn-outline-primary">
                                            Change Picture
                                        </label>
                                        <input type="file" class="d-none" id="profilePicture" name="profilePicture" accept="image/*">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label for="fullname" class="form-label">Full Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="fullname" name="fullname" value="${user.fullname}" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email Address <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="phoneno" class="form-label">Phone Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="phoneno" name="phoneno" value="${user.phoneno}" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="ic_passport" class="form-label">IC or Passport Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="ic_passport" name="ic_passport" value="${user.ic_passport}" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="gender" class="form-label">Gender <span class="text-danger">*</span></label>
                                    <select class="form-select" id="gender" name="gender" required>
                                        <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label for="dateofbirth" class="form-label">Date of Birth <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="dateofbirth" name="dateofbirth" 
                                           value="<fmt:formatDate value='${user.dateofbirth}' pattern='yyyy-MM-dd'/>" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="bloodgroup" class="form-label">Blood Group</label>
                                    <select class="form-select" id="bloodgroup" name="bloodgroup">
                                        <option value="">-- Select Blood Group --</option>
                                        <option value="A+" ${user.bloodgroup == 'A+' ? 'selected' : ''}>A+</option>
                                        <option value="A-" ${user.bloodgroup == 'A-' ? 'selected' : ''}>A-</option>
                                        <option value="B+" ${user.bloodgroup == 'B+' ? 'selected' : ''}>B+</option>
                                        <option value="B-" ${user.bloodgroup == 'B-' ? 'selected' : ''}>B-</option>
                                        <option value="AB+" ${user.bloodgroup == 'AB+' ? 'selected' : ''}>AB+</option>
                                        <option value="AB-" ${user.bloodgroup == 'AB-' ? 'selected' : ''}>AB-</option>
                                        <option value="O+" ${user.bloodgroup == 'O+' ? 'selected' : ''}>O+</option>
                                        <option value="O-" ${user.bloodgroup == 'O-' ? 'selected' : ''}>O-</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label for="allergy" class="form-label">Allergies</label>
                                    <input type="text" class="form-control" id="allergy" name="allergy" 
                                           value="${user.allergy}" placeholder="e.g., Penicillin, Peanuts">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        <script>
            $(document).ready(function() {
                // Profile picture preview
                $('#profilePicture').on('change', function(e) {
                    const file = e.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            $('#profilePreview').attr('src', e.target.result);
                        }
                        reader.readAsDataURL(file);
                    }
                });

                // Password validation
                $('form[action*="change-password"]').on('submit', function(e) {
                    const newPassword = $('#newPassword').val();
                    const confirmPassword = $('#confirmPassword').val();
                    
                    if (newPassword !== confirmPassword) {
                        e.preventDefault();
                        alert('New password and confirm password do not match!');
                        return false;
                    }
                    
                    if (newPassword.length < 6) {
                        e.preventDefault();
                        alert('Password must be at least 6 characters long!');
                        return false;
                    }
                });
            });
        </script>
        
    </body>
</html>