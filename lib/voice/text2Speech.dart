import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Text2Speech extends StatefulWidget {
  String text;
  String language;

  Text2Speech({this.text, this.language});

  @override
  _Text2SpeechState createState() => _Text2SpeechState(text: text, language: language);
}

class _Text2SpeechState extends State<Text2Speech> {

  FlutterTts flutterTts;
  String text;
  String language;

  _Text2SpeechState({this.text, this.language});

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();
    //flutterTts.setLanguage('en-US');
    flutterTts.setLanguage('es-CO');
    //_getLanguages();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future _speak() async {
    await flutterTts.setVolume(0.5);
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.setPitch(0.5);

    if (text != null && text.isNotEmpty) {
      await flutterTts.speak(text);
      //if (result == 1) setState(() => ttsState = TtsState.playing);
    }
  }

  Future _stop() async {
    await flutterTts.stop();
    //if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.2,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () => _speak(),
          color: Colors.white,
          splashColor: Colors.white,
        ),
        IconButton(
          icon: Icon(Icons.stop),
          onPressed: () => _stop(),
          color: Colors.white,
          splashColor: Colors.white,
        ),
      ]),      
    );
  }
}