import 'package:flutter/material.dart';
import './chat/franlechat.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatFranle(),
    );
  }
}