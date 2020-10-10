import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/style/colors.dart';

/// body to show when an error occurs
class ErrorBody {
  static Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [ConstColors.gradientStart, ConstColors.gradientEnd]),
        ),
        child: Center());
  }
}
