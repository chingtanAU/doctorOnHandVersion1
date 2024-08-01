import 'package:doctorppp/doctor_part/controller/doctorHomePageController.dart';
import 'package:doctorppp/screens/Clinic/bookingScreen.dart';
import 'package:doctorppp/screens/appointments/upcoming.dart';
import 'package:doctorppp/screens/detailscreen.dart';
import 'package:doctorppp/screens/editProfile/profile_page.dart';
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
import 'doctor_part/video_calll/token_generation.dart';
import 'screens/HomePage/homepage.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  tz.initializeTimeZones();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));

  final authController = Get.put(AuthController());
  Get.lazyPut(() => ClinicContoller(), fenix: true);
  Get.lazyPut(() => DoctorHomePageController(), fenix: true);
  Get.put<AgoraTokenService>(AgoraTokenService());
  Get.lazyPut(() => AgoraTokenService1());

  runApp(MyApp(authController: authController));
}

class MyApp extends StatelessWidget {
  final AuthController authController;
  const MyApp({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DoctorsOnHand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx(() {
        if (authController.isLoading.value) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (!authController.authStateChanged.value) {
          return const Scaffold(body: Center(child: Text('Waiting for auth state...')));
        } else {
          if (authController.firebaseUser.value == null) {
            return const MyLogin();
          } else {
            if (!authController.isUserDataLoaded.value) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            } else {
              if (authController.userData.value.role == "Patient") {
                return Homepage();
              } else if (authController.userData.value.role == "Doctor") {
                return DoctorHomepage();
              } else {
                return const Scaffold(body: Center(child: Text('Unknown role')));
              }
            }
          }
        }
      }),
      getPages: [
        GetPage(name: '/login', page: () => const MyLogin()),
        GetPage(name: '/register', page: () => MyRegister()),
        GetPage(name: '/home', page: () => Homepage()),
        GetPage(name: '/book', page: () => BookingCalendarDemoApp()),
        GetPage(name: '/detail', page: () => const DetailScreen()),
        GetPage(name: '/editProfile', page: () => ProfilePage()),
        GetPage(
          name: '/doctorHomePage',
          page: () => DoctorHomepage(),
          binding: DoctorHomePageBinding(),
        ),
        GetPage(name: '/appointment', page: () => AppointmentScreen()),
        GetPage(name: '/completed', page: () => CompletedVisitsScreen()),
        GetPage(name: '/report', page: () => ReportScreen()),
        GetPage(name: '/patient', page: () => PatientAppointmentScreen()),
      ],
    );
  }
}
