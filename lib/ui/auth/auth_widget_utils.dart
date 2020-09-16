import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/style/strings.dart';

///
/// Builder for description part in Login
///
class DescWidgetBuilder {
  Orientation orientation;
  String desc;
  Size size;

  // get height of container containing this widget
  double _getHeight() => (orientation == Orientation.portrait)
      ? size.height / 3
      : size.height - AppBar().preferredSize.height;

  // get width of container containing this widget
  double _getWidth() =>
      (orientation == Orientation.portrait) ? size.width : size.width / 2;

  // get sub widgets for this widget
  Widget _getChild() {
    return Scrollbar(
      thickness: 10.0,
      radius: Radius.circular(20.0),
      child: SingleChildScrollView(
        child: Text(
          desc,
          style: TextStyle(
            fontSize: 20.0,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget build() {
    return Container(
        constraints:
            BoxConstraints(maxHeight: _getHeight(), maxWidth: _getWidth()),
        margin: EdgeInsets.all(20.0),
        key: UniqueKey(),
        child: _getChild());
  }
}

///
/// Builder for Input parts in Login Page
///
class LoginWidgetBuilder {
  Orientation orientation;
  bool isUsrLogin;
  Size size;

  // build button in login page
  Widget _buildLoginButton(void Function() onPress) {
    return Center(
        child: Container(
            margin: EdgeInsets.all(15.0),
            width: _getTextFieldWidth(),
            child: RaisedButton(
              key: UniqueKey(),
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              textTheme: ButtonTextTheme.normal,
              onPressed: onPress,
              child: Container(
                child: Center(
                    child: Text(isUsrLogin ? Strings.next : Strings.login)),
              ),
            )));
  }

  double _getTextFieldWidth() =>
      orientation == Orientation.landscape ? size.width / 3 : size.width;

  // build input text field
  Widget _buildInputField(void Function() btnPressed) {
    return Container(
        margin: EdgeInsets.all(20.0),
        width: _getTextFieldWidth(),
        child: TextField(
          key: UniqueKey(),
          onSubmitted: (input) => btnPressed(),
          textInputAction: TextInputAction.next,
          obscureText: !isUsrLogin,
          decoration: InputDecoration(
              labelText: isUsrLogin ? Strings.username : Strings.password),
        ));
  }

  // button to return to username
  Widget _getReturnWidget(void Function() returnToUsername) {
    return Center(
      child: FlatButton(
          onPressed: returnToUsername, child: Text(Strings.returnToUsername)),
    );
  }

  Widget build(
      void Function() buttonPressed, void Function() returnToUsername) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        _buildInputField(buttonPressed),
        _buildLoginButton(buttonPressed),
        isUsrLogin ? Center() : _getReturnWidget(returnToUsername)
      ],
    )));
  }
}
