import 'package:booking_calendar/booking_calendar.dart';

class UserProfile{

  String role;
  String fName;
  String lName;
  String email;
  String address;
  String phone;
  List<BookingService>? meets;

  UserProfile({required this.role,required this.fName,required this.lName,required this.email,required this.address,
         required this.phone, this.meets});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    role: json["id"],
    fName: json["type"],
    lName:json["name"],
    email:json["address"],
    address:json["address"],
    phone: json["phone"],
    meets:List<BookingService>.from(json["meets"].map((x) => BookingService.fromJson(x))),
  );

  Map<String, dynamic> toJson() =>

      {
        'role': role,
        'fName': fName,
        'lName': lName,
        'email': email,
        'address': address,
        'pNumber': phone,
        'meets': meets
      };


}