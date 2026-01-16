<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Invoice" />

    <body class="uikit" data-bs-spy="scroll" data-bs-target="#elements-section" data-bs-offset="0" tabindex="0">
        <div id="loading">
            <div class="loader simple-loader">
                <div class="loader-body"></div>
            </div>    
        </div>

        <%@ include file="/WEB-INF/jspf/nav.jspf" %>
        
        <%-- Get Invoice Details --%>
        <sql:query var="invoiceData" dataSource="${myDatasource}">
            SELECT 
                A.APPOINTMENTID, A.STATUS, A.BILLSTATUS, A.CREATEDAT,
                A.CONSULTATIONFEE, A.TREATMENTFEE, A.TOTALAMOUNT,
                PA.FULLNAME AS PATIENT_NAME, PA.EMAIL AS PATIENT_EMAIL, PA.PHONENO AS PATIENT_PHONE, PA.ACCOUNTID AS PATIENT_ID,
                DA.FULLNAME AS DOCTOR_NAME,
                S.SPECIALITYNAME,
                DS.SCHEDULEDATE, T.STARTTIME, T.ENDTIME
            FROM APPOINTMENT A
            LEFT JOIN ACCOUNT PA ON A.PATIENTID = PA.ACCOUNTID
            LEFT JOIN ACCOUNT DA ON A.DOCTORID = DA.ACCOUNTID
            LEFT JOIN DOCTOR D ON A.DOCTORID = D.ACCOUNTID
            LEFT JOIN SPECIALITY S ON D.SPECIALITYID = S.SPECIALITYID
            LEFT JOIN TIMESLOT T ON A.TIMESLOTID = T.TIMESLOTID
            LEFT JOIN DOCTORSCHEDULE DS ON T.SCHEDULEID = DS.SCHEDULEID
            WHERE A.APPOINTMENTID = ?::Integer AND A.STATUS = 'COMPLETED'
            <sql:param value="${param.id}" />
        </sql:query>
        
        <c:if test="${invoiceData.rowCount == 0}">
            <c:redirect url="/appointment">
                <c:param name="error" value="Invoice not found" />
            </c:redirect>
        </c:if>
        
        <c:set var="invoice" value="${invoiceData.rows[0]}" />
        
        <%-- Security Check: Only patient can view their invoice --%>
        <c:set var="loggedUser" value="${sessionScope.loggedUser}" />
        <c:if test="${loggedUser == null || loggedUser.accountID != invoice.patient_id }">
            <c:redirect url="/appointment">
                <c:param name="error" value="Unauthorized access to invoice" />
            </c:redirect>
        </c:if>
        
        <main class="main-content">
            <div class="position-relative iq-banner">
                <%@ include file="/WEB-INF/jspf/header.jspf" %>
            
                <div class="container-fluid content-inner p-3">
                    <div class="col-12">
                        <div class="card py-3 px-5 mb-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/appointment">Appointments</a></li>
                                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/appointment/page?id=${param.id}">Appointment Page</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">${pageTitle}</li>
                                        </ol>
                                    </nav>
                                </div>
                                <div class="col-auto">
                                    <button onclick="window.print()" class="btn btn-sm btn-primary me-2">Print Invoice</button>
                                    <button onclick="window.location.href='${pageContext.request.contextPath}/'" class="btn btn-sm btn-secondary">Home</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Invoice Document -->
                        <div class="col-lg-8 pe-md-2">
                            <div class="card shadow-sm">
                                <div class="card-body p-5">
                                    
                                    <!-- Header -->
                                    <div class="row mb-5">
                                        <div class="col-6">
                                            <h4 class="fw-bold mb-0 text-primary">INVOICE</h4>
                                            <p class="text-secondary mb-0">Appointment Consultation</p>
                                        </div>
                                        <div class="col-6 text-end">
                                            <p class="mb-0 text-secondary"><strong>Invoice #:</strong> INV-${invoice.appointmentid}</p>
                                            <p class="mb-0 text-secondary"><strong>Date:</strong> <fmt:formatDate value="${invoice.createdat}" pattern="dd MMM yyyy"/></p>
                                            <p class="mt-2">
                                                <c:choose>
                                                    <c:when test="${invoice.billstatus == 'PAID'}">
                                                        <span class="badge bg-success px-3 py-2 rounded-pill">PAID</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger px-3 py-2 rounded-pill">UNPAID</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>

                                    <hr>

                                    <!-- Bill To / Service Details -->
                                    <div class="row mb-5">
                                        <div class="col-6">
                                            <h6 class="fw-bold mb-2 text-dark">BILLED TO</h6>
                                            <p class="mb-0 text-dark"><strong>${invoice.patient_name}</strong></p>
                                            <p class="mb-0 text-dark small">${invoice.patient_email}</p>
                                            <p class="mb-0 text-dark small">${invoice.patient_phone}</p>
                                        </div>
                                        <div class="col-6">
                                            <h6 class="fw-bold mb-2 text-dark">SERVICE DETAILS</h6>
                                            <p class="mb-0 text-dark"><strong>Doctor:</strong> ${invoice.doctor_name}</p>
                                            <p class="mb-0 text-dark"><strong>Speciality:</strong> ${invoice.specialityname}</p>
                                            <p class="mb-0 text-dark"><strong>Date:</strong> <fmt:formatDate value="${invoice.SCHEDULEDATE}" pattern="dd MMM yyyy"/></p>
                                        </div>
                                    </div>

                                    <hr>

                                    <!-- Services Table -->
                                    <div class="mb-5">
                                        <table class="table table-sm">
                                            <thead class="table-light">
                                                <tr>
                                                    <th class="rounded-start-5 ps-3">Description</th>
                                                    <th class="text-end">Quantity</th>
                                                    <th class="text-end">Unit Price</th>
                                                    <th class="rounded-end-5 pe-3 text-end">Amount</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td class="text-dark ps-3">Consultation Fee</td>
                                                    <td class="text-dark text-end">1</td>
                                                    <td class="text-dark text-end">RM <fmt:formatNumber value="${invoice.consultationfee}" minFractionDigits="2"/></td>
                                                    <td class="text-dark text-end pe-3">RM <fmt:formatNumber value="${invoice.consultationfee}" minFractionDigits="2"/></td>
                                                </tr>
                                                <tr>
                                                    <td class="text-dark ps-3">Treatment Fee</td>
                                                    <td class="text-dark text-end">1</td>
                                                    <td class="text-dark text-end">RM <fmt:formatNumber value="${invoice.treatmentfee}" minFractionDigits="2"/></td>
                                                    <td class="text-dark text-end pe-3">RM <fmt:formatNumber value="${invoice.treatmentfee}" minFractionDigits="2"/></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Totals -->
                                    <div class="row justify-content-end mb-5">
                                        <div class="col-md-5">
                                            <div class="border rounded p-3">
                                                <div class="row mb-2">
                                                    <div class="col-6 text-dark"><strong>Subtotal:</strong></div>
                                                    <div class="col-6 text-dark text-end">RM <fmt:formatNumber value="${invoice.consultationfee + invoice.treatmentfee}" minFractionDigits="2"/></div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-6 text-dark"><strong>Tax (0%):</strong></div>
                                                    <div class="col-6 text-dark text-end">RM 0.00</div>
                                                </div>
                                                <div class="row border-top pt-2">
                                                    <div class="col-6"><h6 class="fw-bold mb-0">TOTAL DUE:</h6></div>
                                                    <div class="col-6 text-end"><h6 class="fw-bold mb-0 text-primary">RM <fmt:formatNumber value="${invoice.totalamount}" minFractionDigits="2"/></h6></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Footer -->
                                    <hr>
                                    <div class="text-center">
                                        <p class="text-muted small mb-1">Thank you for your consultation</p>
                                        <p class="text-muted small mb-0">Please make payment by the due date</p>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <!-- Payment Section -->
                        <div class="col-lg-4 ps-md-2">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h5 class="card-title mb-4">Payment</h5>
                                    
                                    <!-- Amount Summary -->
                                    <div class="p-3 bg-primary-subtle border border-1 border-primary rounded mb-4">
                                        <p class="text-dark mb-1"><small>Amount Due</small></p>
                                        <h4 class="fw-bold text-primary mb-0">RM <fmt:formatNumber value="${invoice.totalamount}" minFractionDigits="2"/></h4>
                                    </div>

                                    <!-- Bill Status -->
                                    <div class="mb-4">
                                        <p class="text-dark mb-2"><small>Status</small></p>
                                        <c:choose>
                                            <c:when test="${invoice.billstatus == 'PAID'}">
                                                <div class="alert alert-success py-2 px-3 mb-0">
                                                    <strong>Payment Received</strong>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="alert alert-warning py-2 px-3 mb-0">
                                                    <strong>Payment Pending</strong>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Payment Button -->
                                    <c:if test="${invoice.billstatus != 'PAID'}">
                                        <button class="btn btn-primary w-100 py-3" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#stripePaymentModal"
                                                data-amount="${invoice.totalamount}"
                                                data-invoiceid="${invoice.appointmentid}"
                                                data-patientemail="${invoice.patient_email}">
                                            <i class="fas fa-credit-card me-2"></i> Pay Now with Card
                                        </button>
                                    </c:if>

                                    <!-- Secure Payment Badge -->
                                    <div class="mt-4 text-center">
                                        <p class="text-muted small mb-1">
                                            <i class="fas fa-lock text-success"></i> Secure Payment
                                        </p>
                                        <p class="text-muted small">Powered by Stripe</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        
            <%@ include file="/WEB-INF/jspf/footer.jspf" %>
        </main>

        <%-- Stripe Payment Modal --%>
        <div class="modal fade" id="stripePaymentModal" tabindex="-1" role="dialog" aria-labelledby="stripePaymentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="stripePaymentModalLabel">Secure Payment</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="stripePaymentForm">
                        <div class="modal-body">
                            <input type="hidden" id="invoiceId" name="invoiceId">
                            <input type="hidden" id="amount" name="amount">
                            <input type="hidden" id="patientEmail" name="patientEmail">
                            
                            <div class="mb-3">
                                <label class="form-label"><strong>Amount to Pay</strong></label>
                                <div class="p-3 bg-light rounded">
                                    <h5 class="fw-bold text-primary mb-0">RM <span id="displayAmount">0.00</span></h5>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="cardElement" class="form-label">Card Details</label>
                                <div id="cardElement" class="form-control" style="height: 40px; padding-top: 10px;"></div>
                                <div id="cardErrors" class="text-danger mt-2 small"></div>
                            </div>

                            <div class="mb-3">
                                <label for="cardholderName" class="form-label">Cardholder Name</label>
                                <input type="text" class="form-control" id="cardholderName" placeholder="John Doe" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" id="submitPaymentBtn">Pay Now</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

        <!-- Stripe.js -->
        <script src="https://js.stripe.com/v3/"></script>

        <script>
        $(document).ready(function() {
            // Initialize Stripe
            const stripe = Stripe('pk_test_YOUR_STRIPE_PUBLISHABLE_KEY_HERE'); // Replace with your test key
            const elements = stripe.elements();
            const cardElement = elements.create('card');
            cardElement.mount('#cardElement');

            // Handle card errors
            cardElement.on('change', function(event) {
                const displayError = document.getElementById('cardErrors');
                if (event.error) {
                    displayError.textContent = event.error.message;
                } else {
                    displayError.textContent = '';
                }
            });

            // Modal population
            $('#stripePaymentModal').on('show.bs.modal', function(e) {
                const button = e.relatedTarget;
                const amount = $(button).data('amount');
                const invoiceId = $(button).data('invoiceid');
                const patientEmail = $(button).data('patientemail');
                
                $('#invoiceId').val(invoiceId);
                $('#amount').val(Math.round(amount * 100)); // Convert to cents
                $('#patientEmail').val(patientEmail);
                $('#displayAmount').text(amount.toFixed(2));
            });

            // Submit payment
            $('#submitPaymentBtn').on('click', function(e) {
                e.preventDefault();
                const cardholderName = $('#cardholderName').val();
                
                if (!cardholderName.trim()) {
                    alert('Please enter cardholder name');
                    return;
                }

                $(this).prop('disabled', true).html('Processing...');

                // Create payment method
                stripe.createPaymentMethod({
                    type: 'card',
                    card: cardElement,
                    billing_details: {
                        name: cardholderName,
                        email: $('#patientEmail').val()
                    }
                }).then(function(result) {
                    if (result.error) {
                        document.getElementById('cardErrors').textContent = result.error.message;
                        $('#submitPaymentBtn').prop('disabled', false).html('Pay Now');
                    } else {
                        // Send payment method ID to server
                        $.ajax({
                            url: '${pageContext.request.contextPath}/appointment/process-payment',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({
                                invoiceId: $('#invoiceId').val(),
                                paymentMethodId: result.paymentMethod.id,
                                amount: $('#amount').val(),
                                cardholderName: cardholderName
                            }),
                            success: function(response) {
                                if (response.success) {
                                    alert('Payment successful!');
                                    location.reload();
                                } else if (response.requiresAction) {
                                    // Handle 3D Secure
                                    stripe.confirmCardPayment(response.clientSecret, {
                                        payment_method: result.paymentMethod.id
                                    }).then(function(paymentResult) {
                                        if (paymentResult.paymentIntent.status === 'succeeded') {
                                            alert('Payment successful!');
                                            location.reload();
                                        } else {
                                            document.getElementById('cardErrors').textContent = 'Payment failed. Please try again.';
                                            $('#submitPaymentBtn').prop('disabled', false).html('Pay Now');
                                        }
                                    });
                                } else {
                                    document.getElementById('cardErrors').textContent = response.error || 'Payment failed';
                                    $('#submitPaymentBtn').prop('disabled', false).html('Pay Now');
                                }
                            },
                            error: function() {
                                document.getElementById('cardErrors').textContent = 'Network error. Please try again.';
                                $('#submitPaymentBtn').prop('disabled', false).html('Pay Now');
                            }
                        });
                    }
                });
            });
        });
        </script>

        <style>
            @media print {
                body {
                    background: white;
                }
                .btn, .breadcrumb, .navbar, .footer, .col-lg-4 {
                    display: none;
                }
                .card {
                    box-shadow: none;
                    border: 1px solid #dee2e6;
                }
            }
            
            #cardElement {
                border: 1px solid #ced4da;
                border-radius: 0.375rem;
            }
        </style>
        
    </body>
</html>