import 'package:flutter/material.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/style/strings.dart';


///
/// TextInput Widget for Auth Page
///
class TextInput {
  Size size;
  Key _textKey;
  TextEditingController textController;
  bool isUsrLogin;
  bool error;

  TextInput(this.size, this._textKey, this.textController, this.isUsrLogin,
      this.error);

  Widget build(void Function(String input) btnPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        // height: 60,
        width: size.width,
        child: TextField(
          key: _textKey,
          controller: textController,
          onSubmitted: btnPressed,
          textInputAction: TextInputAction.next,
          obscureText: !isUsrLogin,
          style: TextStyle(
            color: ConstColors.inputTxtColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: isUsrLogin ? Strings.username : Strings.password,
            errorText: error ? Strings.empty : null,
            labelStyle: TextStyle(
              color: ConstColors.inputLblColor,
            ),
          ),
        ),
      ),
    );
  }
}
