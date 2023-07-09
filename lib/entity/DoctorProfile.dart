
import 'package:booking_calendar/booking_calendar.dart';
import 'package:json_annotation/json_annotation.dart';

import 'HealthCarePhacility.dart';
import 'package:doctorppp/entity/userProfile.dart';


class DoctorProfile extends UserProfile {

  String speciality;

   String clinicName;

  DoctorProfile({role,fName,lName,email,address,phone,meets,picture, required this.speciality ,required this.clinicName }) : super(role:role, fName:fName , lName:lName, email: email, address: address, phone:phone, picture: picture);

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => DoctorProfile(
    fName: json["fName"],
    lName:json["lName"],
    email:json["email"],
    address:json["address"],
    phone: json["pNumber"],
    meets:json["meets"]!=null ? List<BookingService>.from(json["meets"].map((x) => BookingService.fromJson(x))):null,
    role: json["role"],
    picture: json["picture"],
    speciality: json["speciality"],
    clinicName: json["clinic"],
  );


  Map<String, dynamic> toJson() =>

      {
        'role': role,
        'fName': fName,
        'lName': lName,
        'email': email,
        'address': address,
        'pNumber': phone,
        'meets': meets,
        'picture': picture,
        'speciality': speciality,
        'clinic':clinicName,

      };


}


