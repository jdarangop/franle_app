import 'package:flutter/material.dart';
import 'package:franle_app/voice/text2Speech.dart';

class Bubble extends StatelessWidget {
  final String message;
  final send;

  Bubble({this.message, this.send});

  @override
  Widget build(BuildContext context) {
    final colorChat = send ? Color.fromRGBO(255, 144, 25, 0.8) : Color.fromRGBO(0, 131, 179, 0.8);
    final align = send ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final radius = send
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );

    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(7.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: colorChat,
            borderRadius: radius,
          ),
          child:
            Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 220.0),
                child: Text2Speech(text: message),
              ),
            ],
          ),
        )
      ],
    );
  }
}