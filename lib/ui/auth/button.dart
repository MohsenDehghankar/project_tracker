import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/style/colors.dart';

///
/// Button Widget for Auth Page
///
class Button {
  Size size;
  bool error;
  TextEditingController textController;

  Button(this.size, this.error, this.textController);

  Widget build(void Function(String input) onPress, String text,
      Orientation orientation) {
    EdgeInsetsGeometry pad = orientation == Orientation.portrait
        ? EdgeInsets.only(top: 40, right: 10, )//left: size.width / 2 + 30)
        : EdgeInsets.only(top: 40, right: 30, );//left: size.width / 4 + 10);
    return Padding(
      key: UniqueKey(),
      padding: pad,
      // padding: const EdgeInsets.all(40.0),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 40,
        width: size.width / 3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ConstColors.authButtonShadowColor,
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: ConstColors.authButtonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          // focusNode: focusNode,
          key: UniqueKey(),
          onPressed: error
              ? () {}
              : () {
                  onPress(textController.text);
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  color: ConstColors.authButtonTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: ConstColors.authButtonTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
