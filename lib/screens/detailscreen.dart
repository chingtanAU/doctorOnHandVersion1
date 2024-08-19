import 'package:doctorppp'
    '/screens/callscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var available = [
    {"day": "Mon", "date": "12", "isColor": false},
    {"day": "Tue", "date": "13", "isColor": false},
    {"day": "Wed", "date": "14", "isColor": false},
    {"day": "Thu", "date": "15", "isColor": false},
    {"day": "Fri", "date": "16", "isColor": false},
  ];

  Widget info(
      {required String amount, required String data, required Color color}) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 2),
        ),
        height: size.height * 0.1,
        width: size.width * 0.25,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                amount,
                style:  TextStyle(
                    fontFamily: "Comic Sans",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: color),
              ),
              const SizedBox(height: 15),
              data.length < 7
                  ? Text(
                      data,
                      style:  TextStyle(
                          fontFamily: "Comic Sans",
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: color),
                    )
                  : Text(
                      data,
                      style: TextStyle(
                          fontFamily: "Comic Sans",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: color),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color color = Colors.grey;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: size.height * 0.38,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Colors.black,
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    image: const AssetImage(
                      "assets/Image2.jpg",
                    ),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 5,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 15,
                    child: SizedBox(
                      // color: Colors.blue,
                      width: size.width * 0.7,
                      height: size.height * 0.1,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dr. Mary Albright",
                            style: TextStyle(
                              fontFamily: "Comic Sans",
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Cardiologist | Apollo Hospital",
                            style: TextStyle(
                              fontFamily: "Comic Sans",
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, //Center Row contents vertically,

                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 17,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 17,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 17,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 17,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 17,
                              ),
                              Text(
                                " (5.0)",
                                style: TextStyle(
                                  fontFamily: "Comic Sans",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.width * 0.025, horizontal: size.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "You Can Contact Us :",
                    style: TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    color: Colors.green[100],
                    width: size.width * 0.1,
                    height: size.height * 0.05,
                    child: Center(
                      child: Transform.rotate(
                        angle: 545,
                        child: SvgPicture.asset(
                          "assets/Phone.svg",
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.orange[100],
                    width: size.width * 0.1,
                    height: size.height * 0.05,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/comment.svg",
                        height: 20,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue[100],
                    width: size.width * 0.1,
                    height: size.height * 0.05,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/Video.svg",
                        height: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
              // color: Colors.blue,
              height: size.height * 0.12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  info(amount: "5k", data: "Patient", color: Colors.blue),
                  info(
                      amount: "8 yrs",
                      data: "Experience",
                      color: Colors.orange),
                  info(amount: "4.5", data: "Ratings", color: Colors.purple),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: size.width,
              // color: Colors.blue,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "About Doctor",
                      style: TextStyle(
                        fontFamily: "Comic Sans",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document.",
                    style: TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: Text(
                    "Availabilty",
                    style: TextStyle(
                      fontFamily: "Comic Sans",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  height: size.height * 0.12,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (available[index]["isColor"] == true) {
                                available[index]["isColor"] = false;
                              } else {
                                available[index]["isColor"] = true;
                              }
                            });
                          },
                          child: Card(
                            margin: EdgeInsets.only(right: size.width * 0.065),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: available[index]["isColor"] != true
                                      ? Colors.grey[200]
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(40)),
                              width: size.width * 0.12,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    available[index]["day"].toString(),
                                    style:  TextStyle(
                                      fontFamily: "Comic Sans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: available[index]["isColor"] != true
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    available[index]["date"].toString(),
                                    style: TextStyle(
                                      fontFamily: "Comic Sans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: available[index]["isColor"] != true
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => const CallScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Book Appointment",
                      style: TextStyle(
                        fontFamily: "Comic Sans",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
