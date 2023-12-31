import 'package:flutter/material.dart'
;
class MedicalVisitCard extends StatelessWidget {
  final String visitDate;
  final String doctorName;
  final String diagnosis;

  const MedicalVisitCard({super.key, 
    required this.visitDate,
    required this.doctorName,
    required this.diagnosis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Visit Date: $visitDate',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Doctor: $doctorName',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Diagnosis:',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              diagnosis,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
