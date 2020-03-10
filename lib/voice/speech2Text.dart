import 'package:flutter/material.dart';
import 'package:franle_app/web_socket/websocket.dart';
import 'package:speech_recognition/speech_recognition.dart';

class Speech2Text extends StatefulWidget {
  WebSocketChat channel;

  Speech2Text({this.channel});
  @override
  _Speech2TextState createState() => _Speech2TextState(channel: channel);
}

class _Speech2TextState extends State<Speech2Text> {
  SpeechRecognition _speechRecognition;
  /*bool _isAvailable = false;
  bool _isListening = false;*/
  WebSocketChat channel;

  String resultText = "";

  _Speech2TextState({this.channel});

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    /*_speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );*/

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    /*_speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*FloatingActionButton(
                  child: Icon(Icons.cancel),
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.cancel().then(
                          (result) => setState(() {
                              _isListening = result;
                              resultText = "";
                          }),
                      );
                  },
                ),*/
                FloatingActionButton(
                  child: Icon(Icons.mic),
                  onPressed: () {
                    channel.sendChat('UltimaaaPrueba');
                    /*channel.channel.sink.add('Pruebaaaaaaaaaaaaaaaaaaa12453');
                    var tmp = {'data': 'Pruebaaaaaaaaaaaaaaaaaaa12453', 'send': false};
                    setState(() {
                      channel.messages.add(tmp);
                    });*/
                    //obj.sendChat('Pruebaaaaaaaaaaaaaaaaaaa12453');
                    //if (_isAvailable && !_isListening) {
                     /* _speechRecognition
                          .listen(locale: "en_US")
                          .then((result) {
                            
                          });*/
                    //}
                  },
                  backgroundColor: Colors.pink,
                ),
                /*FloatingActionButton(
                  child: Icon(Icons.stop),
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.stop().then(
                            (result) => setState(() => _isListening = result),
                          );
                  },
                ),*/
              ],
            ),
    );
  }
}