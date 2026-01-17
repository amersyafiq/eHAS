<%-- 
    Document   : user
    Created on : Jan 17, 2025
    Author     : SYAFIQ
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">
    
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="User Management" />   
    
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
                    <%-- Breadcrumb Start --%> 
                    <div class="col-12">
                        <div class="card py-3 px-5 mb-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item active" aria-current="page">User Management</li>
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

                    <div class="col-12">
                        <div class="card py-3 px-4 mb-3">
                            <div class="row mb-3">
                                <div class="col-sm-12 col-md-6">
                                    <div class="dataTables_length">
                                        <label>Show 
                                            <select id="page-length" class="form-select form-select-sm" style="width: auto; display: inline-block;">
                                                <option value="10">10</option>
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                            </select>
                                            entries
                                        </label>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-6">
                                    <div class="d-flex flex-row justify-content-end align-items-center gap-2">
                                        <label for="global-search" class="m-0">Search:</label>
                                        <input type="text" id="global-search" class="form-control form-control-sm" placeholder="" style="max-width: 250px;">
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table id="userTable" class="table" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th class="bg-primary text-white fw-normal rounded-start-5"><small>FULL NAME</small></th>
                                            <th class="bg-primary text-white fw-normal"><small>EMAIL</small></th> 
                                            <th class="bg-primary text-white fw-normal"><small>PHONE</small></th>
                                            <th class="bg-primary text-white fw-normal"><small>TYPE</small></th> 
                                            <th class="bg-primary text-white fw-normal"><small>DATE JOINED</small></th> 
                                            <th class="bg-primary text-white fw-normal rounded-end-5 text-center"><small>ACTION</small></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <sql:query var="results" dataSource="${myDatasource}"> 
                                            SELECT A.ACCOUNTID, A.FULLNAME, A.EMAIL, A.PHONENO, A.ACCOUNTTYPE, A.PICTUREPATH, A.CREATEDAT
                                            FROM ACCOUNT A
                                            ORDER BY A.CREATEDAT DESC
                                        </sql:query>
                                        <c:forEach var="user" items="${results.rows}">
                                            <tr>
                                                <td class="py-2"><img src="${user.picturepath}" onerror="this.onerror=null; this.src='https://placehold.co/500x500?text=No+Image';" alt="User Profile" class="theme-color-default-img img-fluid avatar avatar-rounded border border-1 border-primary" style="width: 35px; height: 35px;">&emsp;${user.fullname}</td>
                                                <td class="py-2">${user.email}</td>
                                                <td class="py-2">${user.phoneno}</td>
                                                <td class="py-2">
                                                    <span 
                                                        class="
                                                            badge 
                                                            px-3 py-2 fw-normal
                                                            <c:choose>
                                                                <c:when test="${user.accounttype == 'Patient'}">
                                                                    bg-primary-subtle text-primary border border-1 border-primary
                                                                </c:when>
                                                                <c:when test="${user.accounttype == 'Doctor'}">
                                                                    bg-primary text-white
                                                                </c:when>
                                                                <c:when test="${user.accounttype == 'Admin'}">
                                                                    bg-secondary text-white
                                                                </c:when>
                                                                <c:otherwise>
                                                                    bg-secondary text-white
                                                                </c:otherwise>
                                                            </c:choose>
                                                        "
                                                    >
                                                        ${user.accounttype}
                                                    </span>
                                                </td>
                                                <td class="py-2"><fmt:formatDate value="${user.createdat}" pattern="MMM d, yyyy"/></td>
                                                <td class="py-2">
                                                    <c:choose>
                                                        <c:when test="${user.accounttype == 'Patient'}">
                                                            <button class="btn btn-sm btn-outline-primary rounded-pill"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#roleModal"
                                                                    data-accountid="${user.accountid}"
                                                                    data-fullname="${user.fullname}"
                                                                    data-accounttype="${user.accounttype}">
                                                                Make Doctor
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${user.accounttype == 'Doctor'}">
                                                            <button class="btn btn-sm btn-outline-danger rounded-pill"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#roleModal"
                                                                    data-accountid="${user.accountid}"
                                                                    data-fullname="${user.fullname}"
                                                                    data-accounttype="${user.accounttype}">
                                                                Revert to Patient
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary px-3 py-2">No Action</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
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

        <%-- Error Toast Start --%>
        <c:if test="${not empty error or not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show rounded-4" role="alert" 
                style="position: fixed; bottom: 20px; right: 20px; z-index: 9999; max-width: 400px;">
                <strong>Error!</strong> 
                ${not empty error ? error : param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <%-- Error Toast END --%>

        <%-- Role Change Modal --%>
        <div class="modal fade" id="roleModal" tabindex="-1" role="dialog" aria-labelledby="roleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="roleModalLabel">Change User Role</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form method="POST" action="${pageContext.request.contextPath}/user" id="roleForm">
                        <div class="modal-body">
                            <input type="hidden" id="formAction" name="action">
                            <input type="hidden" id="accountID" name="accountID">
                            
                            <div class="mb-3">
                                <label class="form-label">User Name</label>
                                <input type="text" class="form-control" id="displayFullName" readonly>
                            </div>

                            <div id="patientToDoctor" style="display: none;">
                                <h6 class="mb-3 text-primary">Doctor Information</h6>
                                
                                <div class="mb-3">
                                    <label for="licenseNo" class="form-label">License Number <span class="text-danger">*</span></label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="licenseNo" 
                                           name="licenseNo" 
                                           placeholder="e.g., MED-2025-001234"
                                           required>
                                </div>

                                <div class="mb-3">
                                    <label for="specialityID" class="form-label">Speciality <span class="text-danger">*</span></label>
                                    <select class="form-select" id="specialityID" name="specialityID" required>
                                        <option value="">-- Select Speciality --</option>
                                        <sql:query var="specialities" dataSource="${myDatasource}">
                                            SELECT SPECIALITYID, SPECIALITYNAME, DEPARTMENT FROM SPECIALITY ORDER BY SPECIALITYNAME
                                        </sql:query>
                                        <c:forEach var="spec" items="${specialities.rows}">
                                            <option value="${spec.specialityid}">${spec.specialityname} (${spec.department})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div id="doctorToPatient" style="display: none;">
                                <div class="alert alert-warning" role="alert">
                                    <strong>Warning:</strong> This action will revert the user from Doctor to Patient. 
                                    All doctor-related information will be removed.
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" id="submitRoleBtn">Confirm Change</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>
        <script>
            $(document).ready(function () {
                const table = $('#userTable').DataTable({
                    paging: true,
                    pageLength: 10,
                    lengthMenu: [10, 25, 50, 100],
                    searching: true,
                    ordering: true,
                    order: [],
                    info: true,
                    responsive: true,
                    dom: 'rt<"bottom"ip><"clear">',
                    columnDefs: [
                        { orderable: false, targets: 5 }, 
                        { searchable: false, targets: 5 }
                    ],
                    language: {
                        search: "",
                        searchPlaceholder: "Search User",
                        info: "Showing _START_ to _END_ of _TOTAL_ entries",
                        lengthMenu: "Show _MENU_ entries",
                        paginate: {
                            previous: "«",
                            next: "»"
                        }
                    },
                    initComplete: function () {
                        $('#page-length').val(this.api().page.len());
                    }
                });

                $('#global-search').on('keyup', function () {
                    table.search(this.value).draw();
                });

                $('#page-length').on('change', function () {
                    table.page.len($(this).val()).draw();
                });

                // Role Modal handling
                $('#roleModal').on('show.bs.modal', function(e) {
                    const button = e.relatedTarget;
                    const accountID = $(button).data('accountid');
                    const fullName = $(button).data('fullname');
                    const accountType = $(button).data('accounttype');
                    
                    $('#accountID').val(accountID);
                    $('#displayFullName').val(fullName);
                    $('#licenseNo').val('');
                    $('#specialityID').val('');
                    
                    // Show/hide relevant sections based on current account type
                    if (accountType === 'Patient') {
                        $('#patientToDoctor').show();
                        $('#doctorToPatient').hide();
                        $('#submitRoleBtn').text('Make Doctor').removeClass('btn-danger').addClass('btn-primary');
                        $('#licenseNo').prop('required', true);
                        $('#specialityID').prop('required', true);
                        $('#formAction').val('add_doctor');
                    } else if (accountType === 'Doctor') {
                        $('#patientToDoctor').hide();
                        $('#doctorToPatient').show();
                        $('#submitRoleBtn').text('Revert to Patient').removeClass('btn-primary').addClass('btn-danger');
                        $('#licenseNo').prop('required', false);
                        $('#specialityID').prop('required', false);
                        $('#formAction').val('revert_doctor');
                    }
                });

                // Reset form when modal closes
                $('#roleModal').on('hidden.bs.modal', function(e) {
                    $('#roleForm')[0].reset();
                });
            });
        </script>
        
    </body>
</html>