import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/style/strings.dart';

///
/// Builder for description part in Login
///
class DescWidgetBuilder {
  Orientation orientation;
  Size size;

  // get height of container containing this widget
  double _getHeight() => (orientation == Orientation.portrait)
      ? size.height / 3
      : size.height - AppBar().preferredSize.height;

  // get width of container containing this widget
  double _getWidth() =>
      (orientation == Orientation.portrait) ? size.width : size.width / 2;

  // get sub widgets for this widget
  Widget _getChildByStr(String desc) {
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

  Widget _getChild() {
    return BlocBuilder<AuthBLoC, AuthState>(builder: (context, state) {
      if (state is AuthStateStart) {
        return _getChildByStr(Strings.userPageDescription);
      } else {
        // todo other states
        return _getChildByStr(Strings.passPageDescription);
      }
    });
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
  Size size;
  TextEditingController textController;

  LoginWidgetBuilder() {
    textController = TextEditingController();
  }

  // build button in login page
  Widget _buildLoginButton(void Function(String input) onPress) {
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
              onPressed: () {
                onPress(textController.text);
              },
              child: Container(
                child: Center(child: _getBtnText()),
              ),
            )));
  }

  Widget _getBtnText() {
    return BlocBuilder<AuthBLoC, AuthState>(
      builder: (context, state) {
        if (state is AuthStateStart) {
          return Text(Strings.next);
        } else {
          return Text(Strings.login);
        }
      },
    );
  }

  Widget _buildLoginButtonByState() {
    return BlocBuilder<AuthBLoC, AuthState>(builder: (context, state) {
      if (state is AuthStateStart) {
        return _buildLoginButton((input) {
          BlocProvider.of<AuthBLoC>(context).add(AuthEventAddUsername(input));
        });
      } else if (state is AuthStateUsernameEntered) {
        return _buildLoginButton((input) {
          BlocProvider.of<AuthBLoC>(context).add(AuthEventAddPassword(input));
        });
      } else {
        // todo other states
        return Center();
      }
    });
  }

  double _getTextFieldWidth() =>
      orientation == Orientation.landscape ? size.width / 3 : size.width;

  // build input text field
  Widget _buildInputField(void Function(String input) btnPressed, isUsrLogin) {
    return Container(
        margin: EdgeInsets.all(20.0),
        width: _getTextFieldWidth(),
        child: TextField(
          key: UniqueKey(),
          controller: textController,
          onSubmitted: btnPressed,
          textInputAction: TextInputAction.next,
          obscureText: !isUsrLogin,
          decoration: InputDecoration(
              labelText: isUsrLogin ? Strings.username : Strings.password),
        ));
  }

  Widget _buildInputTextFieldByState() {
    return BlocBuilder<AuthBLoC, AuthState>(builder: (context, state) {
      if (state is AuthStateStart) {
        return _buildInputField((input) {
          BlocProvider.of<AuthBLoC>(context).add(AuthEventAddUsername(input));
        }, true);
      } else if (state is AuthStateUsernameEntered) {
        return _buildInputField((input) {
          BlocProvider.of<AuthBLoC>(context).add(AuthEventAddPassword(input));
        }, false);
      } else {
        // todo other states
        return Center();
      }
    });
  }

  // button to return to username
  Widget _getReturnWidget(void Function() onPresssed) {
    return Center(
      child: FlatButton(
          onPressed: onPresssed, child: Text(Strings.returnToUsername)),
    );
  }

  Widget _buildReturnWidgetByState() {
    return BlocBuilder<AuthBLoC, AuthState>(
      builder: (context, state) {
        if (state is AuthStateUsernameEntered) {
          return _getReturnWidget(() {
            BlocProvider.of<AuthBLoC>(context).add(AuthEventReturnToUsername());
          });
        } else {
          // todo other states
          return Center();
        }
      },
    );
  }

  Widget build() {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        _buildInputTextFieldByState(),
        _buildLoginButtonByState(),
        _buildReturnWidgetByState(),
      ],
    )));
  }
}
