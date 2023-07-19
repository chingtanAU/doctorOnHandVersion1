
class ClinicDTO{

  String? idClinic;
  String clinicName;
  DateTime? lastVisit;
  int? visitNumber;

  ClinicDTO(
      {  this.idClinic, required this.clinicName, this.lastVisit,  this.visitNumber});

}