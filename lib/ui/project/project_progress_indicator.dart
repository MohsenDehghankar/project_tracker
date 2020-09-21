import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectProgressIndicator {
  static Widget build(Color color, int percent, String title, double width) {
    return CircularPercentIndicator(
      radius: width / 5 < 70.0 ? width / 5 : 70.0,
      lineWidth: 5.0,
      percent: percent / 100,
      center: Text(
        percent.toString() + "%",
        style: TextStyle(color: Colors.white),
      ),
      footer: Flexible(
          child: Text(
        title,
        style: TextStyle(color: Colors.white),
      )),
      progressColor: color,
      animation: true,
      animationDuration: 2000,
      animateFromLastPercent: true,
      curve: Curves.easeIn,
    );
  }
}
