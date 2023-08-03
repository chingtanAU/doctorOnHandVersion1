import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'model.dart';
import 'package:get/get.dart  ';
import 'package:flutter/material.dart';

class PatientController extends GetxController {
  final List<PatientVisit> visits = [
    PatientVisit(
      title: 'Visit 1',
      date: '05/15/2021',
      diagnosis: 'Cough',
      report: 'The patient has a cough and was prescribed cough syrup.',
    ),
    PatientVisit(
      title: 'Visit 2',
      date: '06/01/2021',
      diagnosis: 'Fever',
      report: 'The patient had a fever and was prescribed antibiotics.',
    ),
    PatientVisit(
      title: 'Visit 3',
      date: '06/15/2021',
      diagnosis: 'Sore throat',
      report: 'The patient has a sore throat and was prescribed lozenges.',
    ),
  ];

  final Rx<PatientVisit?> currentVisit = Rx<PatientVisit?>(null);

  void showVisitDetails(PatientVisit visit) {
    Get.dialog(
      AlertDialog(
        title: Text(visit.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Visit Date: ${visit.date}'),
              const SizedBox(height: 8),
              Text('Diagnosis: ${visit.diagnosis}'),
              const SizedBox(height: 8),
              Text('Report: ${visit.report}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void setCurrentVisit(PatientVisit visit) {
    currentVisit.value = visit;
  }
}
