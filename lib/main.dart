import 'package:doctorppp/screens/callscreen.dart';
import 'package:doctorppp/screens/detailscreen.dart';
import 'package:doctorppp/screens/login.dart';
import 'package:doctorppp/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constraints.dart';
import 'globals.dart';
import 'screens/drawerscreen.dart';
import 'screens/homepage.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(user: user));
}

@override
void initState() {

  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });



}


class MyApp extends StatelessWidget {

  MyApp({Key? key, User? this.user}) : super(key: key);
  User? user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DoctorsOnHand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLogin(),

      routes: {
        'register': (context) => MyRegister(),
        'login': (context) => MyLogin(),
        'home' : (context) => Homepage()
      },
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Homepage(),

    );
  }
}
