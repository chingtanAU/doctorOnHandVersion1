import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctorppp/doctor_part/widgets/appointmentCard.dart';

import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import '../../validatorsAuth/auth.dart';
import '../controller/doctorHomePageController.dart';
import 'homepage.dart';
import 'package:get/get.dart';

class HomeInfo extends StatelessWidget {
  HomeInfo({
    super.key,
  });

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Text(
                    "Hi Dr. ${authController.userData.value.fName}!",
                    //   "\nHow are you today?",
                    style: TextStyle(
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
                IncomingCard(),
                Divider(
                  color: Colors.grey[300],
                  thickness: 0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.01),
                  child: const Text(
                    "Category",
                    style: TextStyle(
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
                        Get.toNamed('/appointment');
                        // Navigator.pushNamed(context, 'book');

                        // Get.offAndToNamed('/book');

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ClinicSearchPage1(),
                        //   ),
                        // );
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
                              color: Color(0xFFf4e9f3),
                              boxShadow: const [
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
                                        child: const Icon(
                                          Ionicons.calendar_outline,
                                          size: 75,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        "Appointments",
                                        style: TextStyle(
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
                        Get.toNamed('/completed');
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
                              color: Color(0xFFf4e9f3),
                              boxShadow: const [
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
                                        child: const Icon(
                                          Icons.medical_information,
                                          size: 75,
                                          color: Colors.red,
                                          //AssetImage("assets/medical1.png"),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        "Completed Visits",
                                        style: TextStyle(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, 'book');

                        // Get.offAndToNamed('/book');

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ClinicSearchPage1(),
                        //   ),
                        // );
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
                              color: Color(0xFFf4e9f3),
                              boxShadow: const [
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
                                        child: const Icon(
                                          Ionicons.time_outline,
                                          size: 75,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        "Schedule",
                                        style: TextStyle(
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
                        Get.toNamed('/report');
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PreviousVisitsPage(),
                        //   ),
                        // );
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
                              color: Color(0xFFf4e9f3),
                              boxShadow: const [
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
                                        child: const Icon(
                                          Icons.receipt_long_outlined,
                                          size: 75,
                                          color: Colors.red,
                                          //AssetImage("assets/medical1.png"),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Text(
                                        "Reports",
                                        style: TextStyle(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
