import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notifcationScreen.dart';



AppBar CustomAppBar(IconButton iconbutton  , List<Obx> actions2) {


  var iconButton;

  var actions2 =  [      Obx(() {
    if(  Get.find<NotificationController>().notifications.isEmpty
    ){
      return IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            Get.to( NotificationPage());
          });
    }
    else {
      return IconButton(
          icon: const Icon(Icons.notifications_active),
          onPressed: () {
            Get.to( NotificationPage());
          });
    }
  }),
  ];
  return AppBar(
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
    ),
    leading: iconButton,
    title:
    const Align(alignment: Alignment.center, child: Text("Doctors On Hand")),
    actions: actions2,
  );
}
