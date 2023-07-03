// import 'package:doctorppp/screens/video_calll/view.dart';
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//
// class VideoCallPage extends StatefulWidget {
//   final String channelName;
//   final RtcEngine rtcEngine;
//   final int remoteUid;
//
//   VideoCallPage({required this.channelName, required this.rtcEngine, required this.remoteUid});
//
//   @override
//   _VideoCallPageState createState() => _VideoCallPageState();
// }
//
// class _VideoCallPageState extends State<VideoCallPage> {
//   @override
//   void dispose() {
//     widget.rtcEngine.leaveChannel();
//     widget.rtcEngine.release();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Call'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Channel Name: ${channel}'),
//             SizedBox(height: 16.0),
//             Text('Remote UID: ${widget.remoteUid}'),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Enable video
//                 widget.rtcEngine.enableVideo();
//
//                 // Enable audio
//                 widget.rtcEngine.enableAudio();
//
//                 // Set the video configuration
//                 widget.rtcEngine.setVideoEncoderConfiguration(VideoEncoderConfiguration());
//
//                 // Join the channel
//                 widget.rtcEngine.joinChannel(token: token, channelId: channel, uid: 0, options: ChannelMediaOptions());
//                 // Implement your logic to start the video call
//               },
//               child: Text('Start Video Call'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }