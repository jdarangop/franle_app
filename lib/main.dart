import 'package:flutter/material.dart';
import 'package:franle_app/chat/chatfranle.dart';
import 'package:franle_app/chat/loginscreen.dart';
import 'package:franle_app/selection/selection_page.dart';
import 'package:franle_app/web_socket/websocket.dart';
import './chat/franlechat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}