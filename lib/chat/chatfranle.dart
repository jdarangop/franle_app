import 'package:flutter/material.dart';
import 'package:franle_app/chat/appbarstyle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import './bubble.dart';

class ChatFran extends StatefulWidget {
  final WebSocketChannel channel = 
  IOWebSocketChannel.connect('ws://34.74.231.8'); //Socket channel
  String nativeLang;
  String learningLang;
  String username;

  ChatFran({this.nativeLang, this.learningLang, this.username});
 
  @override
  _ChatFranState createState() => _ChatFranState(
    channel: channel,
    nativeLang: nativeLang,
    learningLang: learningLang,
    username: username
  );
}

class _ChatFranState extends State<ChatFran> {
  SpeechRecognition _speechRecognition;
  final WebSocketChannel channel;
  List<Map> messages = [];
  String resultText = "";
  bool _isAvailable = false;
  bool _isListening = false;
  String nativeLang;
  String learningLang;
  String username;
  var languages = {
    'Español': ['"spa"', 'es_CO', 'es-CO'],
    'English': ['"eng"', 'en_US', 'en-US'],
    'Deutsch': ['"deu"', 'de_DE', 'de-DE'],
    'Français': ['"fr"', 'fr_FR', 'fr-FR'],
  };


  _ChatFranState({this.channel, this.nativeLang, this.learningLang, this.username}) {
    //ChatFran constructor
    channel.sink.add('{"nativeLang":' + languages[nativeLang][0] + ', ' + '"newLang":' + languages[learningLang][0] + ', "username":"' + username  +'"}');
    channel.stream.listen((data) {
      var tmp = {'data': data, 'send':true, 'lang': languages[learningLang][2]};
      setState(() {
        messages.add(tmp);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer(); //Initialize speech recognition
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: 
        PreferredSize(
        preferredSize: Size.fromHeight(height * 0.15),
        child: AppBar(
          bottomOpacity: 1,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 131, 179, 0.6),
          title: Text("Franle", style: GoogleFonts.norican(fontSize: 50),),
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
          padding: EdgeInsets.all(height*0.02),
          child: Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: chatList(),
            ),
          ]
        ),
      ),
        ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.14),
        child: BottomAppBar(
          color: Color.fromRGBO(0, 131, 179, 0.6),
          child: Padding(
            padding: EdgeInsets.all(height * 0.032),
          ),
          shape: AutomaticNotchedShape(CubicBezierShapeBorderBottom(),), // CircleBorder(),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          Container(
      child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'btn1',
                  child: Icon(Icons.cancel),
                  backgroundColor: Color.fromRGBO(255, 144, 25, 0.8),
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.cancel().then(
                          (result) => setState(() {
                              _isListening = result;
                              resultText = "";
                      }),
                    );
                  },
                ),
                FloatingActionButton(
                  heroTag: 'btn2',
                  child: Icon(Icons.mic),
                  onPressed: () {
                    if (_isAvailable && !_isListening) {
                      _speechRecognition
                          .listen(locale: languages[nativeLang][1])
                          .then((result) {
                          });
                    }
                  },
                  backgroundColor: Color.fromRGBO(255, 144, 25, 0.8),
                ),
                FloatingActionButton(
                  heroTag: 'btn3',
                  child: Icon(Icons.stop),
                  backgroundColor: Color.fromRGBO(255, 144, 25, 0.8),
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.stop().then(
                            (result) {
                              setState(() => _isListening = result);
                              sendChat(resultText);
                            }
                          );
                  },
                ),
              ],
            ),
    ),
    );
  }

  // For display the list of bubbles chats
  ListView chatList() {
    List<Widget> listaChats = [];

    for (var mess in messages) {
      listaChats.add(Bubble(message: mess['data'], send: mess['send'], language: mess['lang']));
    }
    return ListView(children: listaChats,);
  }

  // Send the text chat to web socket
  void sendChat(String text) {
    if (text != "") {
      var temp = '{"message":"' + text + '", "username":"' + username + '"}';
      channel.sink.add(temp);
      var tmp = {'data': text, 'send': false, 'lang': languages[nativeLang][2]};
      setState(() {
        messages.add(tmp);
      });
    }
  }
}