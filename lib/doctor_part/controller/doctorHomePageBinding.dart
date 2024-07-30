import 'package:get/get.dart';

import 'doctorHomePageController.dart';

class DoctorHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DoctorHomePageController());
  }
}
