import 'package:doctorppp/screens/search/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import "package:latlong2/latlong.dart" as latLng;

class ClinicDetails extends StatelessWidget {
  final Clinic clinic;
   ClinicDetails({Key? key, required this.clinic}) : super(key: key);
  late String last = clinic.lastVisit.toString() ;
  late String visit = clinic.visits.toString();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 9,
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //         gradient: LinearGradient(
      //           begin: Alignment.topRight,
      //           end: Alignment.bottomLeft,
      //           stops: [
      //
      //             0.1,
      //             0.6,
      //           ],
      //           colors: [
      //
      //             Colors.blue,
      //             Colors.teal,
      //           ],
      //         )
      //     ),
      //   ),
      //
      //   title: Align(
      //       alignment: Alignment.center,
      //       child: Text("Doctors On Hand")),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () => {
          Get.toNamed('/book')
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xff575de3),
          ),
        ),
        child: const Text('Book Appointment'),
      ),
      

      //
      // (
      //   backgroundColor: Color(MyColors.primary),
      //   elevation: 10,
      //   isExtended: true,
      //   // style: ButtonStyle(
      //   //   backgroundColor: MaterialStateProperty.all<Color>(
      //   //     Color(MyColors.primary),
      //   //   ),
      //   // ),
      //   child: Text('Book Appointment'),
      //   onPressed: () => {},
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
                  )
              ),
              child:
                FlexibleSpaceBar(
                  background:
                    Image.asset(clinic.imageUrl),

                ),
            ),
            title: Text(clinic.name),
            backgroundColor: const 
            Color(0xff575de3),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child:  Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DetailClinicCard(),
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
                  Text(clinic.description,
                    style:  TextStyle(
                      color: Color(MyColors.purple01),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
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
              ),
            ),
          )
        ],
      )
      ,
    );
  }
}

// class DetailBody extends StatelessWidget {
//   final Clinic clinic;
//
//   const DetailBody({
//     Key? key, required this.clinic
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       margin: EdgeInsets.only(bottom: 30),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           DetailClinicCard(),
//           const SizedBox(
//             height: 15,
//           ),
//           ClinicInfo(),
//           const SizedBox(
//             height: 30,
//           ),
//           Text(
//             'About Clinic',
//             style: kTitleStyle,
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Text(clinic.description,
//             style: const TextStyle(
//               color: Color(MyColors.purple01),
//               fontWeight: FontWeight.w500,
//               height: 1.5,
//             ),
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           Text(
//             'Location',
//             style: kTitleStyle,
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           ClinicLocation(),
//           const SizedBox(
//             height: 25,
//           ),
//         ],
//       ),
//     );
//   }
// }

class ClinicLocation extends StatelessWidget {
  const ClinicLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        // child: FlutterMap(
        //   options: MapOptions(center: latLng.LatLng(0, 0)),
        //   children: [
        //     MarkerLayer(
        //       rotate: true,
        //       markers: [
        //         Marker(
        //           point: latLng.LatLng(0, 0),
        //           width: 256,
        //           height: 256,
        //           anchorPos: AnchorPos.align(AnchorAlign.left),
        //           builder: (context) => const ColoredBox(
        //             color: Colors.lightBlue,
        //             child: Align(
        //               alignment: Alignment.centerRight,
        //               child: Text('-->'),
        //             ),
        //           ),
        //         ),
        //         Marker(
        //           point: latLng.LatLng(0, 0),
        //           width: 256,
        //           height: 256,
        //           anchorPos: AnchorPos.align(AnchorAlign.right),
        //           builder: (context) => const ColoredBox(
        //             color: Colors.pink,
        //             child: Align(
        //               alignment: Alignment.centerLeft,
        //               child: Text('<--'),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        child: FlutterMap(
          options: MapOptions(
            interactiveFlags:
            InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            center: latLng.LatLng(53.6363, -113.3733),
            zoom: 16.0,
          ),
          children: [
            // MarkerLayer(
            //
            //     markers: [
            //     Marker(
            //       point: latLng.LatLng(53.6363, -113.3733),
            //       width: 256,
            //       height: 256,
            //       anchorPos: AnchorPos.align(AnchorAlign.left),
            //       builder: (context) => const FlutterLogo(
            //         // color: Colors.lightBlue,
            //         // child: Align(
            //         //   alignment: Alignment.centerRight,
            //         //   curve: Text('-->'),
            //
            //       ),
            //     ),
            //       Marker(
            //
            //         point:  latLng.LatLng(53.6363, -113.3733),
            //         builder: (ctx) => const FlutterLogo(
            //           textColor: Colors.purple,
            //           key: ObjectKey(Colors.purple),
            //         ),
            //       ),
            //     ],
            //   ),

            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
          ],

          // layers: [
          //   TileLayerOptions(
          //     subdomains: ['a', 'b', 'c'],
          //     urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          //   ),
          //],
        ),
      ),
    );
  }
}

class ClinicInfo extends StatelessWidget {
  final String last;
  final String total;
  const ClinicInfo({
    Key? key, required this.last, required this.total,
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
          children:  [
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
              style:  TextStyle(
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
              style:  TextStyle(
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
  const DetailClinicCard({
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
                      'Dr. Josua Simorangkir',
                      style: TextStyle(
                          color: Color(MyColors.header01),
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'General Practitioner',
                      style:  TextStyle(
                        color: Color(MyColors.grey02),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Image(
                image: AssetImage('assets/medical1.png'),
                width: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}





 TextStyle kTitleStyle =  TextStyle(
  color: Color(MyColors.header01),
  fontWeight: FontWeight.bold,
);

 TextStyle kFilterStyle =  TextStyle(
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