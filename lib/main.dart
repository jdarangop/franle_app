import 'package:flutter/material.dart';
import 'package:franle_app/chat/chatfranle.dart';
import 'package:franle_app/web_socket/websocket.dart';
import './chat/franlechat.dart';

void main() => runApp(MyApp());

// This opction it's for debuggin the responsive
/*void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(),
  ),
);*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //builder: DevicePreview.appBuilder,
      home: ChatFran(), // ChatFranle(), WebSocketChat(),
    );
  }
}