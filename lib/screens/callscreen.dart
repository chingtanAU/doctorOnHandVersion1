import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          alignment: Alignment(0.4, 0),
          image: AssetImage(
            "assets/Image2.jpg",
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/Image6.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                height: height * 0.17,
                width: width * 0.28,
              ),
            ),
            Positioned(
              bottom: 100,
              left: 150,
              right: 150,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Transform.rotate(
                    angle: 40.1,
                    child: SvgPicture.asset(
                      "assets/Call.svg",
                      color: Colors.white,
                      height: 30,
                    ),
                  )),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              width: width,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                          child: SvgPicture.asset(
                        "assets/microphone.svg",
                        color: Colors.black,
                        height: 30,
                      )),
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                          child: SvgPicture.asset(
                        "assets/switch-camera.svg",
                        color: Colors.black,
                        height: 25,
                      )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
