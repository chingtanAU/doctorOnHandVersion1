import 'package:doctorppp/screens/history/view.dart';
import 'package:get/get.dart';

import 'details.dart';

class VisitsController extends GetxController {
  final visits = <Visit>[
    Visit(
      visitDate: 'April 1, 2023',
      doctorName: 'Dr. John Smith',
      diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      prescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      labTest: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    Visit(
      visitDate: 'February 15, 2023',
      doctorName: 'Dr. Jane Doe',
      diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      prescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      labTest: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    Visit(
      visitDate: 'March 10, 2022',
      doctorName: 'Dr. Michael Johnson',
      diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      prescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      labTest: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
  ].obs;

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