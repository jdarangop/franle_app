import 'package:flutter/material.dart';
import 'package:franle_app/chat/bubble.dart';

ListView chatList(List messList) {
  List<Widget> listaChats = [];

  for (String mess in messList) {
    listaChats.add(Bubble(message: mess, send: true));
  }
  return ListView(children: listaChats,);
}