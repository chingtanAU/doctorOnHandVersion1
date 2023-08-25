import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../search/view.dart';
import 'model.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctorppp/entity/DoctorProfile.dart';
import '../../Controllers/patientMeetingsController.dart';
import '../Clinic/booking_service_wrapper.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

PatientAppointment convertToPatientAppointment(
    BookingServiceWrapper bookingWrapper, DoctorProfile doctor) {
  return PatientAppointment(
    doctorName: "Dr. ${doctor.fName}",
    appointmentTime:
        "${bookingWrapper.bookingStart.hour}:${bookingWrapper.bookingStart.minute} - ${bookingWrapper.bookingEnd.hour}:${bookingWrapper.bookingEnd.minute}",
    appointmentDate:
        "${bookingWrapper.bookingStart.day}-${bookingWrapper.bookingStart.month}-${bookingWrapper.bookingStart.year}",
    appointmentLocation: doctor.address,
    appointmentReason: bookingWrapper.description ?? "No description provided",
    bookingStart: bookingWrapper.bookingStart,
    bookingEnd: bookingWrapper.bookingEnd,
    userId: bookingWrapper.userId,
  );
}

bool canCancelAppointment(DateTime appointmentTime) {
  final difference = appointmentTime.difference(DateTime.now()).inHours;
  return difference > 24;
}

Future<void> deleteAppointment(
    String? userId, DateTime bookingStart, DateTime bookingEnd) async {
  final firestore = FirebaseFirestore.instance;

  QuerySnapshot userAppointments = await firestore
      .collection('Users')
      .doc(userId)
      .collection('oppointment')
      // .where('bookingStart', isEqualTo: bookingStart)
      // .where('bookingEnd', isEqualTo: bookingEnd)
      .get();

  print("userId: $userId");

  print("Booking start: $bookingStart");
  print("Booking end: $bookingEnd");

  if (userAppointments.docs.isEmpty) {
    print("No matching appointment found!");
    return;
  }

  //print all doc id
  userAppointments.docs.forEach((element) {
    print(element.id);
  });
  DocumentSnapshot appointmentDoc = userAppointments.docs.first;
  print("Found matching appointment: ${appointmentDoc.id}");

  var data = appointmentDoc.data() as Map<String, dynamic>?;
  if (data == null) {
    throw Exception('Document data is null');
  }
  String serviceId = data['serviceId'];
  print("serviceId: $serviceId");

  await firestore
      .collection('Users')
      .doc(userId)
      .collection('oppointment')
      .doc(appointmentDoc.id)
      .delete();

  await firestore
      .collection('Meetings')
      .doc(serviceId)
      .collection('DoctorMeetings')
      .doc(appointmentDoc.id)
      .delete();
}

class AppointmentController extends GetxController {
  final RxList<PatientAppointment> appointments =
      RxList<PatientAppointment>([]);
  final PatientMeetingsController patientMeetingsController = Get.find();

  @override
  void onReady() {
    super.onReady();
    _loadAppointments();
  }

  void _loadAppointments() {
    List<BookingServiceWrapper> upcomingMeetings =
        patientMeetingsController.getUpcomingMeetings(
            patientMeetingsController.allPatientMeetings.value, DateTime.now());

    for (var bookingWrapper in upcomingMeetings) {
      DoctorProfile doctor = patientMeetingsController.earliestdoctor.value;
      appointments.add(convertToPatientAppointment(bookingWrapper, doctor));
    }
  }
}

class PatientAppointmentScreen extends StatelessWidget {
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Navigator.pushNamed(context, 'book');

          // Get.offAndToNamed('/book');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClinicSearchPage1(),
            ),
          );
          Get.delete<AppointmentController>();
        },
        child: const Text('Book Appointment'),
      ),
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
          return appointmentController.appointments.isEmpty
              ? Center(
                  child: Text(
                    'No upcoming appointments.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
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
                  onPressed: () async {
                    if (canCancelAppointment(appointment.bookingStart)) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirm Cancellation'),
                          content: Text(
                              'Do you really want to cancel the appointment?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () async {
                                appointmentController.appointments
                                    .remove(appointment);

                                String? userId = appointment.userId;
                                await deleteAppointment(
                                    userId,
                                    appointment.bookingStart,
                                    appointment.bookingEnd);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Cancellation Not Allowed'),
                          content: Text(
                              'Sorry, you can\'t cancel within 24 hours of your appointment.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        ),
                      );
                    }
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
