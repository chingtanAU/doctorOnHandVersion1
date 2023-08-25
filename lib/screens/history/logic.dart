import 'package:doctorppp/screens/history/view.dart';
import 'package:get/get.dart';

import 'details.dart';
import '../../validatorsAuth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitsController extends GetxController {
  // final visits = <Visit>[
  //   Visit(
  //     visitDate: 'April 1, 2023',
  //     doctorName: 'Dr. John Smith',
  //     diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //     prescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //     labTest: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //   ),
  //   Visit(
  //     visitDate: 'February 15, 2023',
  //     doctorName: 'Dr. Jane Doe',
  //     diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //     prescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //     labTest: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //   ),
  //   Visit(
  //     visitDate: 'March 10, 2022',
  //     doctorName: 'Dr. Michael Johnson',
  //     diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //     prescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //     labTest: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //   ),
  // ].obs;

  final visits = <Visit>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVisits();
  }

  Future<void> fetchVisits() async {
    final patientId = Get.find<AuthController>().currentUserId!;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Reports')
        .where('patientId', isEqualTo: patientId)
        .get();

    final fetchedVisits = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Visit(
        visitDate: data['visitDate'] ?? 'Not set for now',
        doctorName: data['doctorName'] ?? '',
        diagnosis: data['condition'] ?? '',
        prescription: data['prescription'] ?? '',
        labTest: data['details'] ?? '',
      );
    }).toList();

    visits.assignAll(fetchedVisits);
  }

  void openAppointmentDetails({
    required String visitDate,
    required String doctorName,
    required String diagnosis,
    required String prescription,
    required String labTest,
  }) {
    Get.to(
      () => AppointmentDetailsScreen(
        visitDate: visitDate,
        doctorName: doctorName,
        diagnosis: diagnosis,
        prescription: prescription,
        labTest: labTest,
      ),
    );
  }
}
