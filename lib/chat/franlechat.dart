import 'package:flutter/material.dart';
import './bubble.dart';
//import 'package:google_fonts/google_fonts.dart';

class ChatFranle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Color.fromRGBO(255, 131, 0, 0.8),
        title: Center(child: Text("Franle",)),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(600, 600),
            bottomRight: Radius.elliptical(0, 0))),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Bubble(
              time: '12:00',
              send: false,
            ),
            Bubble(
              time: '12:01',
              send: false,
            ),
            Bubble(
              time: '12:02',
              send: true,
            ),
            Bubble(
              time: '12:03',
              send: false,
            ),
          ],
        ),
      ),
    );
  }
}

class ShapeAppBar extends ContinuousRectangleBorder {

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    /*Path path = Path();
    path.quadraticBezierTo(rect.width + 50, rect.height, rect.width, rect.height);
    
    return path;*/
    final double innerCircleRadius = 150.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30, rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75, rect.height + 50
    );
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}


class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {

    //final double innerCircleRadius = 150.0;

    Path path = Path();
    //path.lineTo(0, rect.height + 50);
    //path.cubicTo(250, rect.height, 200, 200, rect.width, 0);
    //path.quadraticBezierTo(0.12 * rect.width, 0.98 * rect.height, 0.93 * rect.width, 0.08 * rect.height + 50);
    /*path.cubicTo(
        rect.width, rect.height,
        rect.width, rect.height+50,
        rect.width+50, rect.height
    );*/
    //path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    //path.lineTo(0, rect.height);
    //path.lineTo(rect.width, 0);
    //path.lineTo(0, rect.height);
    //path.lineTo(rect.width, rect.height);
    //path.lineTo(0, 0);
    /*path.lineTo(0.0, size.height - 20);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;*/
    path.close();

    return path;
  }
}