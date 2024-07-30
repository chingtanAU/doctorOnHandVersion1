import 'package:booking_calendar/booking_calendar.dart';

class UserProfile {
  String fName;
  String lName;
  String email;
  String address;
  String phone;
  String role;
  List<BookingService>? meets;
  String picture;
  String? speciality1;

  factory UserProfile.empty() => UserProfile(
      role: "",
      fName: "",
      lName: "",
      email: "",
      address: "",
      phone: "",
      picture: "");

  UserProfile(
      {required this.role,
      required this.fName,
      required this.lName,
      required this.email,
      required this.address,
      required this.phone,
        this.speciality1,
      this.meets,
      this.picture = ""});

  @override
  String toString() {
    return 'UserProfile{fName: $fName, lName: $lName, email: $email, address: $address, phone: $phone, role: $role, meets: $meets, picture: $picture , speciality: $speciality1}';
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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
        speciality1: json["speciality"],
      );

  Map<String, dynamic> toJson() => {
        'role': role,
        'fName': fName,
        'lName': lName,
        'email': email,
        'address': address,
        'pNumber': phone,
        'meets': meets ?? [],
        'picture': picture,
        'speciality': speciality1,
      };

  String get fullName => "$fName $lName";
}
