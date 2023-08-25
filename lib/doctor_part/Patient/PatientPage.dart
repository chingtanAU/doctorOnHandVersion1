import 'package:doctorppp/doctor_part/Patient/controller.dart';
import 'package:doctorppp/doctor_part/video_calll/meet.dart';
import 'package:doctorppp/doctor_part/video_calll/token_generation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../validatorsAuth/auth.dart';
import '../../entity/userProfile.dart';
import '../../screens/video_calll/token_generation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientPage extends StatelessWidget {
  final PatientController _controller = Get.put(PatientController());
  final agora = Get.put(AgoraTokenService1());
  UserProfile? u;
  PatientPage({super.key, this.u});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
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
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Name: ${u?.fName} ${u?.lName}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   'Age: 35',
                  //   style: Theme.of(context).textTheme.subtitle1,
                  //  ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   'Gender: Male',
                  //   style: Theme.of(context).textTheme.subtitle1,
                  // ),
                  // const SizedBox(height: 8),
                  Text(
                    'Address: ${u?.address}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Phone: ${u?.phone}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${u?.email}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Previous Visits',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            for (final visit in _controller.visits)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InkWell(
                  onTap: () {
                    _controller.showVisitDetails(visit);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          visit.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Visit Date: ${visit.date}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Diagnosis: ${visit.diagnosis}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Obx(() {
            //     final currentVisit = _controller.currentVisit.value;
            //     if (currentVisit == null) {
            //       return ElevatedButton(
            //         onPressed: () {
            //           _controller.currentVisit(_controller.visits.first);
            //         },
            //         child: const Text('Start Visit'),
            //       );
            //     }
            //     return Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Current Visit',
            //           style: Theme.of(context).textTheme.headline6,
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           'Visit Title: ${currentVisit.title}',
            //           style: Theme.of(context).textTheme.subtitle1,
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           'Visit Date: ${currentVisit.date}',
            //           style: Theme.of(context).textTheme.subtitle1,
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           'Diagnosis: ${currentVisit.diagnosis}',
            //           style: Theme.of(context).textTheme.subtitle1,
            //         ),
            //         const SizedBox(height: 8),
            //         TextButton(
            //           onPressed: () {
            //             _controller.showVisitDetails(currentVisit);
            //           },
            //           child: const Text('View Report'),
            //         ),
            //       ],
            //     );
            //   }),
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          String? doctorId = authController.currentUserId; // This is nullable

          // Fetch the patient ID from Firestore
          String patientId = '';
          QuerySnapshot snapshot = await FirebaseFirestore.instance
              .collection('Users')
              .where('fName', isEqualTo: u?.fName)
              .where('lName', isEqualTo: u?.lName)
              .where('email', isEqualTo: u?.email)
              .get();

          if (snapshot.docs.isNotEmpty) {
            patientId = snapshot.docs.first.id;
          }

          if (doctorId != null && patientId != null) {
            // Get.to(() =>
            //     VideoCallScreen(doctorId: doctorId, patientId: patientId));
            Get.to(VideoCallScreen(
                doctorId: authController.userData.value.fName +
                    authController.userData.value.lName,
                patientId:
                    '${u?.fName ?? 'defaultFName'}${u?.lName ?? 'defaultLName'}'));
          } else {
            //Toast message
            // Get.snackbar(
            //   'Error',
            //   'Doctor ID or Patient ID not found',
            //   snackPosition: SnackPosition.BOTTOM,
            //   backgroundColor: Colors.red,
            //   colorText: Colors.white,
            // );

            //Alert message
            Get.defaultDialog(
              title: 'Error',
              middleText: 'Doctor ID or Patient ID not found',
              backgroundColor: Colors.red,
              titleStyle: TextStyle(color: Colors.white),
              middleTextStyle: TextStyle(color: Colors.white),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          }
        },
        // ... other properties of the button
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xff575de3),
          ),
        ),
        child: const Text('Start Appointment'),
      ),
    );
  }
}
