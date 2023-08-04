import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctorppp/doctor_part/Appointments/model.dart';
import 'package:doctorppp/doctor_part/Appointments/upcoming.dart';
import 'package:doctorppp/doctor_part/video_calll/meet.dart';
import 'package:doctorppp/doctor_part/Appointments/model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';

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
              colors: [Color(0xff78bea4), Colors.blueGrey.withOpacity(0.1)],
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
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16),
                child: Text(
                  "Appointments",
                  style: TextStyle(
                    fontFamily: "Comic Sans",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
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
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.userName!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          appointment.serviceName,
                         // appointment.description!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Ionicons.calendar_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              appointment.bookingStart.year.toString()+"-"+appointment.bookingStart.month.toString()+"-"+appointment.bookingStart.day.toString(),
                               style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Ionicons.time_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              appointment.bookingStart.hour.toString()+":"+appointment.bookingStart.minute.toString()+" - "+appointment.bookingEnd.hour.toString()+":"+appointment.bookingEnd.minute.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

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
