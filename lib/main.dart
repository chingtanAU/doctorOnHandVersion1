import 'package:doctorppp/screens/Clinic/bookingScreen.dart';
import 'package:doctorppp/screens/appointments/upcoming.dart';
import 'package:doctorppp/screens/detailscreen.dart';
import 'package:doctorppp/screens/editProfile/profile_page.dart';
import 'package:doctorppp/screens/homepage.dart';
import 'package:doctorppp/screens/video_calll/meet.dart';
import 'package:doctorppp/screens/video_calll/token_generation.dart';
import 'package:doctorppp/signin/login.dart';
import 'package:doctorppp/signin/register.dart';
import 'package:doctorppp/validatorsAuth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'Controllers/clinicController.dart';
import 'doctor_part/Appointments/upcoming.dart';
import 'doctor_part/HomePage/homepage.dart';
import 'doctor_part/Report/view.dart';
import 'doctor_part/completedVisits/view.dart';
import 'doctor_part/controller/doctorHomePageBinding.dart';
import 'screens/HomePage/homepage.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  await Future.delayed(Duration(seconds: 2));
  Get.lazyPut(() => ClinicContoller(), fenix: true);

  Get.put<AgoraTokenService>(AgoraTokenService());

  runApp(const MyApp());
}

@override
void initState() {}

// class ClinicBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(ClinicContoller());
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
//     return SafeArea(
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'DoctorsOnHand',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.blueGrey),
//         ),
//         home: MyLogin(),

//         routes: {
//           'register': (context) => MyRegister(),
//           'login': (context) => MyLogin(),
//           'home' : (context) => Homepage(),
//            'book' : (context) => BookingCalendarDemoApp(),
//           'detail' : (context) => DetailScreen(),
//         },

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DoctorsOnHand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLogin(),
      //home: const CircularProgressIndicator(),
      getPages: [
        GetPage(name: '/login', page: () => MyLogin()),
        GetPage(name: '/register', page: () => MyRegister()),
        // GetPage(
        //     name: '/home', page: () => Homepage(), binding: ClinicBinding()),
        GetPage(name: '/home', page: () => Homepage()),
        GetPage(name: '/book', page: () => BookingCalendarDemoApp()),
        GetPage(name: '/detail', page: () => DetailScreen()),
        GetPage(name: '/editProfile', page: () => ProfilePage()),
        GetPage(
            name: '/doctorHomePage',
            page: () => DoctorHomepage(),
            binding: DoctorHomePageBinding()),
        GetPage(name: '/appointment', page: () => AppointmentScreen()),
        GetPage(name: '/completed', page: () => CompletedVisitsScreen()),
        GetPage(name: '/report', page: () => ReportScreen()),
        GetPage(name: '/patient', page: () => PatientAppointmentScreen())
      ],

//     return SafeArea(
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'DoctorsOnHand',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.blueGrey),
//         ),
//         home: MyLogin(),

//         routes: {
//           'register': (context) => MyRegister(),
//           'login': (context) => MyLogin(),
//           'home' : (context) => Homepage()
//         },
//       ),
// >>>>>>> main
    );
  }
}
