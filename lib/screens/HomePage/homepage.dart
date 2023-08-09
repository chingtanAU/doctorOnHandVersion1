import 'package:doctorppp/screens/Clinic/clinicdetails.dart';
import 'package:doctorppp/screens/HomePage/home_info.dart';
import 'package:doctorppp/signin/profile.dart';
import 'package:doctorppp/screens/search/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../Controllers/clinicController.dart';
import '../../entity/HealthCarePhacility.dart';
import '../../globals.dart' as globals;
import '../../validatorsAuth/auth.dart';
import '../../widgets/appbar.dart';
import '../../widgets/chat/ChatList.dart';
import '../../widgets/notifcationScreen.dart';
import '../ocr/image_input.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  final clinicController = Get.find<ClinicContoller>();
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    globals.auth.authStateChanges().listen((User? user) {
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
late double width;

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  //final AuthController authController = Get.find<AuthController>();
  double xoffset = 0;
  double yoffset = 0;
  double scaleFactor = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: size.height * 0.09,
              // color: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name.length <= 15
                      ? Text(
                          name,
                          style: const TextStyle(
                            fontFamily: "Comic Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : Text(
                          name,
                          style: const TextStyle(
                            fontFamily: "Comic Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                        ),
                  Text(
                    specialist,
                    style: const TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  const Row(
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

  int _currentIndex = 0;
  List page = [
    HomeInfo(),
    const ChatList(),
    const PatientProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    var actions3 = [
      Obx(() {
        if (Get.find<NotificationController>().notifications.isEmpty) {
          return IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                Get.to(NotificationPage());
              });
        } else {
          return IconButton(
              icon: const Icon(Icons.notifications_active),
              onPressed: () {
                Get.to(NotificationPage());
              });
        }
      }),
    ];

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      //new line
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
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
              )),
              accountName: Text(
                  '${widget.authController.userData.value.fName} ${widget.authController.userData.value.lName}'),
              accountEmail: Text(widget.authController.userData.value.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('OCR'),
              onTap: () {
                // Handle item tap
                Get.to(() => ImageInputScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_sharp),
              title: Text('Profile'),
              onTap: () {
                Get.toNamed("/editProfile");
                // Handle item tap
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () {
                widget.authController.logOut();
                Get.offAllNamed("/login");
                // Handle item tap
              },
            ),
          ],
        ),
      ),

      appBar: CustomAppBar(
          IconButton(icon: const Icon(Icons.menu), onPressed: _openDrawer),
          actions3),

      body: page[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
              tabBackgroundGradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.lightBlue[100]!, Colors.cyan],
              ),
              color: Colors.grey[600],
              activeColor: Colors.white,
              rippleColor: Colors.grey[800]!,
              hoverColor: Colors.grey[700]!,
              iconSize: 20,
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),
              tabBackgroundColor: Colors.grey[900]!,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
              duration: const Duration(milliseconds: 800),
              gap: 8,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.message_sharp,
                  text: 'Messages',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              onTabChange: (index) {
                setState(() => _currentIndex = index);
              }),
        ),
      ),
    );
  }
}

// Container createDocWidget(String imgName,HealthCarePhacility clinic, String docName ) {
//   return Container(
//     margin: const EdgeInsets.all(
//       8,
//     ),
//     decoration: BoxDecoration(
//       color: Colors.white.withOpacity(0.8),
//       // color: Theme.of(context as BuildContext).primaryColor.withOpacity(0.8),
//       borderRadius: BorderRadius.circular(20),
//       //boxShadow: kElevationToShadow[6],
//       boxShadow: const [
//         BoxShadow(
//           color: Colors.grey,
//           blurRadius: 3.0,
//           spreadRadius: 3.0,
//           offset: Offset(3.0, 3.0), // shadow direction: bottom right
//         )
//       ],
//     ),
//     child: InkWell(
//       child: Container(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(12),
//           ),
//           color: Colors.cyan,
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(7),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               Container(
//                 width: 70,
//                 height: 90,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/$imgName'),
//                         fit: BoxFit.cover)),
//               ),
//               SizedBox(
//                 width: width * 0.03,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Text(
//                     " $docName",
//                     style: const TextStyle(
//                       fontFamily: "Comic Sans",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: height * 0.02),
//                   const SizedBox(
//                     width: 250,
//                     height: 50,
//                     child: Text(
//                       "A brief about the doctor to be added here. This is more like an introduction about the doctor",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       overflow: TextOverflow.clip,
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//       onTap: () {
//         //Get.to(() => ClinicDetails());
//         Get.to(() => ClinicDetails(
//               clinic: Clinic(
//                 id: 2,
//                 name: clinic.name,
//                 visits:10 ,
//                 lastVisit: '2023-02-01',
//                 imageUrl: 'assets/doctor.png',
//                 description:
//                     clinic.desc!,
//               ),
//             ));
//         //Get.offNamed('/detail');
//
//         print('tapped ');
//       },
//     ),
//   );
// }
