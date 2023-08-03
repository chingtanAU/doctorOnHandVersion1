// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Patient {
//   final String id;
//   final String name;
//   final int age;
//   RxList<Report> reports;
//
//   Patient({
//     required this.id,
//     required this.name,
//     required this.age,
//     List<Report>? reports,
//   }) : reports = reports != null ? reports.obs : RxList<Report>();
// }
//
// class Report {
//   final String id;
//   final DateTime date;
//   final String doctor;
//   final String diagnosis;
//   final String prescription;
//
//   Report({
//     required this.id,
//     required this.date,
//     required this.doctor,
//     required this.diagnosis,
//     required this.prescription,
//   });
// }
//
// class ReportController extends GetxController {
//   final ReportService reportService = ReportService();
//
//   void addReport(Patient patient, Report report) {
//     reportService.addReport(patient, report);
//   }
//
//   List<Report> getReportsForPatient(Patient patient) {
//     return reportService.getReportsForPatient(patient);
//   }
// }
//
// class ReportService {
//   // This method adds a new report for a patient
//   void addReport(Patient patient, Report report) {
//     // Add the report to the patient's record
//     patient.reports.add(report);
//   }
//
//   // This method retrieves all reports for a patient
//   List<Report> getReportsForPatient(Patient patient) {
//     return patient.reports.toList();
//   }
// }
//
// class ReportScreen extends StatelessWidget {
//   final Patient patient;
//   final ReportController reportController = Get.put(ReportController());
//
//   ReportScreen({required this.patient});
//
//   final _formKey = GlobalKey<FormState>();
//   final _doctorController = TextEditingController();
//   final _diagnosisController = TextEditingController();
//   final _prescriptionController = TextEditingController();
//
//   void _saveReport() {
//     if (_formKey.currentState!.validate()) {
//       // Create a new report object with the form data
//       final report = Report(
//         id: DateTime.now().toString(),
//         date: DateTime.now(),
//         doctor: _doctorController.text,
//         diagnosis: _diagnosisController.text,
//         prescription: _prescriptionController.text,
//       );
//
//       // Add the report to the patient's record
//       reportController.addReport(patient, report);
//
//       // Navigate back to the patient details screen
//       Get.back();
//     }
//   }
//
//   @override
//   void dispose() {
//     _doctorController.dispose();
//     _diagnosisController.dispose();
//     _prescriptionController.dispose();
//     super.dispose(=);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Report'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _doctorController,
//                 decoration: InputDecoration(
//                   labelText: 'Doctor',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the doctor\'s name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _diagnosisController,
//                 decoration: InputDecoration(
//                   labelText: 'Diagnosis',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the diagnosis';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _prescriptionController,
//                 decoration: InputDecoration(
//                   labelText: 'Prescription',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter the prescription';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _saveReport,
//                 child: Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }