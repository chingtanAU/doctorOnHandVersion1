import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'form.dart';
import '../../validatorsAuth/auth.dart';

class ReportScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  final ReportsController reportsController = Get.put(
      ReportsController(doctorId: Get.find<AuthController>().currentUserId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.6,
              ],
              colors: [
                Colors.blue,
                Colors.teal,
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              reportsController.clearReports();
            },
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: reportsController.reports.length,
          itemBuilder: (context, index) {
            final report = reportsController.reports[index];
            int filledFields = 0;

            if (report.prescription != null && report.prescription.isNotEmpty) {
              filledFields++;
            }
            if (report.condition != null && report.condition.isNotEmpty) {
              filledFields++;
            }
            if (report.details != null && report.details.isNotEmpty) {
              filledFields++;
            }

            Color cardColor;
            if (reportsController.updatedIndex.value == index) {
              cardColor = Colors.blue.shade200;
            } else if (filledFields == 1) {
              cardColor = Colors.red.shade200;
            } else if (filledFields == 3) {
              cardColor = Colors.green.shade200;
            } else {
              cardColor = Colors.yellow.shade200;
            }

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: cardColor,
              child: Column(
                children: [
                  Card(
                    color: Colors.white70,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (report.notArrived == true)
                            const Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 4, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.details,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      'Not Arrived',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (report.notArrived == false &&
                              report.condition != null &&
                              report.condition.isNotEmpty)
                            const Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 4, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.edit_note,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      'Condition',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (report.notArrived == false &&
                              report.prescription != null &&
                              report.prescription.isNotEmpty)
                            const Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 4, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.receipt_long_rounded,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      'Prescription',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (report.notArrived == false &&
                              report.details != null &&
                              report.details.isNotEmpty)
                            const Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 4, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.notes,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      'Details',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    title: Text(
                      report.patientName ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      report.condition ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    onTap: () {
                      _showReportDetails(context, report, index);
                    },
                    trailing: ElevatedButton(
                      onPressed: () {
                        _showReportDetails(context, report, index);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showReportDetails(
      BuildContext context, Report report, int index) async {
    final result = await showDialog(
      context: context,
      builder: (context) => ReportForm(
        doctorName: report.doctorName,
        patientName: report.patientName,
        patientId: report.patientId,
        doctorId: report.doctorId,
        onSave: (newReport) {
          reportsController.updateReport(index, newReport, report.id!);
        },
        update: true,
        index: index,
        report: report,
      ),
    );
    if (result != null && result) {
      // Show a snackbar to indicate that the report was updated
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Report updated'),
        ),
      );
      reportsController.setUpdatedIndex(index);
    }
  }
}
