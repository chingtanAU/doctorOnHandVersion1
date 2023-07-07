import 'package:doctorppp/screens/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';


class IncomingCard extends StatelessWidget {
  const IncomingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
         Get.toNamed('/video');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width * 1,
          height: height * 0.21,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            //boxShadow: kElevationToShadow[6],
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
                spreadRadius: 3.0,
                offset: Offset(3.0, 3.0), // shadow direction: bottom right
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 016),
                child: Text(
                  "Upcoming Appointments",
                  style: const TextStyle(
                    fontFamily: "Comic Sans",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/doctor.png',
                      width: width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. David Jacobs",
                        style:  TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "General Practitioner",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      Container(
                        width: width * 0.61,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Ionicons.location_outline,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 6, right: 14),
                                      child: Text(
                                        "4316 139 Avenue ",
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                             SizedBox(height: height * 0.058),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: const [
                            Icon(
                              Ionicons.calendar_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6, right: 14),
                              child: Text(
                                "Today",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Ionicons.time_outline,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "14:30 - 15:30 AM",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
