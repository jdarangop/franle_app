import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:franle_app/chat/appbarstyle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:franle_app/selection/selection_page.dart';

Future<User> fetchUser(username) async {
  final response =
      await http.get('http://35.190.175.59/users/' + username); //concatenate

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    // If the username in the request is wrong
    throw Exception('Not found');
  }
}

class User {
  final String username;
  final String password;

  User({this.username, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }
}

class Data {
  String nameInput;
  String passInput;
}

var newUser = Data();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        child: Container(
          child: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 131, 0, 0.6),
          shape: CubicBezierLogin(),
          ),
          ),
        ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01),
            child: Text('Franle',
              style: GoogleFonts.norican(
                fontSize: 50,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 1,
              left: MediaQuery.of(context).size.width * 0.09,
              right: MediaQuery.of(context).size.width * 0.09,
              ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  onChanged: (usernameInput) {
                    newUser.nameInput = usernameInput;
                  }
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  onChanged: (passwordInput) {
                    newUser.passInput = passwordInput;
                  }
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    color: Color.fromRGBO(255, 131, 0, 0.6),
                    onPressed: () {

                      Future<void> checkingUser() async {

                        try {
                          var futureUser = await fetchUser(newUser.nameInput);
                          if (futureUser.password == newUser.passInput) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SelectScreen(username: newUser.nameInput)),
                            );
                          } else {
                            throw 'Incorrect password';
                          }
                        } catch (err) {
                          print(err);
                        }
                      }

                      checkingUser();
                    },
                    child: Text('Login')
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () {
                      //Not implemented yet
                    },
                    child: Text('Forgot your password?'),
                  ),
                ),
              ],
            ),
          ),   
        ],
      ),
    );
  }
}