class PatientAppointment {
  final String doctorName;
  final String appointmentTime;
  final String appointmentDate;
  final String appointmentLocation;
  final String appointmentReason;

  PatientAppointment({
    required this.doctorName,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.appointmentLocation,
    required this.appointmentReason,
  });
}