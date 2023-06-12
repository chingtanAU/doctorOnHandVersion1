import 'package:flutter/material.dart';

class DrawerSreen extends StatefulWidget {
  const DrawerSreen({Key? key}) : super(key: key);

  @override
  _DrawerSreenState createState() => _DrawerSreenState();
}

late double height, width;

class _DrawerSreenState extends State<DrawerSreen> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.brown,
      margin:
          EdgeInsets.only(top: height * 0.15, bottom: height * 0.01, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: width * 0.13,
            child: ClipOval(
              child: Image(
                image: AssetImage("assets/profile.jpg"),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Chris Woakes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            "@Flutter Developer",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            // color: Colors.grey,
            height: height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                singleitem(
                  icons: Icon(Icons.home),
                  name: 'Home',
                ),
                singleitem(
                  icons: Icon(Icons.search),
                  name: 'Explore',
                ),
                singleitem(
                  icons: Icon(Icons.contact_mail_outlined),
                  name: 'Invite Friends',
                ),
                singleitem(
                  icons: Icon(Icons.settings),
                  name: 'Settings',
                ),
                singleitem(
                  icons: Icon(Icons.all_inbox_outlined),
                  name: 'About',
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.17,
          ),
          singleitem(
            icons: Icon(Icons.logout),
            name: 'Log out',
          ),
        ],
      ),
    );
  }
}

class singleitem extends StatelessWidget {
  late Icon icons;
  late String name;
  singleitem({
    required this.icons,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icons.icon,
          size: 25,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
