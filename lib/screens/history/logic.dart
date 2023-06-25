import 'package:doctorppp/screens/history/view.dart';
import 'package:get/get.dart';

class VisitsController extends GetxController {
  final visits = <Visit>[
    Visit(
      visitDate: 'April 1, 2023',
      doctorName: 'Dr. John Smith',
      diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    Visit(
      visitDate: 'February 15, 2023',
      doctorName: 'Dr. Jane Doe',
      diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    Visit(
      visitDate: 'March 10, 2022',
      doctorName: 'Dr. Michael Johnson',
      diagnosis: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
  ].obs;
}