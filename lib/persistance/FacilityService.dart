import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorppp/entity/HealthCarePhacility.dart';
import '../globals.dart';

final CollectionReference walkinClinicCollection = firestore.collection("HealthCareFacilities").doc("WalkinClinic").collection("facilities");
final CollectionReference clinicOnlyWithAppointment = firestore.collection("HealthCareFacilities").doc("ClinicOnlyWithAppointment").collection("facilities");


Future<List<HealthCarePhacility>> fetchAllWalkinClinic() async{

  QuerySnapshot<Object?> snapshot =
  await walkinClinicCollection.get();
  return snapshot.docs
      .map((docSnapshot) =>HealthCarePhacility.fromJson(docSnapshot as DocumentSnapshot<Map<String, dynamic>>))
      .toList();
}


Future<List<HealthCarePhacility>> fetchAllClinicOnlyWithAppointment() async{

  QuerySnapshot<Object?> snapshot =
  await clinicOnlyWithAppointment.get();
  return snapshot.docs
      .map((docSnapshot) =>HealthCarePhacility.fromJson(docSnapshot as DocumentSnapshot<Map<String, dynamic>>))
      .toList();
}


Future<void> addClinicOnlyWithOppointment(String? id, Map<String, dynamic> clinic)async {
 await clinicOnlyWithAppointment.doc(id).set(clinic);
}

  //
  // List<HealthCarePhacility> clinicList=[] ;
  // await walkinClinicCollection.get().then((querySnapshot) {
  //   print('fetched');
  //   for (var docSnapshot in querySnapshot.docs) {
  //     print('${docSnapshot.id} => ${docSnapshot.data()}');
  //     clinicList.add(HealthCarePhacility.fromJson(docSnapshot));
  //   }
  // }
  // );
  // print(clinicList);
  // return clinicList;
  


