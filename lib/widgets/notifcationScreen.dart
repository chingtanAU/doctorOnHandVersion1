import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  NotificationPage({super.key});

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
            final notification =
                Get.find<NotificationController>().notifications[index];
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
                    Get.find<NotificationController>()
                        .removeNotification(index);
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
  final int id;
  final String title;
  final String message;

  Notification({required this.id, required this.title, required this.message});
}

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final notifications = <Notification>[
    // Notification(
    //   title: 'New Medical Appointment',
    //   message: 'You have a medical appointment tomorrow at 10:00 AM.',
    // ),
    // Notification(
    //   title: 'Medication Reminder',
    //   message: 'Remember to take your medication at 8:00 PM.',
    // ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) async {
              // Handle the notification triggered while the app is in the foreground
            });
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: handleNotificationResponse);
  }

  void handleNotificationResponse(NotificationResponse response) {
    final payload = response.payload ?? '';
    final splitPayload =
        payload.split('|'); // Splitting the payload to get title and body

    if (splitPayload.length >= 2) {
      final title = splitPayload[0];
      final body = splitPayload[1];

      final notificationDetails = Notification(
          id: DateTime.now()
              .millisecondsSinceEpoch, // Using timestamp as a unique ID
          title: title,
          message: body);
      addNotification(notificationDetails);
    }
  }

  void addNotification(Notification notification) {
    notifications.add(notification);
    update();
  }

  void removeNotification(int index) {
    notifications.removeAt(index);
  }
}
