package com.ehas.controller;

import com.ehas.dao.AppointmentDAO;
import com.ehas.dao.DoctorScheduleDAO;
import com.ehas.dao.TimeslotDAO;
import com.ehas.model.Account;
import com.ehas.model.Appointment;
import com.ehas.model.DoctorSchedule;
import com.ehas.model.Timeslot;
import com.ehas.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;

@WebServlet("/appointment/confirm")
public class ConfirmBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Account loggedUser = (Account) session.getAttribute("loggedUser");
        int patientID = loggedUser.getAccountID();

        String doctorParam = request.getParameter("doctor"); // currently ignored, fixed doctorID = 11
        String dateStr = request.getParameter("date");
        String time = request.getParameter("time");

        int doctorID = 11; // example
        String message = "";

        try (Connection conn = DBConnection.createConnection()) {

            // 1. Convert date string to SQL Date
            Date scheduleDate = Date.valueOf(dateStr);

            // 2. Get or create doctor schedule
            DoctorScheduleDAO schedDAO = new DoctorScheduleDAO();
            DoctorSchedule sched = schedDAO.getScheduleByDoctorAndDate(doctorID, scheduleDate, conn);
            if (sched == null) {
                sched = new DoctorSchedule();
                sched.setDoctorID(doctorID);
                sched.setScheduleDate(dateStr);
                sched.setIsActive(true);
                int scheduleID = schedDAO.createSchedule(sched, conn);
                sched.setScheduleID(scheduleID);
            }

            // 3. Get or create timeslot
            TimeslotDAO slotDAO = new TimeslotDAO();
            Timeslot slot = slotDAO.getTimeslotByScheduleAndTime(sched.getScheduleID(), time, conn);
            if (slot == null) {
                slot = new Timeslot();
                slot.setScheduleID(sched.getScheduleID());
                slot.setStartTime(time);
                // End time = start + 30 mins (example)
                slot.setEndTime(add30Min(time));
                slot.setIsAvailable(true);
                int timeslotID = slotDAO.createTimeslot(slot, conn);
                slot.setTimeslotID(timeslotID);
            }

            // 4. Insert appointment
            Appointment appt = new Appointment();
            appt.setPatientID(patientID);
            appt.setDoctorID(doctorID);
            appt.setTimeslotID(slot.getTimeslotID());
            appt.setStatus("Pending");
            appt.setConcern("");
            appt.setDiagnosis("");
            appt.setTreatment("");
            appt.setNotes("");
            appt.setFollowUpAppointmentID(null);
            appt.setConsultationFee(0);
            appt.setTreatmentFee(0);
            appt.setTotalAmount(0);

            AppointmentDAO apptDAO = new AppointmentDAO();
            boolean success = apptDAO.createAppointment(appt, conn);

            if (success) {
                message = "Appointment booked successfully!";
            } else {
                message = "Failed to book appointment.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
        }

        response.sendRedirect(request.getContextPath() + "/?msg=" + java.net.URLEncoder.encode(message, "UTF-8"));
    }

    private String add30Min(String time) {
        // time format: HH:mm a.m./p.m.
        try {
            String[] parts = time.split("[: ]");
            int hour = Integer.parseInt(parts[0]);
            int min = Integer.parseInt(parts[1]);
            String period = parts[2];

            if (period.equalsIgnoreCase("p.m.") && hour != 12) hour += 12;
            if (period.equalsIgnoreCase("a.m.") && hour == 12) hour = 0;

            int totalMinutes = hour * 60 + min + 30;
            int newHour = totalMinutes / 60;
            int newMin = totalMinutes % 60;
            String newPeriod = newHour >= 12 ? "p.m." : "a.m.";
            if (newHour > 12) newHour -= 12;
            if (newHour == 0) newHour = 12;

            return String.format("%02d:%02d %s", newHour, newMin, newPeriod);
        } catch (Exception e) {
            return time; // fallback
        }
    }
}
