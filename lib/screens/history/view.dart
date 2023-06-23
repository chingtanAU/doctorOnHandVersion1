import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'state.dart';
import 'logic.dart';

class PreviousVisitsPage extends StatelessWidget {
  final visitsController = Get.put(VisitsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Visits'),
      ),
      body: Obx(
            () => ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: visitsController.visits.length,
          itemBuilder: (context, index) {
            final visit = visitsController.visits[index];
            return MedicalVisitCard(
              visitDate: visit.visitDate,
              doctorName: visit.doctorName,
              diagnosis: visit.diagnosis,
            );
          },
        ),
      ),
    );
  }
}


class Visit {
  final String visitDate;
  final String doctorName;
  final String diagnosis;

  Visit({
    required this.visitDate,
    required this.doctorName,
    required this.diagnosis,
  });
}

