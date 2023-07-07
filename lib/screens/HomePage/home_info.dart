
import 'dart:ui';


import 'package:doctorppp/screens/history/view.dart';

import 'package:doctorppp/screens/search/view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:ionicons/ionicons.dart';
import '../../Controllers/clinicController.dart';
import '../../validatorsAuth/auth.dart';
import '../../widgets/incoming_appointments.dart';
import 'homepage.dart';


class HomeInfo extends StatelessWidget {

  HomeInfo({
    super.key,
  });

  final authController = Get.find<AuthController>();
  final clinicController = Get.find<ClinicContoller>() ;


  @override
  Widget build(BuildContext context) {
    width= MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Text(
                    "Hi! ${authController.userData.value.fName}",
                     //   "\nHow are you today?",
                    style: const TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 0,
                ),

                const IncomingCard(),

                Divider(
                  color: Colors.grey[300],
                  thickness: 0,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.01),
                  child: Text(
                    "Category",
                    style: const TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, 'book');


                         // Get.offAndToNamed('/book');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClinicSearchPage1(),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red.shade100,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(3.0,
                                      3.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Icon(
                                          Ionicons.calendar_outline,
                                          size: 75,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        "Book an Appointment",
                                        style: const TextStyle(
                                          fontFamily: "Comic Sans",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviousVisitsPage(),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red.shade100,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(3.0,
                                      3.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Icon(
                                          Icons.medical_information,
                                          size: 75,
                                          color: Colors.red,
                                          //AssetImage("assets/medical1.png"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        "Medical History",
                                        style: const TextStyle(
                                          fontFamily: "Comic Sans",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),

                Divider(
                  color: Colors.grey[300],
                  thickness: 0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.01),
                  child: Text(
                    "Nearby Hospitals/Walk In Clinics",
                    style: const TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),

                createDocWidget("doctor.png", clinicController.clinicList.value[0],"doctor"),
                createDocWidget("Image2.jpg", clinicController.clinicList.value[0],"doctor"),
                createDocWidget("Image3.jpg", clinicController.clinicList.value[0],"doctor"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
