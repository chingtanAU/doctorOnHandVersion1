



import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../globals.dart';

final CollectionReference meetingCollection = firestore.collection("Meetings");

Future<List<BookingService>> fetchDoctorMeetings(String id) async{

  QuerySnapshot<Object?> snapshot =
  await meetingCollection.doc(id).collection("DoctorMeetings").get();
  return snapshot.docs
      .map((docSnapshot) =>BookingService.fromJson(docSnapshot.data() as Map<String, dynamic>))
      .toList();
}