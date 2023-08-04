import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'doctorHomePageController.dart';

class DoctorHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorHomePageController());
  }
}
