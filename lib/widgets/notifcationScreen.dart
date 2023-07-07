import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  const NotificationPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
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
      body: Obx(
    () => ListView.builder(
        itemCount: Get.find<NotificationController>().notifications.length,
        itemBuilder: (context, index) {
          final notification = Get.find<NotificationController>().notifications[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              title: Text(
                notification.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(notification.message),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  Get.find<NotificationController>().removeNotification(index);
                },
              ),
            ),
          );
        },
      ),
    ),
    );
  }
}

class Notification {
  final String title;
  final String message;

  Notification({required this.title, required this.message});
}

class NotificationController extends GetxController {
  var notifications = <Notification>[
    Notification(
      title: 'New Medical Appointment',
      message: 'You have a medical appointment tomorrow at 10:00 AM.',
    ),
    Notification(
      title: 'Medication Reminder',
      message: 'Remember to take your medication at 8:00 PM.',
    ),
  ].obs;

  void removeNotification(int index) {
    notifications.removeAt(index);
  }
}