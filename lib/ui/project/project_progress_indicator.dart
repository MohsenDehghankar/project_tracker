import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_tracker/style/fonts.dart';

/// progress indicators for a project in projects page
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
        style: GoogleFonts.getFont(Fonts.mainFont, color: Colors.white),
      )),
      progressColor: color,
      animation: true,
      animationDuration: 2000,
      animateFromLastPercent: true,
      curve: Curves.easeIn,
    );
  }
}
