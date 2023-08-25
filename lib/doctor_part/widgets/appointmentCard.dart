import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctorppp/doctor_part/Appointments/upcoming.dart';
import 'package:doctorppp/doctor_part/Patient/PatientPage.dart';
import 'package:doctorppp/entity/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import 'package:doctorppp/doctor_part/video_calll/meet.dart';
import '../../validatorsAuth/auth.dart';
import '../controller/doctorHomePageController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncomingCard extends StatefulWidget {
  IncomingCard({
    Key? key,
  }) : super(key: key);

  @override
  State<IncomingCard> createState() => _IncomingCardState();
}

class _IncomingCardState extends State<IncomingCard> {
  final doctorHomePageController = Get.find<DoctorHomePageController>();
  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    BookingService? earliestMeet = doctorHomePageController.getEaliestMeeting();
    UserProfile? patientData;

    if (earliestMeet != null) {
      doctorHomePageController
          .getPatientData(earliestMeet)
          .then((value) => patientData = value);
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<String?> getPatientIdByAttributes(
        String fName, String lName, String email) async {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('fName', isEqualTo: fName)
          .where('lName', isEqualTo: lName)
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      }
      return null;
    }

    return InkWell(
      onTap: () {
        print('qssssssssssssssss ${patientData}');

        Get.to(() => PatientPage(u: patientData));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width * 1,
          height: height * 0.25,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          decoration: BoxDecoration(
            //color: Color(0xff78bea4),
            gradient: LinearGradient(
              colors: [Color(0xff78bea4), Colors.blueGrey.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            //boxShadow: kElevationToShadow[6],
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
                spreadRadius: 3.0,
                offset: Offset(3.0, 3.0), // shadow direction: bottom right
              )
            ],
          ),
          child: earliestMeet == null
              ? Center(
                  child: Text(
                    "No upcoming appointments",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              : Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 016),
                          child: Text(
                            "Appointments",
                            style: TextStyle(
                              fontFamily: "Comic Sans",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
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
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * 0.62,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2.0, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              earliestMeet.userName!,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              earliestMeet.serviceName!,
                                              //earliestMeet.description==null? "": earliestMeet.description! ,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: Colors.white70,
                                                  ),
                                            ),
                                            SizedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 6,
                                                        horizontal: 8.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white10,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Ionicons
                                                                .location_outline,
                                                            size: 18,
                                                            color: Colors.white,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 6,
                                                                    right: 14),
                                                            child: Text(
                                                              appointmentController
                                                                  .appointments[
                                                                      0]
                                                                  .appointmentLocation,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.058),
                                                  //  IconButton(
                                                  //  icon: Icon(Icons.call , color: Colors.greenAccent,),
                                                  //   iconSize: 30,
                                                  //   color: Colors.white,
                                                  //   onPressed: () {  String doctorId = 'doctor1'; // Replace with the actual doctor ID
                                                  //   String patientId = 'patient3'; // Replace with the actual patient ID
                                                  //   Get.to(
                                                  //       VideoCallScreen(doctorId: doctorId, patientId: patientId)); },
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.call),
                                          color: Colors.greenAccent,
                                          onPressed: () async {
                                            String doctorId =
                                                authController.currentUserId!;
                                            String? patientId =
                                                await getPatientIdByAttributes(
                                                    patientData?.fName ??
                                                        'defaultFName',
                                                    patientData?.lName ??
                                                        'defaultLName',
                                                    patientData?.email ??
                                                        'defaultEmail');

                                            if (patientId != null) {
                                              Get.to(VideoCallScreen(
                                                  doctorId: authController.userData.value.fName+authController.userData.value.lName,
                                                   patientId:
                                                   '${patientData?.fName ?? 'defaultFName'}${patientData?.lName ?? 'defaultLName'}'));
                                            } else {
                                              // Handle the null value, maybe show an error message to the user
                                              print(
                                                  "Error: Patient ID not found.");
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Ionicons.calendar_outline,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 6, right: 14),
                                        child: Text(
                                          earliestMeet.bookingStart.year
                                                  .toString() +
                                              "-" +
                                              earliestMeet.bookingStart.month
                                                  .toString() +
                                              "-" +
                                              earliestMeet.bookingStart.day
                                                  .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Icon(
                                          Ionicons.time_outline,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        earliestMeet.bookingStart.hour
                                                .toString() +
                                            ":" +
                                            earliestMeet.bookingStart.minute
                                                .toString() +
                                            " - " +
                                            earliestMeet.bookingEnd.hour
                                                .toString() +
                                            ":" +
                                            earliestMeet.bookingEnd.minute
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
