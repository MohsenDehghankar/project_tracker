import 'package:flutter/material.dart';
import 'package:project_tracker/style/colors.dart';

class ContainerDecoration {
  static Decoration getDecoration(){
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            ConstColors.gradientStart,
            ConstColors.gradientEnd
          ]),
    );
  }
}