import 'dart:async';

import 'token_generation.dart';
import 'package:get/get.dart';

class VideoCallController extends GetxController {
  final AgoraTokenService1 agoraTokenService = Get.find();

  RxString channelName = ''.obs;
  RxString token = ''.obs;

  bool _snackbarShown = false;

  // Timer to reset the flag after a minute
  Timer? _snackbarTimer;

  Future<void> generateToken(String doctorId, String patientId) async {
    try {
      // Generate a unique channel name
      channelName.value = generateChannelName(doctorId, patientId);

      // Generate a token for the channel
      final token = await agoraTokenService.generateToken(channelName.value);
      this.token.value = token;

      // Show success message using Get.snackbar
      if (!_snackbarShown) {
        // Check if the snackbar message has not been shown
        Get.snackbar(
          'Join Success',
          'You have successfully joined the video call.',
          snackPosition: SnackPosition.TOP,
        );
        _snackbarShown = true; // Set the flag to true

        // Start the timer to reset the flag after a minute
        _snackbarTimer = Timer(Duration(minutes: 1), () {
          _snackbarShown = false;
        });
      }
    } catch (e) {
      print('Error generating token: $e');
    }
  }

  @override
  void onClose() {
    // Cancel the timer when closing the controller
    _snackbarTimer?.cancel();
    super.onClose();
  }


  String generateChannelName(String doctorId, String patientId) {
    return 'meeting_${doctorId}_$patientId';
  }
}