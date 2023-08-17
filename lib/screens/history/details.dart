import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String visitDate;
  final String doctorName;
  final String diagnosis;
  final String prescription;
  final String labTest;

  AppointmentDetailsScreen({
    required this.visitDate,
    required this.doctorName,
    required this.diagnosis,
    required this.prescription,
    required this.labTest,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visit Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              visitDate,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Doctor Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              doctorName,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Diagnosis:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              diagnosis,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Prescription:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  prescription,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Lab Test:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  labTest,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}