import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../validatorsAuth/auth.dart';

class ReportsController extends GetxController {
  RxList<Report> reports = <Report>[].obs;
  RxInt updatedIndex = RxInt(-1);

  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<void> saveReportToFirebase(Report report, String userId) async {
    try {
      await users.doc(userId).collection('report').add(report.toJson());
    } catch (e) {
      print("Error adding report to Firestore: $e");
      throw e;
    }
  }

  void addReport(Report report) {
    reports.add(report);
  }

  void updateReport(int index, Report newReport) {
    reports[index] = newReport;
    update();
  }

  void setUpdatedIndex(int index) {
    updatedIndex.value = index;
  }

  Future<void> clearReports() async {
    reports.clear();
    update();
  }
}

class ReportForm extends StatefulWidget {
  final String doctorName;
  final String patientName;
  final Function(Report) onSave;
  final bool update;
  final int index;
  final Report? report;
  final bool notArrived;

  ReportForm({
    required this.doctorName,
    required this.patientName,
    required this.onSave,
    this.update = false,
    this.index = -1,
    this.report,
    this.notArrived = false,
  });

  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormState>();
  final _conditionController = TextEditingController();
  final _prescriptionController = TextEditingController();
  final _detailsController = TextEditingController();
  final _notArrivedController = TextEditingController();
  final ReportsController reportsController = Get.put(ReportsController());
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    if (widget.update && widget.report != null) {
      _conditionController.text = widget.report!.condition;
      _prescriptionController.text = widget.report!.prescription;
      _detailsController.text = widget.report!.details;
      _notArrivedController.text = widget.report!.notArrived.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return AlertDialog(
      title: Text(widget.update ? 'Update Report' : 'Complete Appointment'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Doctor: ${widget.doctorName}'),
              Text('Patient: ${widget.patientName}'),
              // TextFormField(
              //   controller: _conditionController,
              //   decoration: InputDecoration(labelText: 'Condition'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a condition';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Condition'),
                controller: _conditionController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prescription'),
                controller: _prescriptionController,
              ),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: 'Details'),
                maxLines: 3,
              ),
              CheckboxListTile(
                title: Text('Not Arrived'),
                value: _notArrivedController.text.isNotEmpty
                    ? _notArrivedController.text.toLowerCase() == 'true'
                    : widget.notArrived,
                onChanged: (value) {
                  setState(() {
                    _notArrivedController.text = value.toString();
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final report = Report(
                doctorName: widget.doctorName,
                patientName: widget.patientName,
                condition: _conditionController.text,
                prescription: _prescriptionController.text,
                details: _detailsController.text,
                notArrived: _notArrivedController.text.isNotEmpty
                    ? _notArrivedController.text.toLowerCase() == 'true'
                    : widget.notArrived,
              );
              if (widget.update) {
                reportsController.updateReport(widget.index, report);
              } else {
                reportsController.addReport(report);
                await reportsController.saveReportToFirebase(
                    report, authController.user!.uid);
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(widget.update ? 'Update' : 'Save'),
        ),
      ],
    );
  }
}

// class _ReportFormState extends State<ReportForm> {
//   final _formKey = GlobalKey<FormState>();
//
//   final _conditionController = TextEditingController();
//
//   final _prescriptionController = TextEditingController();
//
//   final _detailsController = TextEditingController();
//
//   final reportsController = Get.find<ReportsController>();
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.update && widget.report != null) {
//       _conditionController.text = widget.report!.condition;
//       _prescriptionController.text = widget.report!.prescription;
//       _detailsController.text = widget.report!.details;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.update ? 'Update Report' : 'Complete Appointment'),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Doctor: ${widget.doctorName}'),
//             Text('Patient: ${widget.patientName}'),
//             TextFormField(
//               controller: _conditionController,
//               decoration: InputDecoration(labelText: 'Condition'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a condition';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _prescriptionController,
//               decoration: InputDecoration(labelText: 'Prescription'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a prescription';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _detailsController,
//               decoration: InputDecoration(labelText: 'Details'),
//               maxLines: 3,
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               final report = Report(
//                 doctorName: widget.doctorName,
//                 patientName: widget.patientName,
//                 condition: _conditionController.text,
//                 prescription: _prescriptionController.text,
//                 details: _detailsController.text,
//               );
//               if (widget.update) {
//                 reportsController.updateReport(widget.index, report);
//               } else {
//                 reportsController.addReport(report);
//               }
//               widget.onSave(report);
//               Navigator.of(context).pop();
//             }
//           },
//           child: Text(widget.update ? 'Update' : 'Save'),
//         ),
//       ],
//     );
//   }
// }