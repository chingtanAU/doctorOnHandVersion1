// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:get/get.dart';
//
// class VideoCallController extends GetxController {
//   RxString channelName = ''.obs;
//   RxString token = ''.obs;
//
//   Future<void> generateToken( String doctorId, String patientId) async {
//     try {
//       // Generate a unique channel name
//       channelName.value = generateChannelName(doctorId, patientId);
//
//       // Generate a token for the channel
//       var url = Uri.parse('https://api.agora.io/v1/token');
//       var response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'app_id': "6d23c50fff654240b43df4285a16a3b8",
//           'app_certificate': "866ce453fa77488bbf66cf0484d2024e",
//           'channel_name': channelName.value,
//           'uid': 0, // Set the UID as needed
//           'expiration_time': '3600', // Set the expiration time as a string
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         var responseBody = jsonDecode(response.body);
//         token.value = responseBody['token'];
//
//         // Show success message using Get.snackbar
//         Get.snackbar(
//           'Join Success',
//           'You have successfully joined the video call.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         throw Exception('Failed to generate token');
//       }
//     } catch (e) {
//       print('Error generating token: $e');
//     }
//   }
//
//   String generateChannelName(String doctorId, String patientId) {
//     return 'meeting_${doctorId}_$patientId';
//   }
// }