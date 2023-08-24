class Report {
  String? id;
  String? patientId;
  String? doctorId;
  final String doctorName;
  final String patientName;
  final String condition;
  final String prescription;
  final String details;
  final bool notArrived;

  Report({
    this.id,
    this.patientId,
    this.doctorId,
    required this.doctorName,
    required this.patientName,
    required this.condition,
    required this.prescription,
    required this.details,
    required this.notArrived,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'patientName': patientName,
      'condition': condition,
      'prescription': prescription,
      'details': details,
      'notArrived': notArrived,
    };
  }

  static Report fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      patientName: json['patientName'],
      condition: json['condition'],
      prescription: json['prescription'],
      details: json['details'],
      notArrived: json['notArrived'],
    );
  }
}
