import 'package:flutter/material.dart';
import 'package:franle_app/voice/speech2Text.dart';
import 'package:franle_app/web_socket/websocket.dart';
import './bubble.dart';
//import 'package:google_fonts/google_fonts.dart';

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
          child: canal,//WebSocketChat(),
        ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: BottomAppBar(
          color: Color.fromRGBO(255, 131, 0, 0.8),
          child: Padding(
            padding: const EdgeInsets.all(23.0),
            //child: Icon(Icons.mic),
          ),
          shape: AutomaticNotchedShape(CubicBezierShapeBorderBottom(), CircleBorder(),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Speech2Text(channel: canal),/*FloatingActionButton(onPressed: () {
        canal.channel.sink.add('Pruebaaaaaaaaaaaaaaaaaaa12453');
        var tmp = {'data': 'Pruebaaaaaaaaaaaaaaaaaaa12453', 'send': false};
        canal.messages.add(tmp);
        //WebSocketChatState obj = new WebSocketChatState(channel: canal.channel);
        //obj.sendChat('Pruebaaaaaaaaaaaaaaaaaaa12453');
      },
        child: Icon(Icons.mic),
      ),*/
    );
  }
}


class CubicBezierShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    Offset control1 = Offset(rect.width, rect.height * 1.8);
    Offset control2 = Offset(0.0, 0.0);
    Offset endPoint = Offset(rect.width, rect.height * 0.0);
    path.lineTo(0.0, rect.height* 1.20);
    path.cubicTo(
        control2.dx, control2.dy, control1.dx, control1.dy, endPoint.dx,
        endPoint.dy);
    path.lineTo(0.0, 0.0);
    
    path.close();
    return path;
  }
}

class CubicBezierShapeBorderBottom extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    Offset control1 = Offset(rect.width, rect.height * 0.66);
    Offset control2 = Offset(0.0, rect.height * -2.33);
    Offset endPoint = Offset(rect.width, rect.height * -2.0);
    path.cubicTo(
        control2.dx, control2.dy, control1.dx, control1.dy, endPoint.dx,
        endPoint.dy);
    path.lineTo(rect.width, rect.height);
    path.lineTo(0.0, rect.height);
    path.lineTo(0.0, 0.0);

    
    path.close();
    return path;
  }
}