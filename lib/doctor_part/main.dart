// import 'package:doctorppp/doctor_part/HomePage/homepage.dart';
// import 'package:doctorppp/doctor_part/Report/form.dart';
// import 'package:doctorppp/doctor_part/Report/report.dart';
// import 'package:doctorppp/doctor_part/Report/view.dart';
// import 'package:doctorppp/doctor_part/signin/login.dart';
// import 'package:doctorppp/doctor_part/video_calll/meet.dart';
// import 'package:doctorppp/doctor_part/video_calll/token_generation.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'Appointments/upcoming.dart';
// import 'completedVisits/view.dart';
// // Future<void> main() async {
// //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
// //     statusBarIconBrightness: Brightness.dark,
// //     statusBarColor: Colors.transparent,
// //   ));
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp().then((value) => Get.put(AuthController()));
//
// //
// // void main() {
// // Get.put<AgoraTokenService1>(AgoraTokenService1());
// //
// // runApp(const MyApp());
// // }
//
// @override
// void initState() {
// }
//
//
// class MyApp1 extends StatelessWidget {
//
//
//   const MyApp1({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//
// //     return SafeArea(
// //       child: GetMaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         title: 'DoctorsOnHand',
// //         theme: ThemeData(
// //           colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.blueGrey),
// //         ),
// //         home: MyLogin(),
//
// //         routes: {
// //           'register': (context) => MyRegister(),
// //           'login': (context) => MyLogin(),
// //           'home' : (context) => Homepage(),
// //            'book' : (context) => BookingCalendarDemoApp(),
// //           'detail' : (context) => DetailScreen(),
// //         },
//
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'DoctorsOnHand',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialBinding: BindingsBuilder(() {
//         Get.put(CompletedVisitsController());
//       }),
//       home: MyLogin1(),
//       //home: const CircularProgressIndicator(),
//       getPages: [
//         GetPage(name: '/login', page: () => MyLogin1()),
//         // GetPage(name: '/register', page: () => MyRegister()),
//          GetPage(name: '/home1',  page: () => DoctorHomepage()),
//         // GetPage(name: '/book',  page: () => BookingCalendarDemoApp()),
//         // GetPage(name: '/detail',  page: () => DetailScreen()),
//         GetPage(name: '/appointment', page: () => AppointmentScreen()),
//           GetPage(name: '/completed', page: () => CompletedVisitsScreen()),
//         GetPage(name: '/report', page: () => ReportScreen()),
//       ],
//
//
// //     return SafeArea(
// //       child: GetMaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         title: 'DoctorsOnHand',
// //         theme: ThemeData(
// //           colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.blueGrey),
// //         ),
// //         home: MyLogin(),
//
// //         routes: {
// //           'register': (context) => MyRegister(),
// //           'login': (context) => MyLogin(),
// //           'home' : (context) => Homepage()
// //         },
// //       ),
// // >>>>>>> main
//     );
//   }
// }
