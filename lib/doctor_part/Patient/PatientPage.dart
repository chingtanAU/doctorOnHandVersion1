import 'package:doctorppp/doctor_part/Patient/controller.dart';
import 'package:doctorppp/doctor_part/video_calll/meet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class PatientPage extends StatelessWidget {
  final PatientController _controller = Get.put(PatientController());

  PatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
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

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Name: John Doe',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Age: 35',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gender: Male',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Address: 123 Main St, Anytown, USA',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Previous Visits',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            for (final visit in _controller.visits)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InkWell(
                  onTap: () {
                    _controller.showVisitDetails(visit);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          visit.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Visit Date: ${visit.date}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Diagnosis: ${visit.diagnosis}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Obx(() {
            //     final currentVisit = _controller.currentVisit.value;
            //     if (currentVisit == null) {
            //       return ElevatedButton(
            //         onPressed: () {
            //           _controller.currentVisit(_controller.visits.first);
            //         },
            //         child: const Text('Start Visit'),
            //       );
            //     }
            //     return Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Current Visit',
            //           style: Theme.of(context).textTheme.headline6,
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           'Visit Title: ${currentVisit.title}',
            //           style: Theme.of(context).textTheme.subtitle1,
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           'Visit Date: ${currentVisit.date}',
            //           style: Theme.of(context).textTheme.subtitle1,
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           'Diagnosis: ${currentVisit.diagnosis}',
            //           style: Theme.of(context).textTheme.subtitle1,
            //         ),
            //         const SizedBox(height: 8),
            //         TextButton(
            //           onPressed: () {
            //             _controller.showVisitDetails(currentVisit);
            //           },
            //           child: const Text('View Report'),
            //         ),
            //       ],
            //     );
            //   }),
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          String doctorId = 'doctor1'; // Replace with the actual doctor ID
          String patientId = 'patient3'; // Replace with the actual patient ID
          Get.to(
              VideoCallScreen(doctorId: doctorId, patientId: patientId));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xff575de3),
          ),
        ),
        child: const Text('Start Appointment'),
      ),
    );
  }
}