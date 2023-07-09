import 'package:agora_token_service/agora_token_service.dart';
import 'package:get/get.dart';

class AgoraTokenService extends GetxService {

  final expireTimeInSeconds = 2 * 24 * 60 * 60; // 2 days in seconds

  Future<String> generateToken( String channelName) async {
    final token = RtcTokenBuilder.build(
        appId: "6d23c50fff654240b43df4285a16a3b8",
        appCertificate: "866ce453fa77488bbf66cf0484d2024e",
        channelName: channelName, // i am getting the deviceId As a channel name
        uid: "0", //i think it should work fine as 0 as per documentation.
        role: RtcRole.publisher,
        expireTimestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000 + expireTimeInSeconds, // I don't know if the expireTimeSTamp is in minutes, seconds or milliseconds.

    );
    return token;
  }
}