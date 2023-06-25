import 'package:cloud_firestore/cloud_firestore.dart';
import '../globals.dart';

final CollectionReference facilityCollection = firestore.collection("HealthCareFacilities");




Future<void> addFacility(Map<String, dynamic> facility) async {

  await facilityCollection.doc(facility['type']).collection('data').add(facility);

}