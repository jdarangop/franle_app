import 'package:flutter/material.dart';
import 'package:franle_app/chat/appbarstyle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import './bubble.dart';

class ChatFran extends StatefulWidget {
  final WebSocketChannel channel = 
  IOWebSocketChannel.connect('ws://34.74.231.8');
  String nativeLang;
  String learningLang;

  ChatFran({this.nativeLang, this.learningLang});
 
  @override
  _ChatFranState createState() => _ChatFranState(
    channel: channel,
    nativeLang: nativeLang,
    learningLang: learningLang
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
  var languages = {
    'Español': '"spa"',
    'English': '"eng"',
    'Deutsch': '"deu"',
    'Français': '"fr"',
  };


  _ChatFranState({this.channel, this.nativeLang, this.learningLang}) {
    channel.sink.add('{"nativeLang":' + languages[nativeLang] + ', ' + '"newLang":' + languages[learningLang] +'}');
    channel.stream.listen((data) {
      var tmp = {'data': data, 'send':true};
      print(data);
      setState(() {
        messages.add(tmp);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
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
        //preferredSize: Size.fromHeight(110),
        preferredSize: Size.fromHeight(height * 0.15),
        child: AppBar(
          bottomOpacity: 1,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 131, 179, 0.6),
          //backgroundColor: Color.fromRGBO(255, 131, 0, 0.8),
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
          //padding: EdgeInsets.all(16.0),
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
      ),//WebSocketChat(),
        ),
      bottomNavigationBar: PreferredSize(
        //preferredSize: Size.fromHeight(100),
        preferredSize: Size.fromHeight(height * 0.14),
        child: BottomAppBar(
          color: Color.fromRGBO(0, 131, 179, 0.6),
          //color: Color.fromRGBO(255, 131, 0, 0.8),
          child: Padding(
            //padding: const EdgeInsets.all(23.0),
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
                    //channel.sendChat('UltimaaaPrueba');
                    /*channel.channel.sink.add('hey how are you?');
                    var tmp = {'data': 'hey how are you', 'send': false};
                    setState(() {
                      channel.messages.add(tmp);
                    });*/
                    //obj.sendChat('Pruebaaaaaaaaaaaaaaaaaaa12453');
                    //if (_isAvailable && !_isListening) {
                      _speechRecognition
                          .listen(locale: "en_US")
                          .then((result) {
                            sendChat(resultText);
                          });
                      //sendChat(resultText);
                      /*channel.sink.add(resultText);
                      var tmp = {'data': resultText, 'send': false};
                      setState(() {
                        messages.add(tmp);
                      });*/
                    //}
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

  ListView chatList() {
    List<Widget> listaChats = [];

    for (var mess in messages) {
      listaChats.add(Bubble(message: mess['data'], send: mess['send']));
    }
    return ListView(children: listaChats,);
  }

  void sendChat(String text) {
    print(text + " is into the sendChat");
    //if (text.isEmpty) {
    if (text != "") {
      channel.sink.add(text);
      var tmp = {'data': text, 'send': false};
      setState(() {
        messages.add(tmp);
      });
    }
    //}
  }
}