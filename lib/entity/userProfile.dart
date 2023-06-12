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