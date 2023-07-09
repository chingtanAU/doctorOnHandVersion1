import 'package:doctorppp/screens/Clinic/clinicdetails.dart';
import 'package:doctorppp/screens/HomePage/home_info.dart';
import 'package:doctorppp/signin/profile.dart';
import 'package:doctorppp/screens/search/model.dart';
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

class _HomepageState extends State<Homepage> {
  double xoffset = 0;
  double yoffset = 0;
  double scaleFactor = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
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
            const SizedBox(
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

  int _currentIndex = 0;
  List page = [
    HomeInfo(),
    ChatList(),
    PatientProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    var actions3 = [
      Obx(() {
        if (Get.find<NotificationController>().notifications.length == 0) {
          return IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {
                Get.to(NotificationPage());
              });
        } else
          return IconButton(
              icon: Icon(Icons.notifications_active),
              onPressed: () {
                Get.to(NotificationPage());
              });
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
                  )),

              accountName: Text('${widget.authController.userData.value.fName} ${widget.authController.userData.value.lName}'),
              accountEmail: Text(widget.authController.userData.value.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('OCR'),
              onTap: () {
                widget.authController.logOut();
                // Handle item tap
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
          IconButton(icon: Icon(Icons.menu), onPressed: _openDrawer), actions3),

      body: page[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
              duration: Duration(milliseconds: 800),
              gap: 8,
              tabs: [
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

Container createDocWidget(String imgName,HealthCarePhacility clinic, String docName ) {
  return Container(
    margin: EdgeInsets.all(
      8,
    ),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      // color: Theme.of(context as BuildContext).primaryColor.withOpacity(0.8),
      borderRadius: BorderRadius.circular(20),
      //boxShadow: kElevationToShadow[6],
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3.0,
          spreadRadius: 3.0,
          offset: Offset(3.0, 3.0), // shadow direction: bottom right
        )
      ],
    ),
    child: InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          color: Colors.cyan,
        ),
        child: Container(
          padding: EdgeInsets.all(7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/$imgName'),
                        fit: BoxFit.cover)),
              ),
               SizedBox(
                width: width * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    " $docName",
                    style: const TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                   SizedBox(height: height * 0.02),
                  Container(
                    width: 250,
                    height: 50,
                    child: Text(
                      "A brief about the doctor to be added here. This is more like an introduction about the doctor",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        //Get.to(() => ClinicDetails());
        Get.to(() => ClinicDetails(
              clinic: Clinic(
                id: 2,
                name: clinic.name,
                visits:10 ,
                lastVisit: '2023-02-01',
                imageUrl: 'assets/doctor.png',
                description:
                    clinic.desc!,
              ),
            ));
        //Get.offNamed('/detail');

        print('tapped ');
      },
    ),
  );
}
