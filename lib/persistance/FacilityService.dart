import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorppp/entity/HealthCarePhacility.dart';
import '../globals.dart';

final CollectionReference walkinClinicCollection = firestore.collection("HealthCareFacilities").doc("WalkinClinic").collection("facilities");


Future<List<HealthCarePhacility>> fetchAllWalkinClinic() async{
  List<HealthCarePhacility> clinicList=[] ;
  await walkinClinicCollection.get().then((querySnapshot) {
    print('fetched');
    for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
      clinicList.add(HealthCarePhacility.fromJson(docSnapshot.data() as Map<String, dynamic> ));
    }
  }
  );
  print(clinicList);
  return clinicList;
  
}

