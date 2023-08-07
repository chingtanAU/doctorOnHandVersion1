import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';


class AppointmentController extends GetxController {
  final RxList<PatientAppointment> appointments = RxList<PatientAppointment>([
    PatientAppointment(
      doctorName: "Doctor 1",
      appointmentTime: "14:30 - 15:30 AM",
      appointmentDate: "Today",
      appointmentLocation: "436 139 Avenue",
      appointmentReason: "Heart Burn",
    ),
    PatientAppointment(
      doctorName: "Doctor 2",
      appointmentTime: "10:00 - 11:00 AM",
      appointmentDate: "Tomorrow",
      appointmentLocation: "1234 Main Street",
      appointmentReason: "Checkup",
    ),
  ]);

// Rest of the code...
}

class PatientAppointmentScreen extends StatelessWidget {
  final AppointmentController appointmentController =
  Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Appointments"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.6,
              ],
              colors: [
                Colors.blue,
                Colors.teal,
              ],
            ),
          ),
        ),
      ),
      body: Obx(
            () {
          return ListView.builder(
            itemCount: appointmentController.appointments.length,
            itemBuilder: (context, index) {
              return AppointmentCard(
                appointment: appointmentController.appointments[index],
              );
            },
          );
        },
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final PatientAppointment appointment;
  final AppointmentController appointmentController =
  Get.put(AppointmentController());

   AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF78BEA4), Colors.blueGrey.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointment.doctorName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    appointmentController.appointments.remove(appointment);
                  },
                ),
              ],
            ),

            SizedBox(height: 8),
            Text(
              appointment.appointmentTime,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              appointment.appointmentDate,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              appointment.appointmentLocation,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              appointment.appointmentReason,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
