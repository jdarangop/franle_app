import 'package:flutter/material.dart';
import 'package:franle_app/chat/appbarstyle.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(0, 131, 179, 0.8),
      appBar:
        PreferredSize(
        //preferredSize: Size.fromHeight(110),
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
                color: Color.fromRGBO(0, 131, 179, 0.8),
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
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    color: Color.fromRGBO(255, 131, 0, 0.6),
                    onPressed: () {},
                    child: Text('Login')
                  ),
                ),
                Container(
                  child: FlatButton(onPressed: () {},
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