import 'package:booking_calendar/booking_calendar.dart';

class UserProfile{
  String fName;
  String lName;
  String email;
  String address;
  String phone;
  List<BookingService>? meets;
  String role ;
  String picture;

  factory UserProfile.empty()=>UserProfile(role: "", fName: "", lName: "", email: "", address: "", phone: "", picture:"");

  UserProfile({required this.role, required this.fName,required this.lName,required this.email,required this.address,
         required this.phone, this.meets, this.picture=""});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    fName: json["fName"],
    lName:json["lName"],
    email:json["email"],
    address:json["address"],
    phone: json["pNumber"],
    meets:json["meets"]!=null ? List<BookingService>.from(json["meets"].map((x) => BookingService.fromJson(x))):null,
    role: json["role"],
    picture: json["picture"],
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

      };


}