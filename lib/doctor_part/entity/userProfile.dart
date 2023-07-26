
class UserProfile{

  String role;
  String fName;
  String lName;
  String email;
  String address;
  String phone;

  UserProfile({required this.role,required this.fName,required this.lName,required this.email,required this.address,
         required this.phone});

  Map<String, dynamic> toJson() =>

      {
        'role': role,
        'fName': fName,
        'lName': lName,
        'email': email,
        'address': address,
        'pNumber': phone,
      };


}