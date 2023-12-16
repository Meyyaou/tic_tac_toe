import 'package:flutter/material.dart';

class GameButton {
  int? id;
  Color? clr;
  bool? played;
  String? play; // X/O

  GameButton(id) {
    this.id = id;
    this.played = false;
    this.play = "";
  }

  void setColor(Color? color) {
    clr = color;
  }
}
