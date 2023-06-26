import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model.dart';

class ClinicSearchController extends GetxController {
  final RxList<Clinic> clinics = <Clinic>[].obs;
  final RxList<Clinic> filteredClinics = <Clinic>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxInt filterValue = 0.obs;

  @override
  void onInit() {
    super.onInit();
    clinics.addAll([
      Clinic(
        id: 1,
        name: 'ABC Clinic',
        visits: 15,
        lastVisit: '2022-03-01',
        imageUrl: 'assets/medical1.png',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      ),
      Clinic(
        id: 2,
        name: 'XYZ Clinic',
        visits: 10,
        lastVisit: '2023-02-01',
        imageUrl: 'assets/doctor.png',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      ),
      // Add more clinics here
    ]);
    filteredClinics.addAll(clinics);
    searchController.addListener(search);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void search() {
    String query = searchController.text.toLowerCase();
    filteredClinics.value = clinics
        .where((clinic) => clinic.name.toLowerCase().contains(query))
        .toList();
    applyFilter();
  }

  void applyFilter() {
    if (filterValue.value == 0) {
      filteredClinics.sort((b, a) => a.visits.compareTo(b.visits));
    } else {
      filteredClinics.sort((b, a) => a.lastVisit.compareTo(b.lastVisit));
    }
  }
  String getDropdownText() {
    if (filterValue.value == 0) {
      return 'Number of Visits';
    } else if(filterValue.value == 1) {
      return 'Last Visit';
    }
    return '';
  }
}
