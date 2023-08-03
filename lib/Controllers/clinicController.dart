


import 'package:doctorppp/entity/HealthCarePhacility.dart';
import 'package:doctorppp/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../entity/clinicDTO.dart';
import '../entity/visitedClinic.dart';
import '../persistance/FacilityService.dart'  as facilityController;
import '../persistance/userCrud.dart'  as userController;

class ClinicContoller extends GetxController {

   final  Rx<List<HealthCarePhacility>> walkinClinicList= Rx<List<HealthCarePhacility>>(List.empty(growable: true)) ;
   final  Rx<List<HealthCarePhacility>> clinicOnlyWithAppointment= Rx<List<HealthCarePhacility>>(List.empty(growable: true)) ;
   final  Rx<List<VisitedClinic>> userVisitedClinic= Rx<List<VisitedClinic>>(List.empty(growable: true)) ;
  
    RxList<ClinicDTO> clinics = <ClinicDTO>[].obs;
   final RxList<ClinicDTO> filteredClinics = <ClinicDTO>[].obs;
   final TextEditingController searchController = TextEditingController();
   final RxInt filterValue = 0.obs;

   @override
   Future<void>onInit() async {
     super.onInit();
     print("aaaaaaaaaaaa");
    await fetchAllWalkinClinic();
    await fetchAllClinicOnlyWithAppointment();
    await fetchAllUserVisitedClinic();

    print(clinicOnlyWithAppointment.value.length);

     clinics.value = clinicOnlyWithAppointment.value.map((obj1) {
       VisitedClinic? matchingObject = userVisitedClinic.value.firstWhere((obj2) => obj2.idClinic == obj1.id, orElse: () => VisitedClinic(idClinic: "000"));
      if (matchingObject.idClinic != "000") {
        return   ClinicDTO(idClinic:matchingObject.idClinic,clinicName:obj1.name,lastVisit:matchingObject.lastVisit,visitNumber: matchingObject.visitNumber );
        ;
      } else {
        // Add treatment for when the id does not exist in l2
        return ClinicDTO(idClinic:obj1.id,clinicName: obj1.name,visitNumber: 0);
      }
    }).toList();

     filteredClinics.addAll(clinics);
     searchController.addListener(search);


   }

   Future<List<HealthCarePhacility>?> fetchAllWalkinClinic() async{
     await facilityController.fetchAllWalkinClinic().then((value) => walkinClinicList.value=value);
   }

   Future<List<HealthCarePhacility>?> fetchAllClinicOnlyWithAppointment() async{
     await facilityController.fetchAllClinicOnlyWithAppointment().then((value) => clinicOnlyWithAppointment.value=value);
   } 
   
   Future<List<HealthCarePhacility>?> fetchAllUserVisitedClinic() async{
     await userController.fetchUserVisitedClinic(auth.currentUser!.uid).then((value) => userVisitedClinic.value=value);
   }

   // @override
   // void onInit() {
   //   super.onInit();
   //   clinics.addAll([
   //     Clinic(
   //       id: 1,
   //       name: 'ABC Clinic',
   //       visits: 15,
   //       lastVisit: '2022-03-01',
   //       imageUrl: 'assets/medical1.png',
   //       description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
   //     ),
   //     Clinic(
   //       id: 2,
   //       name: 'XYZ Clinic',
   //       visits: 10,
   //       lastVisit: '2023-02-01',
   //       imageUrl: 'assets/doctor.png',
   //       description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
   //     ),
   //     // Add more clinics here
   //   ]);
   //   filteredClinics.addAll(clinics);
   //   searchController.addListener(search);
   // }

   @override
   void onClose() {
     searchController.dispose();
     super.onClose();
   }

   void search() {
     String query = searchController.text.toLowerCase();
     filteredClinics.value = clinics
         .where((clinic) => clinic.clinicName.toLowerCase().contains(query))
         .toList();
     applyFilter();
   }

   void applyFilter() {
     if (filterValue.value == 0) {
       filteredClinics.sort((b, a) => a.visitNumber!.compareTo(b.visitNumber!));
     }
     // else
     // {
     //   filteredClinics.sort((b, a) => a.lastVisit.compareTo(b.lastVisit));
     // }
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