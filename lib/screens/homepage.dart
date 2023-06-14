import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';
import '../validatorsAuth/auth.dart' as auth;
import '../globals.dart' as globals;
import 'package:doctorppp/widgets/singlecategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constraints.dart';
import '../widgets/incoming_appointments.dart';
import 'detailscreen.dart';
import 'login.dart';
import 'package:get/get.dart';

import 'notifcationScreen.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  void initState() {

    globals.auth
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');

      } else {
        print('User is signed in!');
      }
    });



  }

  @override
  _HomepageState createState() => _HomepageState();
}
late double height;
late double  width;

class _HomepageState extends State<Homepage> {
  double xoffset = 0;
  double yoffset = 0;
  double scaleFactor = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  var itemCategory = [
    {
      "image": "/Specialities/heart.svg",
      "name": "Cardiology",
      "stuff": "85 Doctors",
      "color": Colors.red,
    },
    {
      "image": "/Specialities/Teeth.svg",
      "name": "Teeth",
      "stuff": "38 Doctors",
      "color": Colors.white,
    },
    {
      "image": "/Specialities/Bone.svg",
      "name": "Ligaments",
      "stuff": "65 Doctors",
      "color": Colors.white
    },
  ];

  var doctorItem = [
    {
      "image": "assets/Image2.jpg",
      "name": "Dr.Mary Albright",
      "specialist": "Cardiologist"
    },
    {
      "image": "assets/Image3.jpg",
      "name": "Dr.Sara James",
      "specialist": "Dentist"
    },
    {
      "image": "assets/Image4.jpg",
      "name": "Dr.Robert Dean",
      "specialist": "Cardiologist"
    },
    {
      "image": "assets/Image5.jpg",
      "name": "Dr.Anita Silva  ",
      "specialist": "orthopedist"
    },
  ];

  Widget doctors(
      {required String image,
      required String name,
      required String specialist}) {
    var size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // color: Colors.yellow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage("$image"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: size.height * 0.09,
              // color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name.length <= 15
                      ? Text(
                          name,
                          style: TextStyle(
                            fontFamily: "Comic Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : Text(
                          name,
                          style: TextStyle(
                            fontFamily: "Comic Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                        ),
                  Text(
                    specialist,
                    style: TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return
      Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true, //new line
        drawer: Drawer(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 4, // Replace with the actual number of items
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return UserAccountsDrawerHeader(
                  accountName: Text('John Doe'),
                  accountEmail: Text('johndoe@example.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                  ),
                );
              } else {
                return Column(
                  children: <Widget>[

                    index!=3 ? ListTile(
                              leading: Icon(Icons.home),
                              title: Text('Item $index'),
                              onTap: () {
                                // Handle item tap
                              },
                            ):  ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Log out'),
                      onTap: () {
                         auth.logOut();
                         Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MyLogin()));
                      },
                    ) ,
                    Divider(
                      thickness: 2.0,
                    ),
                  ],
                );
              }
            },
          ),
        ),



          appBar: AppBar(
            elevation: 9,
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
                  )
              ),
             ),

        leading: IconButton(
        icon: Icon(Icons.menu),
    onPressed: _openDrawer,

    ),
            title: Align(
                alignment: Alignment.center,
                child: Text("Doctors On Hand")),
            actions: [
        IconButton(
            icon: Icon(Icons.notifications_active_sharp),
            onPressed: (){
              Get.to(notification());
            }
      ),
    ],),



        body: SingleChildScrollView(
          child: Column(
            children: [


              Container(
                width: width,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all( width * 0.04),
                      child: Text(
                        "Hi! Saurabh\nHow are you today?",
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
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04,vertical:height*0.01),
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
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>const Homepage(),
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
                                        offset: Offset(3.0, 3.0), // shadow direction: bottom right
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
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                                            padding: const EdgeInsets.fromLTRB(8,0,8,0),
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
                                builder: (context) =>const Homepage(),
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
                                      offset: Offset(3.0, 3.0), // shadow direction: bottom right
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
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                                          padding: const EdgeInsets.fromLTRB(8,0,8,0),
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
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04,vertical:height*0.01),
                      child: Text(
                        "Nearby Hospitals",
                        style: TextStyle(
                          fontFamily: "Comic Sans",
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  }
}
