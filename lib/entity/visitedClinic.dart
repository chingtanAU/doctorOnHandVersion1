
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitedClinic{


 String? idClinic;

 String? idDocror;
 DateTime? lastVisit;
 int? visitNumber;

 VisitedClinic(
     { this.idClinic,this.idDocror, this.lastVisit, this.visitNumber});

 factory VisitedClinic.fromJson(DocumentSnapshot<Map<String, dynamic>> json) => VisitedClinic(
   idClinic:json.id,
   idDocror:json.data()!["idDocror"],
   lastVisit: DateTime.parse(json.data()!["lastVisit"]) ,
   visitNumber:json.data()?["visitNumber"],
 );

 Map<String, dynamic> toJson() => {
   'idDocror':idDocror,
   'lastVisit':lastVisit,
   'visitNumber': visitNumber,
 };



}