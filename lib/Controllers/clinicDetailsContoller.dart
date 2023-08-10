import 'package:doctorppp/entity/DoctorProfile.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../persistance/userCrud.dart' as userCrud;
import '../entity/userProfile.dart';

class ClinicDetailsContoller extends GetxController {
  Rx<DoctorProfile> doctorData = Rx<DoctorProfile>(DoctorProfile.empty());
  RxString doctorId = "".obs;

  Future<DoctorProfile?> setDoctordata(String? clinicId) async {
    await userCrud.getDoctorByClinicId(clinicId).then((value) {
      doctorData.value = value!;
      doctorId.value = value.id ?? "";
    });
    print(doctorData.value.email);
    print(doctorData.value.fName);
    print(doctorData.value.id);
    print(doctorData.value.speciality);
    print(doctorData.value.clinicId);
  }
}
