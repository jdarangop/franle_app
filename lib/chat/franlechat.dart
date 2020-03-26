import 'package:flutter/material.dart';
import 'package:franle_app/chat/appbarstyle.dart';
import 'package:franle_app/voice/speech2Text.dart';
import 'package:franle_app/web_socket/websocket.dart';
import './bubble.dart';


class ChatFranle extends StatelessWidget {
  WebSocketChat canal = new WebSocketChat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          backgroundColor: Color.fromRGBO(255, 131, 0, 0.8),
          title: Center(child: Text("Franle",)),
          shape: CubicBezierShapeBorder(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: null,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 131, 0, 1),
              ),
            ),
            ListTile(
              title: Text('Next'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Report'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Block'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ]
        ),
      ),
      body:
        Padding(
          padding: EdgeInsets.all(16.0),
          child: canal,
        ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: BottomAppBar(
          color: Color.fromRGBO(255, 131, 0, 0.8),
          child: Padding(
            padding: const EdgeInsets.all(23.0),
          ),
          shape: AutomaticNotchedShape(CubicBezierShapeBorderBottom(), CircleBorder(),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Speech2Text(channel: canal),
    );
  }
}