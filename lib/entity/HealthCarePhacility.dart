

import 'package:cloud_firestore/cloud_firestore.dart';

class HealthCarePhacility {
  final String? id;
  String name ;
  String address;
  String? experience;
  String number;
  String? patientNum ;
  String? rating;
  String? desc;


  HealthCarePhacility({this.id, this.experience , required this.name, required this.address,required this.number, this.patientNum, this.rating, this.desc });

  factory HealthCarePhacility.fromJson(DocumentSnapshot<Map<String, dynamic>> json) => HealthCarePhacility(
    id:json.id,
    name:json.data()!["name"],
    address:json.data()!["address"],
    experience:json.data()?["experience"],
    number: json.data()!["number"],
    patientNum: json.data()?["patientNum"],
    rating: json.data()?["rating"],
    desc: json.data()?['desc'],
  );

  Map<String, dynamic> toJson() => {

    'name':name,
    'address':address,
    'experience': experience,
    'number': number,
    'patientNum': patientNum,
    'rating': rating,
    'desc': desc
  };

}

