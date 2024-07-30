import 'package:doctorppp/entity/DoctorProfile.dart';
import 'package:doctorppp/entity/clinicDTO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import "package:latlong2/latlong.dart" as latLng;
import '../../Controllers/clinicDetailsContoller.dart';

class ClinicDetails extends StatelessWidget {
  final ClinicDTO clinic;

  ClinicDetails({Key? key, required this.clinic}) : super(key: key);

  late String last = clinic.lastVisit.toString();

  late String visit = clinic.visitNumber.toString();
  final clinicdetailController = Get.find<ClinicDetailsContoller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: ElevatedButton(
      //   onPressed: () =>
      //   {
      //     Get.toNamed('/book')
      //   },
      //   style: ButtonStyle(
      //     backgroundColor: MaterialStateProperty.all<Color>(
      //       const Color(0xff575de3),
      //     ),
      //   ),
      //   child: const Text('Book Appointment'),
      // ),

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
                stops: [
                  0.1,
                  0.6,
                ],
                colors: [
                  Colors.blue,
                  Colors.teal,
                ],
              )),
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
                    // for (var doctor in clinicdetailController.doctorData.value)
                    // you can add a for loop here to get all the doctors in the clinic

                    DetailClinicCard(
                        doctor: clinicdetailController.doctorData.value),
                    DetailClinicCard(
                        doctor: clinicdetailController.doctorData.value),
                    const SizedBox(
                      height: 15,
                    ),
                    ClinicInfo(last: last, total: visit),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'About Clinic',
                      style: kTitleStyle,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Text(clinic.description,
                    //   style:  TextStyle(
                    //     color: Color(MyColors.purple01),
                    //     fontWeight: FontWeight.w500,
                    //     height: 1.5,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Location',
                      style: kTitleStyle,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const ClinicLocation(),
                    const SizedBox(
                      height: 25,
                    ),
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
  const ClinicLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlutterMap(
          options: MapOptions(
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            center: latLng.LatLng(53.6363, -113.3733),
            zoom: 16.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
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
    Key? key,
    required this.last,
    required this.total,
  }) : super(key: key);

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
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;

  const NumberCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

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
  DoctorProfile? doctor;

  DetailClinicCard({
    this.doctor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
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
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
              // const Image(
              //   image: AssetImage('assets/medical1.png'),
              //   width: 100,
              // )
            ],
          ),
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
