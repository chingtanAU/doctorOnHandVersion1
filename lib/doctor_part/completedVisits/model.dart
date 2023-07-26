class Visit {
  final String patientName;
  final String visitTime;
  final String visitDate;
  final String visitLocation;
  final String visitReason;

  Visit({
    required this.patientName,
    required this.visitTime,
    required this.visitDate,
    required this.visitLocation,
    required this.visitReason,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      patientName: json['patientName'],
      visitTime: json['visitTime'],
      visitDate: json['visitDate'],
      visitLocation: json['visitLocation'],
      visitReason: json['visitReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'visitTime': visitTime,
      'visitDate': visitDate,
      'visitLocation': visitLocation,
      'visitReason': visitReason,
    };
  }
}