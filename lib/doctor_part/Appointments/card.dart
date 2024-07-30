import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctorppp/doctor_part/Appointments/upcoming.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:doctorppp/doctor_part/completedVisits/view.dart';
import 'package:doctorppp/doctor_part/completedVisits/model.dart';


class AppointmentCard extends StatelessWidget {
  final BookingService appointment;
  final VoidCallback onPressed;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AppointmentController appointmentController =
    Get.put(AppointmentController());
    final CompletedVisitsController completedVisitsController = Get.put(CompletedVisitsController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width * 1,
          height: height * 0.21,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xff78bea4), Colors.blueGrey.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
                spreadRadius: 3.0,
                offset: Offset(3.0, 3.0), // shadow direction: bottom right
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Appointments",
                      style: TextStyle(
                        fontFamily: "Comic Sans",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        appointmentController.removeAppointment(appointment.userName.toString());
                        Visit visit = Visit(
                          patientName: appointment.userName!,
                          visitTime: DateTime.now ().toString(),
                          visitDate: DateTime.now ().toString(),
                          visitLocation: "4316 139 Avenue",
                          visitReason: "Heart Burn",
                        );

                        completedVisitsController.addCompletedVisit(visit); // Add the visit to completed visits
                        completedVisitsController.update();
                      },
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/img.png',
                      width: width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.userName!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          appointment.serviceName,
                         // appointment.description!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Ionicons.calendar_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${appointment.bookingStart.year}-${appointment.bookingStart.month}-${appointment.bookingStart.day}",
                               style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Ionicons.time_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${appointment.bookingStart.hour}:${appointment.bookingStart.minute} - ${appointment.bookingEnd.hour}:${appointment.bookingEnd.minute}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
