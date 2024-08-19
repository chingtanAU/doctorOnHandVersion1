import 'package:doctorppp/entity/DoctorProfile.dart';
import 'package:doctorppp/entity/clinicDTO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import "package:latlong2/latlong.dart" as latLng;
import '../../Controllers/clinicDetailsContoller.dart';

class ClinicDetails extends StatelessWidget {
  final ClinicDTO clinic;
  final String last;
  final String visit;
  final ClinicDetailsContoller clinicdetailController;

  ClinicDetails({super.key, required this.clinic})
      : last = clinic.lastVisit?.toString() ?? 'N/A',
        visit = clinic.visitNumber?.toString() ?? 'N/A',
        clinicdetailController = Get.find<ClinicDetailsContoller>() {
    clinicdetailController.setDoctordata(clinic.idClinic);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 9,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.6],
                  colors: [Colors.blue, Colors.teal],
                ),
              ),
              child: FlexibleSpaceBar(
                background: Image.asset("assets/medical1.png"),
              ),
            ),
            title: Text(clinic.clinicName),
            backgroundColor: const Color(0xff575de3),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 30),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DetailClinicCard(
                        doctor: clinicdetailController.doctorData.value),
                    const SizedBox(height: 15),
                    ClinicInfo(last: last, total: visit),
                    const SizedBox(height: 30),
                    Text('About Clinic', style: kTitleStyle),
                    const SizedBox(height: 15),
                    // Add clinic description here if available
                    const SizedBox(height: 25),
                    Text('Location', style: kTitleStyle),
                    const SizedBox(height: 25),
                    const ClinicLocation(),
                    const SizedBox(height: 25),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

class ClinicLocation extends StatelessWidget {
  const ClinicLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlutterMap(
          options: MapOptions(
            onMapReady: () {
            },
            initialCenter: const latLng.LatLng(53.6363, -113.3733),
            initialZoom: 16.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app', // Replace with your app package name
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  point: latLng.LatLng(53.6363, -113.3733),
                  width: 80,
                  height: 80,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class ClinicInfo extends StatelessWidget {
  final String last;
  final String total;

  const ClinicInfo({
    super.key,
    required this.last,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            NumberCard(
              label: 'Patients',
              value: '100+',
            ),
            SizedBox(width: 15),
            NumberCard(
              label: 'Experiences',
              value: '10 years',
            ),
            SizedBox(width: 15),
            NumberCard(
              label: 'Rating',
              value: '4.0',
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            NumberCard(
              label: 'Last Visit',
              value: last,
            ),
            const SizedBox(width: 15),
            NumberCard(
              label: 'Total Visit',
              value: total,
            ),
          ],
        ),
      ],
    );
  }
}

class AboutClinic extends StatelessWidget {
  final String title;
  final String desc;

  const AboutClinic({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;

  const NumberCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(MyColors.bg03),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 30,
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(MyColors.grey02),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                color: Color(MyColors.header01),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailClinicCard extends StatelessWidget {
  final DoctorProfile? doctor;

  const DetailClinicCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    if (doctor == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text('Doctor information not available'),
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${doctor!.fName} ${doctor!.lName}",
                    style: TextStyle(
                      color: Color(MyColors.header01),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    doctor!.speciality,
                    style: TextStyle(
                      color: Color(MyColors.grey02),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/book', arguments: doctor);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  const Color(0xff575de3),
                ),
              ),
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}


TextStyle kTitleStyle = TextStyle(
  color: Color(MyColors.header01),
  fontWeight: FontWeight.bold,
);

TextStyle kFilterStyle = TextStyle(
  color: Color(MyColors.bg02),
  fontWeight: FontWeight.w500,
);

class MyColors {
  static int header01 = 0xff151a56;
  static int primary = 0xff575de3;
  static int purple01 = 0xff918fa5;
  static int purple02 = 0xff6b6e97;
  static int yellow01 = 0xffeaa63b;
  static int yellow02 = 0xfff29b2b;
  static int bg = 0xfff5f3fe;
  static int bg01 = 0xff6f75e1;
  static int bg02 = 0xffc3c5f8;
  static int bg03 = 0xffe8eafe;
  static int text01 = 0xffbec2fc;
  static int grey01 = 0xffe9ebf0;
  static int grey02 = 0xff9796af;
}
