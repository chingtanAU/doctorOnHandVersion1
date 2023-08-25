class PatientAppointment {
  final String doctorName;
  final String appointmentTime;
  final String appointmentDate;
  final String appointmentLocation;
  final String appointmentReason;
  final DateTime bookingStart;
  final DateTime bookingEnd;
  final String? userId;

  PatientAppointment({
    required this.doctorName,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.appointmentLocation,
    required this.appointmentReason,
    required this.bookingStart,
    required this.bookingEnd,
    required this.userId,
  });
}
