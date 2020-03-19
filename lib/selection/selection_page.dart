import 'package:flutter/material.dart';
import 'package:franle_app/chat/chatfranle.dart';
import 'package:franle_app/chat/franlechat.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectScreen extends StatefulWidget {
  String username;

  SelectScreen({this.username});

  @override
  SelectScreenState createState() => SelectScreenState(username: username);
}

class SelectScreenState extends State<SelectScreen> {
  String _nativeLanguage;
  String _learningLanguage;
  String username;
  List<String> idioms = ['Español', 'English', 'Deutsch', 'Français'];

  SelectScreenState({this.username});

  @override
  void initState() {
    _nativeLanguage = null;
    _learningLanguage = null;
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
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 131, 179, 0.6),
          shape: CubicBezierShapeBorder(),
          ),
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
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                child: Text('Native Language:'),
              ),
              DropdownButton(
                value: _nativeLanguage,
                items: idioms.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (String language) {
                  setState(() {
                    _nativeLanguage = language;
                  });
                },)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                child: Text('Learning:'),
              ),
              DropdownButton(
                value: _learningLanguage,
                items: idioms.map((String value) {
                  /*if (_nativeLanguage != null) {
                    idioms.removeWhere((item) => item == _nativeLanguage);
                  }*/
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (String language) {
                  setState(() {
                    _learningLanguage = language;
                  });
                },)
            ],
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatFran(nativeLang: _nativeLanguage,
                  learningLang: _learningLanguage,
                  username: username)),
              );
            },
            child: Text('Start'),)
        ],
      ),
    );
  }
}