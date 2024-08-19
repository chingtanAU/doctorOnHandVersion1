import 'package:doctorppp/entity/DoctorProfile.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../persistance/userCrud.dart' as userCrud;

class ClinicDetailsContoller extends GetxController {
  Rx<DoctorProfile?> doctorData = Rx<DoctorProfile?>(null);
  RxString doctorId = "".obs;

  Future<void> setDoctordata(String? clinicId) async {
    if (clinicId == null) {
      print("Clinic ID is null");
      doctorData.value = null;
      doctorId.value = "";
      return;
    }

    try {
      final doctor = await userCrud.getDoctorByClinicId(clinicId);
      if (doctor != null) {
        doctorData.value = doctor;
        doctorId.value = doctor.id ?? "";

        print("Doctor data set successfully:");
        print("Email: ${doctor.email}");
        print("Name: ${doctor.fName}");
        print("ID: ${doctor.id}");
        print("Speciality: ${doctor.speciality}");
        print("Clinic ID: ${doctor.clinicId}");
      } else {
        print("No doctor found for clinic ID: $clinicId");
        doctorData.value = null;
        doctorId.value = "";
      }
    } catch (e) {
      print("Error fetching doctor data: $e");
      doctorData.value = null;
      doctorId.value = "";
    }
  }
}
