import 'package:flutter/material.dart';
import 'package:franle_app/voice/text2Speech.dart';

class Bubble extends StatelessWidget {
  final String message;
  final send;
  String language;

  Bubble({this.message, this.send, this.language});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
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
          margin: EdgeInsets.all(size * 0.01),
          padding: EdgeInsets.all(size * 0.01),
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
                padding: EdgeInsets.only(right: size * 0.25),
                child: Text2Speech(text: message, language: language,),
              ),
            ],
          ),
        )
      ],
    );
  }
}