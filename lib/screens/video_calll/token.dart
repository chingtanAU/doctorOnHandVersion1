import 'package:doctorppp/screens/video_calll/token_generation.dart';
import 'package:get/get.dart';

class VideoCallController extends GetxController {
  final AgoraTokenService agoraTokenService = Get.find();

  RxString channelName = 'xyz'.obs;
  RxString token = ''.obs;

  Future<void> generateToken(String doctorId, String patientId) async {
    try {
      // Generate a unique channel name
      channelName.value = generateChannelName(doctorId, patientId);

      // Generate a token for the channel
      // final appId = 'your_app_id'; // Replace with your Agora App ID
      // final appCertificate = 'your_app_certificate'; // Replace with your Agora App Certificate
      //final uid = 0; // Set the UID as needed
      final token = await agoraTokenService.generateToken( channelName.value);
      this.token.value = token;

      // Show success message using Get.snackbar
      Get.snackbar(
        'Join Success',
        'You have successfully joined the video call.',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('this is $token');
    } catch (e) {
      print('Error generating token: $e');
    }
  }

  String generateChannelName(String doctorId, String patientId) {
    return 'meeting_$doctorId';
  }
}