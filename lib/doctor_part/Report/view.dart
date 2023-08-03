import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model.dart';
import 'form.dart';

class ReportScreen extends StatelessWidget {
  final ReportsController reportsController = Get.put(ReportsController());

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
              )),
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
      body: Obx(() => ListView.builder(
        itemCount: reportsController.reports.length,
        itemBuilder: (context, index) {
          final report = reportsController.reports[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              title: Text(
                report.patientName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                report.condition,
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
          );;
        },
      )),
    );
  }

  void _showReportDetails(BuildContext context, Report report, int index) async {
    final result = await showDialog(
      context: context,
      builder: (context) => ReportForm(
        doctorName: report.doctorName,
        patientName: report.patientName,
        onSave: (newReport) {
          reportsController.updateReport(index, newReport);
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
    }
  }
}