import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../validatorsAuth/auth.dart';
import '../../entity/userProfile.dart';

class ReportsController extends GetxController {
  RxList<Report> reports = <Report>[].obs;
  RxInt updatedIndex = RxInt(-1);

  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  String? patientId;

  ReportsController({this.patientId});

  Future<void> fetchReportsFromFirebase(String patientId) async {
    try {
      QuerySnapshot querySnapshot =
          await users.doc(patientId).collection('report').get();
      reports.value = querySnapshot.docs.map((doc) {
        var reportData = Report.fromJson(doc.data() as Map<String, dynamic>);
        reportData.id = doc.id;
        reportData.patientId = patientId;
        print("Report: $reportData");
        return reportData;
      }).toList();
    } catch (e) {
      print("Error fetching reports from Firestore: $e");
      throw e;
    }
  }

  Future<void> saveReportToFirebase(Report report, String patientId) async {
    try {
      DocumentReference ref =
          await users.doc(patientId).collection('report').add(report.toJson());
      report.id = ref.id;
    } catch (e) {
      print("Error adding report to Firestore: $e");
      throw e;
    }
  }

  Future<void> deleteReportFromFirebase(
      String patientId, String reportId) async {
    try {
      await users.doc(patientId).collection('report').doc(reportId).delete();
      reports.removeWhere((report) => report.id == reportId);
    } catch (e) {
      print("Error deleting report from Firestore: $e");
      throw e;
    }
  }

  Future<void> updateReportOnFirebase(
      String patientId, String reportId, Report updatedReport) async {
    try {
      await users
          .doc(patientId)
          .collection('report')
          .doc(reportId)
          .update(updatedReport.toJson());
    } catch (e) {
      print("Error updating report on Firestore: $e");
      throw e;
    }
  }

  void addReport(Report report) {
    reports.add(report);
  }

  void updateReport(
      int index, Report newReport, String reportId, String patientId) {
    reports[index] = newReport;
    updateReportOnFirebase(patientId, reportId, newReport);
    update();
  }

  void setUpdatedIndex(int index) {
    updatedIndex.value = index;
  }

  Future<void> clearReports() async {
    reports.clear();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    if (patientId != null) {
      fetchReportsFromFirebase(
          patientId!); // Ensure it's not null before using.
    }
  }
}

class ReportForm extends StatefulWidget {
  final String doctorName;
  final String patientName;
  final String? patientId;
  final String? doctorId;
  final Function(Report) onSave;
  final bool update;
  final int index;
  final Report? report;
  final bool notArrived;

  ReportForm({
    required this.doctorName,
    required this.patientName,
    required this.patientId,
    this.doctorId,
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
  late ReportsController reportsController;
  final AuthController authController = Get.find<AuthController>();

  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    reportsController = Get.put(ReportsController(patientId: widget.patientId));
    userProfile = authController.userData.value;
    if (widget.update && widget.report != null) {
      _conditionController.text = widget.report!.condition;
      _prescriptionController.text = widget.report!.prescription;
      _detailsController.text = widget.report!.details;
      _notArrivedController.text = widget.report!.notArrived.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                reportsController.updateReport(widget.index, report,
                    widget.report?.id ?? '', widget.patientId!);
              } else {
                reportsController.addReport(report);
                await reportsController.saveReportToFirebase(
                    report, widget.patientId!);
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
