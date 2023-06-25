import 'dart:ffi';

import 'package:uuid/uuid.dart';

class HealthCarePhacility {

  var id;
  String type;
  String name ;
  String address;
  bool enableReview  ;

  HealthCarePhacility({required this.type ,required this.id, required this.name, required this.address, this.enableReview= true,});

  factory HealthCarePhacility.fromJson(Map<String, dynamic> json) => HealthCarePhacility(
    id: json["id"],
    type: json["type"],
    name:json["name"],
    address:json["address"],
    enableReview:json["enableReview"],
  );

  Map<String, dynamic> toJson() => {
    'type':type,
    'id':id,
    'name':name,
    'address':address,
    'enableReview':enableReview,
  };

}

