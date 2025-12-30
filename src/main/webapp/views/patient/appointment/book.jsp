<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ehas.model.*, java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/jspf/head.jspf" %>
<c:set var="pageTitle" value="Book Appointment" />
<head>
    <style>
        /* Keep your existing styles here */
        body { margin:0; font-family:"Segoe UI",Arial,sans-serif; background:#f1f3f6; }
        .container { max-width:1100px; margin:30px auto; padding:20px; }
        .breadcrumb { background:#fff; padding:15px 20px; border-radius:6px; display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; }
        .breadcrumb span { color:#1f4ed8; font-weight:500; }
        .home-btn { background:#1f4ed8; color:#fff; border:none; padding:8px 16px; border-radius:5px; cursor:pointer; }
        .card { background:#fff; padding:25px; border-radius:6px; }
        .form-group { margin-bottom:20px; }
        .form-row { display:grid; grid-template-columns:1fr 1fr; gap:20px; }
        label { font-weight:500; display:block; margin-bottom:8px; }
        .required { color:red; }
        select, input[type="date"] { width:100%; padding:12px; border-radius:6px; border:1px solid #ccc; background:#fff; }
        h3 { margin:30px 0 15px; font-size:18px; }
        .button-row { display:grid; grid-template-columns:1fr; gap:20px; margin-top:30px; }
        .btn-primary { background:#3f5ae0; color:#fff; border:none; padding:14px; font-size:15px; border-radius:6px; cursor:pointer; }
        .btn-disabled { background:#bdbdbd; color:#fff; border:none; padding:14px; font-size:15px; border-radius:6px; cursor:not-allowed; }
    </style>
</head>
<body>
<!-- Loader -->
<div id="loading">
    <div class="loader simple-loader"><div class="loader-body"></div></div>
</div>

<%@ include file="/WEB-INF/jspf/nav.jspf" %>

<main class="main-content">
    <div class="position-relative iq-banner">
        <%@ include file="/WEB-INF/jspf/header.jspf" %>
        <div class="conatiner-fluid content-inner p-3">
            <div class="container">

                <!-- Breadcrumb -->
                <div class="breadcrumb">
                    <span>Appointments / Book Appointment</span>
                    <button class="home-btn" onclick="location.href='./'">Home</button>
                </div>

                <!-- Appointment Form -->
                <div class="card">
                    <form id="appointmentForm" action="${pageContext.request.contextPath}/summaryServlet" method="post">
                        <input type="hidden" name="hospital" id="hospitalInput" value="">
                        <input type="hidden" name="specialityID" id="specialityID">
                        <input type="hidden" name="doctorID" id="doctorID">
                        <input type="hidden" name="appointmentDate" id="appointmentDateInput">
                        <input type="hidden" name="timeslot" id="timeslotInput">

                        <!-- Hospital select -->
                        <div class="form-group">
                            <label>Hospital Branch: <span class="required">*</span></label>
                            <select id="hospital" onchange="onHospitalChange()">
                                <option value="">Select hospital/clinic</option>
                                <option value="H1">Hospital A</option>
                                <!-- Add more hospitals later -->
                            </select>
                        </div>

                        <!-- Specialisation -->
                        <div class="form-group">
                            <label>Specialisation: <span class="required">*</span></label>
                            <select id="specialisation" name="specialisation" disabled onchange="onSpecialisationChange()">
                                <option value="">Select specialisation</option>
                                <%
                                    try {
                                        Context ctx = new InitialContext();
                                        DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/myDatasource");
                                        Connection conn = ds.getConnection();

                                        Statement st = conn.createStatement();
                                        ResultSet rs = st.executeQuery("SELECT * FROM Speciality ORDER BY specialityName");
                                        while(rs.next()) {
                                %>
                                    <option value="<%=rs.getInt("specialityID")%>"><%=rs.getString("specialityName")%></option>
                                <%
                                        }
                                        rs.close(); st.close(); conn.close();
                                    } catch(Exception e){ out.println(e); }
                                %>
                            </select>
                        </div>

                        <!-- Doctor -->
                        <div class="form-group">
                            <label>Doctor Name: <span class="required">*</span></label>
                            <select id="doctor" name="doctor" disabled onchange="onDoctorChange()">
                                <option value="">Select doctor</option>
                            </select>
                        </div>

                        <h3>Select Date and Time</h3>
                        <div class="form-row">
                            <div class="form-group">
                                <label>Date: <span class="required">*</span></label>
                                <input type="date" id="appointmentDate" disabled onchange="onDateChange()">
                            </div>
                            <div class="form-group">
                                <label>Time: <span class="required">*</span></label>
                                <select id="timeSlot" name="timeSlot" disabled onchange="onTimeChange()">
                                    <option value="">Select time</option>
                                </select>
                            </div>
                        </div>

                        <div class="button-row">
                            <button type="button" id="nextBtn" class="btn-disabled" disabled>Next</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/jspf/footer.jspf" %>
</main>

<%@ include file="/WEB-INF/jspf/scripts.jspf" %>
<script>
let doctorsData = {}; // specialityID -> [{id, licenseNo}]
document.addEventListener("DOMContentLoaded", () => {
    // Fetch doctors via Ajax
    fetch('<%=request.getContextPath()%>/fetchDoctorsServlet')
        .then(r=>r.json())
        .then(data=>{
            doctorsData = data;
        });
});

// Hospital changed
function onHospitalChange() {
    const hospital = document.getElementById("hospital").value;
    document.getElementById("hospitalInput").value = hospital;
    resetSelect('specialisation', 'Select specialisation');
    resetSelect('doctor', 'Select doctor');
    resetSelect('timeSlot', 'Select time');
    document.getElementById('appointmentDate').value = '';
    document.getElementById('appointmentDate').disabled = true;
    disableNext();
}

// Specialisation changed
function onSpecialisationChange() {
    const speciality = document.getElementById("specialisation").value;
    const doctorSelect = document.getElementById("doctor");
    doctorSelect.innerHTML = '<option value="">Select doctor</option>';

    if (!speciality || !doctorsData[speciality]) {
        doctorSelect.disabled = true; return;
    }

    doctorsData[speciality].forEach(d=>{
        const opt = document.createElement("option");
        opt.value = d.id;
        opt.textContent = d.licenseNo;
        doctorSelect.appendChild(opt);
    });
    doctorSelect.disabled = false;
    document.getElementById("appointmentDate").disabled = false;
    resetTimeSlot();
}

function onDoctorChange(){ resetTimeSlot(); document.getElementById("appointmentDate").disabled=false; }

function resetTimeSlot(){
    const ts = document.getElementById("timeSlot");
    ts.innerHTML = '<option value="">Select time</option>'; ts.disabled=true;
    disableNext();
}

function onDateChange() {
    const date = document.getElementById("appointmentDate").value;
    const doctorID = document.getElementById("doctor").value;
    if(!date || !doctorID) return;

    fetch(`${window.location.pathname.replace('book.jsp','fetchBookedSlots.jsp')}?doctorID=${doctorID}&appointmentDate=${date}`)
        .then(res=>res.json())
        .then(bookedSlots=>{
            const ts = document.getElementById("timeSlot");
            ts.innerHTML='<option value="">Select time</option>';
            const allTimeSlots=["08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00"];
            allTimeSlots.forEach(time=>{
                const opt=document.createElement("option");
                opt.value=time; opt.textContent=time + (bookedSlots.includes(time)?' - Booked':' - Available');
                if(bookedSlots.includes(time)){ opt.disabled=true; opt.style.color='#999'; }
                ts.appendChild(opt);
            });
            ts.disabled=false;
        });
    disableNext();
}

function onTimeChange() {
    const ts = document.getElementById("timeSlot");
    const btn = document.getElementById("nextBtn");
    if(ts.value){ btn.disabled=false; btn.classList.remove('btn-disabled'); btn.classList.add('btn-primary'); }
    else disableNext();
}

function disableNext() {
    const btn = document.getElementById("nextBtn");
    btn.disabled=true; btn.classList.remove('btn-primary'); btn.classList.add('btn-disabled');
}

function resetSelect(id, placeholder) {
    const sel = document.getElementById(id);
    sel.innerHTML = `<option value="">${placeholder}</option>`;
    sel.disabled = true;
}

document.getElementById("nextBtn").addEventListener("click", ()=>{
    document.getElementById("specialityID").value = document.getElementById("specialisation").value;
    document.getElementById("doctorID").value = document.getElementById("doctor").value;
    document.getElementById("appointmentDateInput").value = document.getElementById("appointmentDate").value;
    document.getElementById("timeslotInput").value = document.getElementById("timeSlot").value;
    document.getElementById("appointmentForm").submit();
});
</script>
</body>
</html>
