
import 'HealthCarePhacility.dart';
import 'package:doctorppp/entity/userProfile.dart';

class DoctorProfile extends UserProfile {

  String Speciality;

  List<HealthCarePhacility>? clinic;

  DoctorProfile({role,fName,lName,email,address,phone,meets, required this.Speciality ,this.clinic }) : super(role:role, fName:fName , lName:lName, email: email, address: address, phone:phone);

}