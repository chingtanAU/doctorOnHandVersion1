

class HealthCarePhacility {

  String name ;
  String address;
  String? experience;
  String number;
  String? patientNum ;
  String? rating;
  String? desc;


  HealthCarePhacility({ this.experience , required this.name, required this.address,required this.number, this.patientNum, this.rating, this.desc });

  factory HealthCarePhacility.fromJson(Map<String, dynamic> json) => HealthCarePhacility(
    name:json["name"],
    address:json["address"],
    experience: json["experience"],
    number: json["number"],
    patientNum: json["patientNum"],
    rating: json["rating"],
    desc: json['desc'],
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

