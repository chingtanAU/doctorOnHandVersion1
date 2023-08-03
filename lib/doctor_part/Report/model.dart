class Report {
  final String doctorName;
  final String patientName;
   late final String condition;
   late final String prescription;
   late final String details;

  Report({
    required this.doctorName,
    required this.patientName,
    required this.condition,
    required this.prescription,
    required this.details,
  });
}