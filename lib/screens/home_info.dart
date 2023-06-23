import 'dart:ui';


import 'package:doctorppp/screens/history/view.dart';
import 'package:doctorppp/screens/search/logic.dart';
import 'package:doctorppp/screens/search/model.dart';
import 'package:doctorppp/screens/search/view.dart';
import 'package:doctorppp/widgets/singlecategory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

import '../constraints.dart';
import '../globals.dart' as globals;
import '../validatorsAuth/auth.dart' as auth;
import '../validatorsAuth/auth.dart';
import '../widgets/incoming_appointments.dart';
import 'detailscreen.dart';
import 'homepage.dart';
import 'login.dart';
import 'notifcationScreen.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    "Hi! Jhon",
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

                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Container(
                    //       height: height * 0.2,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         color: Colors.red.shade100,
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.grey,
                    //             blurRadius: 3.0,
                    //             spreadRadius: 3.0,
                    //             offset: Offset(3.0, 3.0), // shadow direction: bottom right
                    //           )
                    //         ],
                    //
                    //       ),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //
                    //           Column(
                    //             children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    //                 child: ClipRRect(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   child: Icon(
                    //                     Ionicons.calendar_outline,
                    //                     size: 75,
                    //                     color: Colors.teal,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.fromLTRB(8,0,8,0),
                    //                 child: Text(
                    //                   "Book an Appointment",
                    //                   style: TextStyle(
                    //                     fontFamily: "Comic Sans",
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 15,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                    style: TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                //
                // Container(
                //   height: height * 0.22,
                //   // color: Colors.amber,
                //   padding: EdgeInsets.only(left:width * 0.04 ),
                //   child: GridView.builder(
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //     ),
                //
                //     // scrollDirection: Axis.horizontal,
                //     itemCount: itemCategory.length,
                //     itemBuilder: (context, index) {
                //       return SingleCategory(
                //         image: itemCategory[index]["image"].toString(),
                //         name: itemCategory[index]["name"].toString(),
                //         doctors: itemCategory[index]["stuff"].toString(),
                //         color: itemCategory[index]["color"] as Color,
                //       );
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: height * 0.02,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: SizedBox(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Top Rated Doctor",
                //           style: TextStyle(
                //             fontFamily: "Comic Sans",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 22,
                //           ),
                //         ),
                //         Text(
                //           "See All",
                //           style: TextStyle(
                //             fontFamily: "Comic Sans",
                //             fontWeight: FontWeight.w400,
                //             fontSize: 22,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(
                //     horizontal: 15,
                //   ),
                //   child: GridView.count(
                //     shrinkWrap: true,
                //     crossAxisSpacing: 8.0,
                //     mainAxisSpacing: 8.0,
                //     childAspectRatio: 0.85,
                //     physics: NeverScrollableScrollPhysics(),
                //     crossAxisCount: 2,
                //     children: List.generate(doctorItem.length, (index) {
                //       return GestureDetector(
                //         onTap: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //             builder: (ctx) => DetailScreen(),
                //           ));
                //         },
                //         child:  doctors(
                //           image: doctorItem[index]["image"].toString(),
                //           name: doctorItem[index]["name"].toString(),
                //           specialist:
                //               doctorItem[index]["specialist"].toString(),
                //         ),
                //       );
                //     }),
                //   ),
                // ),
                createDocWidget("Image.jpg", "Susan Thomas"),
                createDocWidget("Image2.jpg", "Paul Barbara"),
                createDocWidget("Image3.jpg", "Nancy Williams"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
