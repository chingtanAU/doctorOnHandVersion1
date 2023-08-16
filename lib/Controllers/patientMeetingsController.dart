import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctorppp/entity/DoctorProfile.dart';
import 'package:doctorppp/entity/userProfile.dart';
import 'package:doctorppp/globals.dart';
import 'package:get/get.dart';
import '../persistance/userCrud.dart' as userCrud;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../widgets/notifcationScreen.dart';

class PatientMeetingsController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final Rx<List<BookingService>> allPatientMeetings =
      Rx<List<BookingService>>(List.empty(growable: true));
  final Rx<DoctorProfile> earliestdoctor =
      Rx<DoctorProfile>(DoctorProfile.empty());

  // Add a variable to store the earliest meeting
  final Rx<BookingService?> earliestMeeting = Rx<BookingService?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    _initializeNotifications();
    fetchPatientMeetings(auth.currentUser!.uid);
    print("aaaaaaa ${allPatientMeetings.value.length}");
    // Compute the earliest meeting here
    earliestMeeting.value = getEaliestMeeting();
    if (earliestMeeting.value != null) {
      await getDoctorData(earliestMeeting.value!);
      print(earliestdoctor.value.fName);
    }
  }

  void _initializeNotifications() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleNotification(DateTime scheduledDate, String doctorName,
      String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'channel_description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            sound: 'default',
            presentAlert: true,
            presentBadge: true,
            presentSound: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails);

    final payload = '$title|$body';

    await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
        tz.TZDateTime.from(scheduledDate, tz.local), platformChannelSpecifics,
        payload: payload,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);

    // final newNotification = Notification(
    //   id: DateTime.now()
    //       .millisecondsSinceEpoch, // Using timestamp as a unique ID
    //   title: title,
    //   message: body,
    // );
    // Get.find<NotificationController>().addNotification(newNotification);
  }

  BookingService? getEaliestMeeting() {
    final meetings =
        getUpcomingMeetings(allPatientMeetings.value, DateTime.now());
    print(DateTime.now().toString());
    if (meetings.isEmpty) {
      return null;
    }
    return meetings.reduce((current, next) =>
        current.bookingStart.isBefore(next.bookingStart) ? current : next);
  }

  Future<DoctorProfile?> getDoctorData(BookingService meeting) async {
    await userCrud
        .fetchDoctorInfo(meeting.serviceId!)
        .then((value) => earliestdoctor.value = value!);
    print(earliestdoctor.value.fName);
    update();
  }

  List<BookingService> getUpcomingMeetings(
      List<BookingService> meetings, DateTime presentTime) {
    final l = meetings
        .where((meeting) => meeting.bookingStart.isAfter(presentTime))
        .toList();
    l.sort((a, b) => a.bookingStart.compareTo(b.bookingStart));
    return l;
  }

  List<BookingService> getPassedMeetings(
      List<BookingService> meetings, DateTime presentTime) {
    final l = meetings
        .where((meeting) => meeting.bookingStart.isBefore(presentTime))
        .toList();
    l.sort((a, b) => a.bookingStart.compareTo(b.bookingStart));
    print(l.length);
    return l;
  }

  // Future<List<BookingService>?> fetchPatientMeetings(String id) async {
  //   await userCrud
  //       .fetchUserMeetings(id)
  //       .then((value) => allPatientMeetings.value = value);
  //   update();
  // }
  void fetchPatientMeetings(String id) {
    userCrud.fetchUserMeetingsStream(id).listen((List<BookingService> data) {
      allPatientMeetings.value = data;
      // Update the earliest meeting whenever data changes
      earliestMeeting.value = getEaliestMeeting();
      if (earliestMeeting.value != null) {
        getDoctorData(earliestMeeting.value!);
      }

      List<BookingService> upcomingMeetings =
          getUpcomingMeetings(allPatientMeetings.value, DateTime.now());

      for (var meeting in upcomingMeetings) {
        getDoctorData(meeting); // Fetch doctor data for the current meeting

        final DateTime oneWeekBefore =
            meeting.bookingStart.subtract(Duration(days: 7));
        final DateTime thirtySixHoursBefore =
            meeting.bookingStart.subtract(Duration(hours: 36));
        print(thirtySixHoursBefore.toString());
        final DateTime oneHourBefore =
            meeting.bookingStart.subtract(Duration(hours: 1));

        scheduleNotification(
            oneWeekBefore,
            earliestdoctor.value.fName,
            'Upcoming Appointment',
            'You have an appointment with Dr. ${earliestdoctor.value.fName} in one week.');
        scheduleNotification(
            thirtySixHoursBefore,
            earliestdoctor.value.fName,
            'Appointment Reminder',
            'You have an appointment with Dr. ${earliestdoctor.value.fName} in 36 hours. Remember, you only have 12 hours left to cancel.');
        scheduleNotification(
            oneHourBefore,
            earliestdoctor.value.fName,
            'Last Reminder',
            'Your appointment with Dr. ${earliestdoctor.value.fName} is in one hour.');
      }
    });
  }
}
