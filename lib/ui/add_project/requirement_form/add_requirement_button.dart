import 'package:flutter/material.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/style/strings.dart';

class AddRequirementButton {
  static Widget build(void Function() onPressed, BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        height: 40,
        constraints: BoxConstraints(maxWidth: 150.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ConstColors.authButtonShadowColor, //Colors.blue[300],
              blurRadius: 10.0,
              // has the effect of softening the shadow
              spreadRadius: 1.0,
              // has the effect of extending the shadow
              offset: Offset(
                5.0,
                // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: ConstColors.authButtonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
            onPressed: onPressed,
            child: Center(
              child: Text(
                Strings.addRequirement,
                style: TextStyle(
                  color: ConstColors.authButtonTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )));
  }
}
