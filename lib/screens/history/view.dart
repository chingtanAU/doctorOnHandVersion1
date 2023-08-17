import 'package:doctorppp/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'state.dart';
import 'logic.dart';

class PreviousVisitsPage extends StatelessWidget {
  final visitsController = Get.put(VisitsController());
 List<Obx> actions2= [];

  PreviousVisitsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(const IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: null,), actions2),
      body: Obx(
            () => ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: visitsController.visits.length,
          itemBuilder: (context, index) {
            final visit = visitsController.visits[index];
            return GestureDetector(
              onTap: () {
                visitsController.openAppointmentDetails(
                  visitDate: visit.visitDate,
                  doctorName: visit.doctorName,
                  diagnosis: visit.diagnosis,
                  prescription: visit.prescription,
                  labTest: visit.labTest,

                );
              },
              child: MedicalVisitCard(
                visitDate: visit.visitDate,
                doctorName: visit.doctorName,
                diagnosis: visit.diagnosis,
              ),
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
  final String prescription;
  final String labTest;

  Visit({
    required this.visitDate,
    required this.doctorName,
     required this.diagnosis,
    required this.prescription,
    required this.labTest,

  });
}

