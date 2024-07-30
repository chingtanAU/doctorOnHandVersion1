import 'dart:convert';

import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/doctorHomePageController.dart';
import 'model.dart';
import 'card.dart';

class CompletedVisitsController extends GetxController {

  final doctorHomePageController = Get.find<DoctorHomePageController>();
  var visits = <BookingService>[].obs;
  final _prefs = SharedPreferences.getInstance();

  @override
  void onInit() async {
    super.onInit();
     print("dezfezfezfezf${doctorHomePageController.allDoctrorMeetings.value.length}");
     visits.value= doctorHomePageController.getPassedMeetings(doctorHomePageController.allDoctrorMeetings.value, DateTime.now());
     print("fjksoqjfoqfq${visits.value.length}");
  }


  Future<void> clearCompletedVisits() async {
    visits.clear();
    final prefs = await _prefs;
   // prefs.remove('visits');
    update();
  }

  void addCompletedVisit(Visit visit) async {
    // Check if the visit is a duplicate
    bool isDuplicate = visits.any((v) =>
    v.userName == visit.patientName &&
        v.bookingStart == visit.visitDate);

    if (isDuplicate) {
      // Display an error message and return without adding the visit
      Get.snackbar(
        'Error',
        'This visit has already been completed.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    visits.add(visit as BookingService);
    final prefs = await _prefs;
    final visitsJson = jsonEncode(visits.toList());
    prefs.setString('visits', visitsJson);
    update();
  }


// void addCompletedVisit(Visit visit) async {
  //     // Check if the visit is a duplicate
  //     bool isDuplicate = visits.any((v) =>
  //     v.patientName == visit.patientName &&
  //         v.visitDate == visit.visitDate);
  //
  //     if (isDuplicate) {
  //       // Display an error message and return without adding the visit
  //       Get.snackbar(
  //         'Error',
  //         'This visit has already been completed.',
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //       return;
  //     }
  //   visits.add(visit);
  //   final prefs = await _prefs;
  //   final visitsJson = jsonEncode(visits.toList());
  //   prefs.setString('visits', visitsJson);
  //   update();
  // }


}



class CompletedVisitsScreen extends StatelessWidget {
  final CompletedVisitsController completedVisitsController = Get.find<CompletedVisitsController>();

  const CompletedVisitsScreen({super.key});
  //
  // void updateVisits() {
  //   controller.update();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Visits'),
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

        actions: [
          IconButton(
            icon: const Icon(Icons.delete // Icons.add;
    ),
            onPressed: () {
             completedVisitsController.clearCompletedVisits();
            },
          ),
        ],
      ),
      body: GetBuilder<CompletedVisitsController>(
       // init: controller,
        builder: (controller) => ListView.builder(
          itemCount: controller.visits.value.length,
          itemBuilder: (context, index) {
            BookingService visit = controller.visits.value[index];
            return VisitCard(
              visit: visit,
            );
          },
        ),
      ),
    );
  }
}