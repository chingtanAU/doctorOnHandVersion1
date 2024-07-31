import 'package:booking_calendar/booking_calendar.dart';

import 'package:doctorppp/entity/userProfile.dart';

class DoctorProfile extends UserProfile {
  String? id;
  String speciality;
  String clinicId;

  DoctorProfile(
      {role,
      fName,
      lName,
      email,
      address,
      phone,
      meets,
      picture,
      required this.speciality,
      required this.clinicId})
      : super(
            role: role,
            fName: fName,
            lName: lName,
            email: email,
            address: address,
            phone: phone);

  factory DoctorProfile.empty() => DoctorProfile(
      clinicId: "",
      speciality: "",
      role: "",
      fName: "",
      lName: "",
      email: "",
      address: "",
      phone: "",
      picture: "");

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => DoctorProfile(
        fName: json["fName"],
        lName: json["lName"],
        email: json["email"],
        address: json["address"],
        phone: json["pNumber"],
        meets: json["meets"] != null
            ? List<BookingService>.from(
                json["meets"].map((x) => BookingService.fromJson(x)))
            : null,
        role: json["role"],
        picture: json["picture"],
        speciality: json["speciality"],
        clinicId: json["clinicId"],
      );

  @override
  Map<String, dynamic> toJson() => {
        'role': role,
        'fName': fName,
        'lName': lName,
        'email': email,
        'address': address,
        'pNumber': phone,
        'meets': meets,
        'picture': picture,
        'speciality': speciality,
        'clinicId': clinicId,
      };
}
