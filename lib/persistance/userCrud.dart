import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorppp/entity/DoctorProfile.dart';
import 'package:doctorppp/entity/visitedClinic.dart';
import '../entity/userProfile.dart';
import '../globals.dart';

final CollectionReference userCollection = firestore.collection("Users");


Future<void> addUser(String uid,Map<String, dynamic> user) async {
 await userCollection.doc(uid).set(user);
}

Future<List<VisitedClinic>> fetchUserVisitedClinic(String id) async{

  QuerySnapshot<Object?> snapshot =
  await userCollection.doc(id).collection("visitedClinic").get();
  return snapshot.docs
      .map((docSnapshot) =>VisitedClinic.fromJson(docSnapshot as DocumentSnapshot<Map<String, dynamic>>))
      .toList();
}


Future<DoctorProfile?> fetchDoctorInfo(String id) async{
  DoctorProfile? doctor ;
  await userCollection.doc(id).get().then((doc) {
    print(doc.data());
    final data = doc.data() as Map<String, dynamic>;
    doctor= DoctorProfile.fromJson(data);

  }
  );
  return doctor;
}

Future<UserProfile?> fetchUserInfo(String id) async{
  UserProfile? user ;
  await userCollection.doc(id).get().then((doc) {
    print(doc.data());
    final data = doc.data() as Map<String, dynamic>;
    user= UserProfile.fromJson(data);
    print(user?.address);
  }
  );
  return user;
}

Future<DoctorProfile> getDoctorByClinicId(String? clinicId) async{
  DoctorProfile doctor;
  QuerySnapshot querySnapshot = await
       userCollection.where("clinicId", isEqualTo: clinicId)
      .get();
  DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
  Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  doctor= DoctorProfile.fromJson(data);
  doctor.id=documentSnapshot.id;
  return doctor;

}


Future<void> updateUser(String uid, Map<String, dynamic> value ) async {
  await userCollection.doc(uid).update(value);
}


Future<void> addmeetingUser(String uid,String meetId,Map<String, dynamic> value ) async {
  await userCollection.doc(uid).collection("oppointment").doc(meetId).set(value);
}


Future<List<BookingService>> fetchUserMeetings(String id) async{

  QuerySnapshot<Object?> snapshot =
  await userCollection.doc(id).collection("oppointment").get();
  return snapshot.docs
      .map((docSnapshot) =>BookingService.fromJson(docSnapshot.data() as Map<String, dynamic>))
      .toList();
}










