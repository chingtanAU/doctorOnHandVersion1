


import 'package:doctorppp/entity/HealthCarePhacility.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../persistance/FacilityService.dart'  as facilityController;
class ClinicContoller extends GetxController {

   late Rx<List<HealthCarePhacility>> clinicList= Rx<List<HealthCarePhacility>>(List.empty(growable: true)) ;
   
   @override
   Future<void>onInit() async {
    await fetchAllWalkinClinic();
    super.onInit();
  }

   Future<List<HealthCarePhacility>?> fetchAllWalkinClinic() async{
     await facilityController.fetchAllWalkinClinic().then((value) => clinicList.value=value);
   }


}