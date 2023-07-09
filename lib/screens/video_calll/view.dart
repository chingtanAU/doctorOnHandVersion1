// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'logic.dart';
//
// const APP_ID = '6d23c50fff654240b43df4285a16a3b8';
// const token = "007eJxTYGhUK3opzae17eD5aj/J1ezcYutt/b9+UQ668CvR9Mcat0gFBrMUI+NkU4O0tDQzUxMjE4MkE+OUNBMjC9NEQ7NE4yQLwWmzUxoCGRm2NFgyMzJAIIjPwlCSWlzCwAAA0U8d2Q==";
// const channel = 'test';
//
//
// class AppointmentController extends GetxController {
//   final Rx<DateTime> selectedDate = DateTime
//       .now()
//       .obs;
//   final Rx<TimeOfDay> selectedTime = TimeOfDay
//       .now()
//       .obs;
//   final RxBool isAppointmentBooked = true.obs;
//   final RxBool isVideoCallEnabled = true.obs;
//   final RxBool _localUserJoined = true.obs;
//   final RxString channelName = ''.obs;
//   final RxInt remoteUid = 0.obs;
//
//   RtcEngine? _rtcEngine;
//
//   @override
//   void onInit() {
//     super.onInit();
//     initializeAgora();
//   }
//
//   Future<void> initializeAgora() async {
//     // Request for camera and microphone permissions
//     await [Permission.camera, Permission.microphone].request();
//
//     _rtcEngine = createAgoraRtcEngine();
//     await _rtcEngine?.initialize(const RtcEngineContext(appId: APP_ID,
//         channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));
//     await _rtcEngine!.enableVideo();
//     await _rtcEngine!.joinChannel(
//       channelId: channelName.value,
//       token: token,
//       uid: 0,
//       options: const ChannelMediaOptions(),);
//     _rtcEngine!.enableLocalAudio(true);
//     _rtcEngine!.enableLocalVideo(true);
//
//     _rtcEngine!.setParameters(
//         '{"che.video.lowBitRateStreamParameter": {"width": 320,"height": 180,"frameRate": 15,"bitRate": 140}}');
//
//     _rtcEngine!.setParameters('{"che.video.keep_prerotation": true}');
//     _rtcEngine!.setParameters('{"che.video.local.camera_index": 1}');
//     _rtcEngine!.registerEventHandler(RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           _localUserJoined.value = true;
//           isVideoCallEnabled.value = true;
//
//
//         },
//         onLeaveChannel: (RtcConnection connection,RtcStats stats) {
//           debugPrint("local user ${stats.userCount} left");
//           _localUserJoined.value = false;
//           isVideoCallEnabled.value = false;
//         },
//       onUserJoined: (RtcConnection connection , int uid, int elapsed) {
//         remoteUid.value = uid;
//       },
//       onUserOffline: (RtcConnection connection , int uid, UserOfflineReasonType reason) {
//         remoteUid.value = 0;
//       },
//     ));
//   }
//
//   void selectDate(DateTime date) {
//     selectedDate.value = date;
//   }
//
//   void selectTime(TimeOfDay time) {
//     selectedTime.value = time;
//   }
//
//   void bookAppointment() {
//     // Check if the selected date and time are within the stipulated booking time
//     if (isWithinBookingTime(selectedDate.value, selectedTime.value)) {
//       // Perform the necessary actions to book the appointment, such as making API calls or updating the database
//       // Set the isAppointmentBooked flag to true
//       isAppointmentBooked.value = true;
//
//       // Create a unique channel name for the video call using the selected date and time
//       channelName.value = 'appointment_${DateTime
//           .now()
//           .millisecondsSinceEpoch}';
//       Get.snackbar('Success', 'Appointment booked successfully!');
//     } else {
//       Get.snackbar('Error',
//           'Appointment booking is not available at the selected date and time.');
//     }
//   }
//
//   bool isWithinBookingTime(DateTime date, TimeOfDay time) {
//     // Implement your logic to check if the selected date and time are within the stipulated booking time
//     // For example, you can check if the selected date is within the next 7 days and if the selected time is within the working hours of the doctor
//     // Return true if the booking is allowed, otherwise return false
//     // This is just a sample implementation, you should customize it according to your requirements
//     DateTime now = DateTime.now();
//     DateTime selectedDateTime = DateTime(
//         date.year, date.month, date.day, time.hour, time.minute);
//     DateTime maxBookingDateTime = now.add(Duration(days: 7));
//
//     if (selectedDateTime.isAfter(now) &&
//         selectedDateTime.isBefore(maxBookingDateTime)) {
//       // Check if the selected time is within the working hours of the doctor
//       if (time.hour >= 9 && time.hour <= 17) {
//         return true;
//       }
//     }
//
//     return false;
//   }
//
//   @override
//   void onClose() {
//     _rtcEngine?.release();
//     super.onClose();
//   }
// }
//
// class AppointmentPage extends StatelessWidget {
//   final AppointmentController appointmentController = Get.put(
//       AppointmentController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book Appointment'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Obx(() =>
//                 Text('Selected Date: ${appointmentController.selectedDate.value
//                     .toString()}')),
//             Obx(() =>
//                 Text('Selected Time: ${appointmentController.selectedTime.value
//                     .format(context)}')),
//             ElevatedButton(
//               onPressed: () {
//                 showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime.now().add(Duration(days: 7)),
//                 ).then((selectedDate) {
//                   if (selectedDate != null) {
//                     appointmentController.selectDate(selectedDate);
//                   }
//                 });
//               },
//               child: Text('Select Date'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 ).then((selectedTime) {
//                   if (selectedTime != null) {
//                     appointmentController.selectTime(selectedTime);
//                   }
//                 });
//               },
//               child: Text('Select Time'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 appointmentController.bookAppointment();
//               },
//               child: Text('Book Appointment'),
//             ),
//             Obx(() {
//               if (appointmentController.isAppointmentBooked.value) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     // Generate a token
//                     String token1 = token;
//
//
//                     // Join the channel
//                     appointmentController._rtcEngine!.joinChannel(
//                       channelId: appointmentController.channelName.value,
//                       token: token1,
//                       uid: 0,
//                       options: const ChannelMediaOptions(),
//                     );
//
//                     // if (appointmentController.isVideoCallEnabled.value) {
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //       builder: (context) =>
//                     //           VideoCallPage(
//                     //             channelName: appointmentController.channelName
//                     //                 .value,
//                     //             rtcEngine: appointmentController._rtcEngine!,
//                     //             remoteUid: appointmentController.remoteUid
//                     //                 .value,
//                     //           ),
//                     //     ),
//                     //   );
//                     // } else {
//                     //   Get.snackbar('Error',
//                     //       'Video call is not available at the moment.');
//                     // }
//                   },
//
//
//                     // Set the video configuration
//
//                     // Join the channel
//                     // if (appointmentController.isVideoCallEnabled.value) {
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //       builder: (context) =>
//                     //           VideoCallPage(
//                     //             channelName: appointmentController.channelName
//                     //                 .value,
//                     //             rtcEngine: appointmentController._rtcEngine!,
//                     //             remoteUid: appointmentController.remoteUid
//                     //                 .value,
//                     //           ),
//                     //     ),
//                     //   );
//                     // } else {
//                     //   Get.snackbar('Error',
//                     //       'Video call is not available at the moment.');
//                     // }
//
//                   child: Text('Join Video Call'),
//                 );
//               } else {
//                 return SizedBox.shrink();
//               }
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }