
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-bs-theme-color="theme-color-default">

    <%@ include file="/WEB-INF/jspf/head.jspf" %>
    <c:set var="pageTitle" value="Schedule" />
    
    <!-- Fullcalender CSS -->
    <link rel='stylesheet' href='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/core/main.css' />
    <link rel='stylesheet' href='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/daygrid/main.css' />
    <link rel='stylesheet' href='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/timegrid/main.css' />
    <link rel='stylesheet' href='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/list/main.css' />
    <style>
        .fc-event {
             height: 65px !important; 
             border-radius: 7px !important;
             cursor: pointer !important;
        }

        .fc-event:hover {
            background: #2e46ba !important;
        }

        .fc-event .fc-content {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            font-weight: semibold;
        }
    </style>

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
                        <div class="col-md-9 pe-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div id="calendar1" class="calendar-s"></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 ps-md-2">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title mb-3" style="font-size: 1.1rem;">Actions</h5>
                                    <div class="row g-2">
                                        <button id="update_availability" class="btn btn-primary col-12 d-flex flex-column align-items-center rounded-3 justify-content-center py-3 gap-2">
                                            Update Availability
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

        <%-- Timeslot Modal --%>
        <div class="modal fade" id="timeslotModal" tabindex="-1" aria-labelledby="timeslotModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="timeslotModalLabel"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="addTimeslot" class="row mb-3" style="display: none;">
                            <div class="form-group col-8 mb-0 pe-2">
                                <select class="form-select" name="timeslot_add" id="timeslot_add" required>
                                    <option value="">-- Add Time Slot --</option>
                                </select>
                            </div>
                            <div class="col-4 ps-2">
                                <button type="button" id="btn_add_timeslot" class="btn btn-primary btn-sm h-100 w-100">Add Timeslot</button>
                            </div>
                        </div>
                        <div id="timeslotContainer">
                            <p class="text-muted">Loading timeslots...</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <%-- <button id="btn_delete_date" type="button" class="btn btn-danger" data-bs-dismiss="modal" disabled>Delete</button> --%>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Add Timeslot Modal --%>
        <div class="modal fade" id="addDateModal" tabindex="-1" aria-labelledby="addDateModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addDateModalLabel">Set as available</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary-subtle" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" id="btn_add_date" class="btn btn-primary">Confirm</button>
                    </div>
                </div>
            </div>
        </div>
        
        <%@ include file="/WEB-INF/jspf/scripts.jspf" %>

        <!-- Fullcalender Javascript -->
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/core/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/daygrid/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/timegrid/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/list/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/fullcalendar/interaction/main.js'></script>
        <script src='${pageContext.request.contextPath}/vendor/assets/vendor/moment.min.js'></script>

        <script>
            let calendar1; 
            let isUpdateMode = false;
            let doctorID = "${sessionScope.loggedUser.accountID}";
            let currentScheduleID = null;

            $(document).ready(function() {
                if (document.getElementById('calendar1')) {
                    let calendarEl = document.getElementById('calendar1');
                    
                    calendar1 = new FullCalendar.Calendar(calendarEl, {
                        handleWindowResize: false,
                        selectable: false,
                        plugins: ["timeGrid", "dayGrid", "list", "interaction"],
                        timeZone: "UTC",
                        defaultView: "dayGridMonth",
                        contentHeight: "auto",
                        dayMaxEvents: 4,
                        header: {
                            left: "prev,today",
                            center: "title",
                            right: "next"
                        },
                        dateClick: function (info) {
                            let existingEvents = calendar1.getEvents();
                            let isBooked = existingEvents.some(e => e.startStr === info.dateStr);
                            
                            if (isBooked) {
                                alert("A schedule already exists for this date.");
                            } else {
                                $('#schedule-start-date').val(info.dateStr);
                                $('#schedule-end-date').val(info.dateStr);
                                $('#date-event').modal('show');
                            }
                        },
                        eventClick: function(info) {
                            $('#timeslotModal').modal('show');
                            $('#timeslotModalLabel').text('Timeslot for ' + info.event.start.toLocaleDateString('en-US', { day: 'numeric', month: 'long', year: 'numeric' }));
                            currentScheduleID = info.event.extendedProps.scheduleID;
                            console.log(currentScheduleID);
                            loadTimeSlots(info.event.extendedProps.scheduleID);
                        },
                        select: function(info) {
                            $('#addDateModal').modal('show');
                            $('#addDateModalLabel').text('Set ' + info.start.toLocaleDateString('en-US', { day: 'numeric', month: 'long', year: 'numeric' }) + ' as available?' );
                        
                            $('#btn_add_date').on('click', function() {
                                var selectedDate = info.startStr;
                                addScheduleDate(doctorID, selectedDate);
                            });
                        }
                    });

                    calendar1.render();
                    loadCalendarEvents(doctorID);
                }
            });

            function loadCalendarEvents(doctorID) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/schedule/doctorschedule',
                    type: 'GET',
                    data: { doctorID: doctorID },
                    dataType: 'json',
                    success: function(data) {
                        calendar1.removeAllEventSources();
                        calendar1.addEventSource(data);
                    },
                    error: function(xhr, status, error) {
                        alert("Failed to fetch dates:", error);
                    }
                });
            }


            $('#update_availability').on('click', function() {
                isUpdateMode = !isUpdateMode;
                $(this).toggleClass('btn-danger btn-primary'); 
                
                if (isUpdateMode) {
                    $(this).text('Return to View Mode');
                    calendar1.setOption('selectable', true);
                } else {
                    $(this).text('Update Availability');
                    calendar1.setOption('selectable', false);
                }
            });

            function loadTimeSlots(scheduleID) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/schedule/timeslots',
                    type: 'GET',
                    data: { scheduleID: scheduleID },
                    dataType: 'json',
                    success: function(data) {
                        let html = '';

                        if (data.length === 0) {
                            $('#btn_delete_date').prop('disabled', false);
                            html = '<p class="text-muted text-center">No timeslots available for this date.</p>';
                        } else {
                            html = '<div class="row row-cols-1 g-1 px-3">';

                            data.forEach(function(slot) {
                                const appointmentID = slot.APPOINTMENTID || slot.appointmentID || 0;
                                const isAvailable = appointmentID === 0;
                                const timeslotID = slot.TIMESLOTID || slot.timeslotID;
                                const rawTime = slot.STARTTIME || slot.startTime || "00:00:00";
                                const time = new Date("2000-01-01 " + rawTime).toLocaleTimeString('en-US', {
                                    hour: 'numeric',
                                    minute: '2-digit',
                                    hour12: true
                                });
                                
                                const picturePath = slot.PICTUREPATH || slot.picturePath;
                                const fullName = slot.FULLNAME || slot.fullName || 'Unknown Patient';

                                if (!isAvailable) {    
                                    html += `
                                        <div class="col">
                                            <div class="d-flex flex-row align-items-center gap-3 py-2">
                                                <img src="\${picturePath}" alt="Patient Profile" class="theme-color-default-img img-fluid avatar avatar-50 avatar-rounded border border-3 border-primary-subtle">
                                                <div class="w-100 d-flex flex-column justify-content-start align-items-start">
                                                    <p class="m-0 text-dark fw-normal lh-1 mb-1 text-truncate" style="max-width: 260px;">\${fullName}</p>
                                                    <p class="m-0 text-muted lh-1"><small>Patient</small></p>
                                                </div>
                                                <div class="d-flex flex-column justify-content-start align-items-start">
                                                    <p class="m-0 w-100 text-dark fw-normal lh-1 mb-1 text-end">\${time}</p>
                                                    <a href="${pageContext.request.contextPath}/appointment/page?id=\${appointmentID}" class="m-0 text-primary fw-normal lh-1 text-nowrap text-right">View Details</a>
                                                </div>
                                            </div>
                                        </div>
                                    `;
                                } else {
                                    html += `
                                        <div class="col">
                                            <div class="d-flex flex-row align-items-center gap-3 py-2">
                                                <div class="avatar-50 avatar-rounded bg-primary-subtle d-flex justify-content-center align-items-center">
                                                    <svg width="23" height="23" viewBox="0 0 23 23" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M8.21429 0L6.57143 0.383333V1.53333H8.21429V0ZM8.21429 1.53333V3.06667H6.57143V1.53333H6.56157C4.49321 1.5548 2.98014 1.48733 1.74471 2.12213C1.127 2.44107 0.635786 2.9808 0.364714 3.65393C0.0952857 4.32553 0 5.12593 0 6.13333V18.4C0 19.4074 0.0952857 20.2063 0.364714 20.8794C0.635786 21.5525 1.127 22.0877 1.74471 22.4066C2.98179 23.0429 4.49486 22.977 6.56157 23H16.4384C18.5051 22.977 20.0166 23.0429 21.2536 22.4066C21.8937 22.0678 22.3822 21.5259 22.6304 20.8794C22.9014 20.2063 23 19.3614 23 18.4V6.13333C23 5.1244 22.9014 4.32553 22.6304 3.65393C22.3816 3.00696 21.8933 2.46425 21.2536 2.12367C20.0166 1.4858 18.5051 1.55633 16.4384 1.53333H16.4286V3.06667H14.7857V1.53333H8.21429ZM14.7857 1.53333H16.4286V0L14.7857 0.383333V1.53333ZM6.58129 7.66667H16.4286C18.4986 7.68813 19.8572 7.75867 20.4585 8.06687C20.7591 8.22327 20.9333 8.39347 21.0926 8.79213C21.2536 9.1908 21.3555 10.7333 21.3555 10.7333V18.4C21.3555 19.3077 21.2536 19.941 21.0926 20.3397C20.9333 20.7383 20.7591 20.9101 20.4585 21.0649C19.8572 21.3747 18.4969 21.4437 16.4286 21.4667H6.57143C4.50143 21.4437 3.14279 21.3747 2.53986 21.0649C2.23921 20.9101 2.06507 20.7383 1.90571 20.3397C1.74471 19.941 1.64286 19.3077 1.64286 18.4V10.7333C1.64286 9.82407 1.74471 9.1908 1.90571 8.79213C2.06507 8.39347 2.23921 8.22327 2.53986 8.06687C3.14279 7.75713 4.50471 7.68813 6.58129 7.66667Z" fill="#3a57e8"/>
                                                    </svg>
                                                </div>
                                                <div class="flex-grow-1 d-flex flex-column justify-content-start align-items-start">
                                                    <p class="m-0 w-100 text-dark fw-normal lh-1 mb-1 text-start">\${time}</p>
                                                    <p class="m-0 text-muted lh-1"><small>Not booked</small></p>
                                                </div>`;
                                    

                                    if (isUpdateMode) {
                                        html += `
                                                <button class="btn btn-sm btn-danger btn-delete-timeslot" data-timeslot-id="\${timeslotID}">
                                                    <svg width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                                    </svg>
                                                </button>`;
                                    }
                                    
                                    html += `
                                            </div>
                                        </div>
                                    `;
                                }
                            });

                            html += '</div>';
                        }

                        $('#timeslotContainer').html(html);
                        
                        // Show/hide add timeslot section based on update mode
                        if (isUpdateMode) {
                            $('#addTimeslot').show();
                            loadAvailableTimeSlots(scheduleID, data);
                        } else {
                            $('#addTimeslot').hide();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Failed to fetch timeslots:", error);
                        $('#timeslotContainer').html('<div class="alert alert-danger">Failed to load timeslots. Please try again.</div>');
                    }
                });
            }

            
            function loadAvailableTimeSlots(scheduleID, data) {
                // All possible time slots (8:00 AM to 5:30 PM in 30-min intervals)
                const allTimeSlots = [];
                for (let hour = 8; hour < 18; hour++) {
                    for (let minute = 0; minute < 60; minute += 30) {
                        if (hour === 17 && minute === 30) break; // Stop at 5:30 PM
                        const startHour = hour;
                        const startMin = minute;
                        const endHour = minute === 30 ? hour + 1 : hour;
                        const endMin = minute === 30 ? 0 : 30;
                        
                        const startTime = `\${String(startHour).padStart(2, '0')}:\${String(startMin).padStart(2, '0')}:00`;
                        const endTime = `\${String(endHour).padStart(2, '0')}:\${String(endMin).padStart(2, '0')}:00`;
                        
                        allTimeSlots.push({ startTime, endTime });
                    }
                }
                
                // Filter out existing time slots
                const existingTimes = data.map(slot => slot.STARTTIME || slot.startTime);
                const availableSlots = allTimeSlots.filter(slot => !existingTimes.includes(slot.startTime));
                
                // Populate dropdown
                let html = '<option value="">-- Select Time Slot --</option>';
                availableSlots.forEach(slot => {
                    const startTime = new Date("2000-01-01 " + slot.startTime).toLocaleTimeString('en-US', {
                        hour: 'numeric',
                        minute: '2-digit',
                        hour12: true
                    });
                    const endTime = new Date("2000-01-01 " + slot.endTime).toLocaleTimeString('en-US', {
                        hour: 'numeric',
                        minute: '2-digit',
                        hour12: true
                    });
                    html += `<option value="\${slot.startTime}|\${slot.endTime}">\${startTime} - \${endTime}</option>`;
                });
                
                $('#timeslot_add').html(html);
            }

            // Add timeslot button handler
            $(document).on('click', '#btn_add_timeslot', function() {
                const selectedValue = $('#timeslot_add').val();
                
                if (!selectedValue) {
                    alert('Please select a time slot');
                    return;
                }
                
                const [startTime, endTime] = selectedValue.split('|');
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/schedule/timeslot/add',
                    type: 'POST',
                    data: {
                        scheduleID: currentScheduleID,
                        startTime: startTime,
                        endTime: endTime
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            loadCalendarEvents(doctorID);
                            loadTimeSlots(currentScheduleID);
                            $('#timeslot_add').val('');
                        } else {
                            alert(response.message || 'Failed to add timeslot');
                        }
                    },
                    error: function() {
                        alert('Error adding timeslot');
                    }
                });
            });

            // Delete timeslot button handler
            $(document).on('click', '.btn-delete-timeslot', function() {
                const timeslotID = $(this).data('timeslot-id');
                
                if (!confirm('Are you sure you want to delete this timeslot?')) {
                    return;
                }
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/schedule/timeslot/delete',
                    type: 'POST',
                    data: { timeslotID: timeslotID },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            loadTimeSlots(currentScheduleID);
                            loadCalendarEvents(doctorID);
                        } else {
                            alert(response.message || 'Failed to delete timeslot');
                        }
                    },
                    error: function() {
                        alert('Error deleting timeslot');
                    }
                });
            });

            // Reset modal when closed
            $('#timeslotModal').on('hidden.bs.modal', function() {
                $('#timeslotContainer').html('<p class="text-muted">Loading timeslots...</p>');
                $('#addTimeslot').hide();
                $('#btn_delete_date').prop('disabled', false);
                currentScheduleID = null;
            });

            function addScheduleDate(doctorID, scheduleDate) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/schedule/date/add',
                    type: 'POST',
                    data: { 
                        doctorID: doctorID, 
                        scheduleDate: scheduleDate 
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            $('#addDateModal').modal('hide');
                            loadCalendarEvents(doctorID);
                        } else {
                            alert(response.message || 'Failed to add date');
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("Failed to store date: " + error);
                    }
                });
            }

        </script>
    </body>
</html>
