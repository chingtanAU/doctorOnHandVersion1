import 'package:doctorppp/entity/HealthCarePhacility.dart';
import 'package:doctorppp/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../entity/clinicDTO.dart';
import '../entity/visitedClinic.dart';
import '../persistance/FacilityService.dart' as facilityController;
import '../persistance/userCrud.dart' as userController;

class ClinicContoller extends GetxController {
  final Rx<List<HealthCarePhacility>> walkinClinicList =
      Rx<List<HealthCarePhacility>>(List.empty(growable: true));
  final Rx<List<HealthCarePhacility>> clinicOnlyWithAppointment =
      Rx<List<HealthCarePhacility>>(List.empty(growable: true));
  final Rx<List<VisitedClinic>> userVisitedClinic =
      Rx<List<VisitedClinic>>(List.empty(growable: true));

  RxList<ClinicDTO> clinics = <ClinicDTO>[].obs;
  final RxList<ClinicDTO> filteredClinics = <ClinicDTO>[].obs;

  final RxInt filterValue = 0.obs;

  RxString searchText = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    print("aaaaaaaaaaaa");
    await fetchAllWalkinClinic();
    await fetchAllClinicOnlyWithAppointment();
    await fetchAllUserVisitedClinic();

    print(clinicOnlyWithAppointment.value.length);

    clinics.value = clinicOnlyWithAppointment.value.map((obj1) {
      VisitedClinic? matchingObject = userVisitedClinic.value.firstWhere(
          (obj2) => obj2.idClinic == obj1.id,
          orElse: () => VisitedClinic(idClinic: "000"));
      if (matchingObject.idClinic != "000") {
        return ClinicDTO(
            idClinic: matchingObject.idClinic,
            clinicName: obj1.name,
            lastVisit: matchingObject.lastVisit,
            visitNumber: matchingObject.visitNumber);
        ;
      } else {
        return ClinicDTO(
            idClinic: obj1.id, clinicName: obj1.name, visitNumber: 0);
      }
    }).toList();

    filteredClinics.addAll(clinics);
  }

  Future<List<HealthCarePhacility>?> fetchAllWalkinClinic() async {
    await facilityController
        .fetchAllWalkinClinic()
        .then((value) => walkinClinicList.value = value);
  }

  Future<List<HealthCarePhacility>?> fetchAllClinicOnlyWithAppointment() async {
    await facilityController
        .fetchAllClinicOnlyWithAppointment()
        .then((value) => clinicOnlyWithAppointment.value = value);
  }

  Future<List<HealthCarePhacility>?> fetchAllUserVisitedClinic() async {
    await userController
        .fetchUserVisitedClinic(auth.currentUser!.uid)
        .then((value) => userVisitedClinic.value = value);
  }

  void search() {
    String query = searchText.value.toLowerCase();
    filteredClinics.value = clinics
        .where((clinic) => clinic.clinicName.toLowerCase().contains(query))
        .toList();
    applyFilter();
  }

  void applyFilter() {
    if (filterValue.value == 0) {
      filteredClinics.sort((b, a) => a.visitNumber!.compareTo(b.visitNumber!));
    }
  }

  String getDropdownText() {
    if (filterValue.value == 0) {
      return 'Number of Visits';
    } else if (filterValue.value == 1) {
      return 'Last Visit';
    }
    return '';
  }
}
