import 'package:flutter/material.dart';
import 'package:franle_app/chat/bubble.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketChat extends StatefulWidget {
  final WebSocketChannel channel = 
  IOWebSocketChannel.connect('ws://34.74.231.8');

  @override
  _WebSocketChatState createState() => _WebSocketChatState(channel: channel);
}

class _WebSocketChatState extends State<WebSocketChat> {
  final WebSocketChannel channel;
  List<String> messages = [];

  _WebSocketChatState({this.channel}) {
    channel.sink.add('{"nativeLang":"eng", "newLang":"spa"}');
    channel.stream.listen((data) {
      print(data);
      setState(() {
        messages.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: chatList(),
            ),
          ]
      ),
    );
  }

  ListView chatList() {
    List<Widget> listaChats = [];

    for (String mess in messages) {
      listaChats.add(Bubble(message: mess, send: true));
    }
    return ListView(children: listaChats,);
  }
}