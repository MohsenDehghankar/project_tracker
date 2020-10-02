import 'package:flutter/material.dart';

class ContainerDecoration {
  static Decoration getDecoration(){
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blueGrey,
            Colors.lightBlueAccent
          ]),
    );
  }
}