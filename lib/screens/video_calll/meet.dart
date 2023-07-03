
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  // final  AgoraClient _client = AgoraClient(
  //     agoraConnectionData:
  //     AgoraConnectionData(
  //         appId: '6b5e05bfcd2140cb9b8ba5a46a81f0d3',
  //         channelName: 'agora2023',
  //         tempToken: '007eJxTYMiLuZahe8opyCNAR4vpRvNGXkaVeL7bV1sWTDm0s0p54lIFBrMk01QD06S05BQjQxOD5CTLJIukRNNEE7NEC8M0gxRjRb+GlIZARobX0g1MjAwQCOJzMiSm5xclGhkYGTMwAABPJh7B')
  // );
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  late RtcEngine _engine;
  String app_id = "6d23c50fff654240b43df4285a16a3b8";
  String channelName = "test";
  String token = "007eJxTYGhUK3opzae17eD5aj/J1ezcYutt/b9+UQ668CvR9Mcat0gFBrMUI+NkU4O0tDQzUxMjE4MkE+OUNBMjC9NEQ7NE4yQLwWmzUxoCGRm2NFgyMzJAIIjPwlCSWlzCwAAA0U8d2Q==";

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _initagora();
  }

  Future<void> _initagora() async {
    // await _client.initialize();
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.enableAudioVolumeIndication(200, 3, true);
    await _engine.joinChannel(token,channelName, null, 0);
    await _engine.enableDualStreamMode(true);
    await _engine.setParameters("""
         { "che.video.lowBitRateStreamParameter": {
           "width":160,"height":120,"frameRate":5,"bitRate":45
         }}
       """);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(app_id);
    await _engine.enableVideo();
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      activeSpeaker: (uid) {
        final String info = "Active speaker: $uid";
        print(info);
      },
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        });
        if (_users.length >= 5) {
          print("Fallback to Low quality video stream");
          _engine.setRemoteDefaultVideoStreamType(VideoStreamType.Low);
        }
      },
      userOffline: (uid, reason) {
        setState(() {
          final info = 'userOffline: $uid , reason: $reason';
          _infoStrings.add(info);
          _users.remove(uid);
        });
        if (_users.length <= 3) {
          print("Go back to High quality video stream");
          _engine.setRemoteDefaultVideoStreamType(VideoStreamType.High);
        }
      },
    ));
  }

  Widget _showViewCounter(){
    return Container(
      height: 20.0,
      width: 30.0,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.grey[700],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.remove_red_eye,
            color: Colors.white,
            size: 15.0,
            textDirection: TextDirection.ltr,
          ),
          Text('${_infoStrings.length}',style: TextStyle(color: Colors.white,fontSize: 15),)
        ],
      ),
    );
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Consultation '),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            Positioned(
                left:  MediaQuery.of(context).size.width *0.9,
                child: _showViewCounter()),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    list.add(rtc_local_view.SurfaceView());
    _users.forEach(
          (int uid) => list.add(
        rtc_remote_view.SurfaceView(
          uid: uid,
          channelId: '',
        ),
      ),
    );
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }


  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    if (views.length == 1) {
      return Container(
        child: Column(
          children: <Widget>[_videoView(views[0])],
        ),
      );
    } else if (views.length == 2) {
      return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow([views[0]]),
              _expandedVideoRow([views[1]])
            ],
          ));
    } else if (views.length > 2 && views.length % 2 == 0) {
      return Container(
        child: Column(
          children: [
            for (int i = 0; i < views.length; i = i + 2)
              _expandedVideoRow(
                views.sublist(i, i + 2),
              ),
          ],
        ),
      );
    } else if (views.length > 2 && views.length % 2 != 0) {
      return Container(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < views.length; i = i + 2)
              i == (views.length - 1)
                  ? _expandedVideoRow(views.sublist(i, i + 1))
                  : _expandedVideoRow(views.sublist(i, i + 2)),
          ],
        ),
      );
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

// @override
// Widget build(BuildContext context) {
//   return WillPopScope(
//     onWillPop: () async=> false,
//     child: Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Video call"),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // AgoraVideoViewer(client: _client,layoutType: Layout.floating,showNumberOfUsers: true,),
//             // AgoraVideoButtons(client: _client,
//             // enabledButtons: [
//             //   BuiltInButtons.toggleCamera,
//             //   BuiltInButtons.callEnd,
//             //   BuiltInButtons.switchCamera
//             // ],)
//           ],
//         ),
//       ),
//     ),
//   );
// }

}