import 'package:flutter/material.dart';
import 'package:franle_app/chat/bubble.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketChat extends StatefulWidget {
  final WebSocketChannel channel = 
  IOWebSocketChannel.connect('ws://34.74.231.8');
  List<Map> messages = [];
  String text = "";

  //WebSocketChat({this.text})
  void sendChat(String text) {
    text = text;
  }

  @override
  WebSocketChatState createState() => WebSocketChatState(channel: channel, messages: messages, text: text);
}

class WebSocketChatState extends State<WebSocketChat> {
  final WebSocketChannel channel;
  List<Map> messages;
  String text;

  WebSocketChatState({this.channel, this.messages, this.text}) {
    channel.sink.add('{"nativeLang":"eng", "newLang":"spa"}');
    if (text.isNotEmpty) {
      sendChat(text);
    }
    channel.stream.listen((data) {
      var tmp = {'data': data, 'send':true};
      print(data);
      setState(() {
        messages.add(tmp);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
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

    for (var mess in messages) {
      listaChats.add(Bubble(message: mess['data'], send: mess['send']));
    }
    return ListView(children: listaChats,);
  }

  void startListen() {

  }

  @override
  void sendChat(String text) {
    print(text);
    //if (text.isEmpty) {
    channel.sink.add(text);
    var tmp = {'data': text, 'send': false};
    setState(() {
        messages.add(tmp);
    });
    //}
  }
}