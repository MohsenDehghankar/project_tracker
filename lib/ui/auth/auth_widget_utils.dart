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
      key: UniqueKey(),
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

  // get child based on BLoC state
  Widget _getChild(BuildContext context, AuthState state) {
    return AnimationBuilder.build((state is AuthStateStart)
        ? _getChildByStr(Strings.userPageDescription)
        : _getChildByStr(Strings.passPageDescription));
  }

  Widget build(BuildContext context, AuthState state) {
    return Container(
        constraints:
            BoxConstraints(maxHeight: _getHeight(), maxWidth: _getWidth()),
        margin: EdgeInsets.all(20.0),
        child: _getChild(context, state));
  }
}

///
/// Builder for Input parts in Login Page
///
class LoginWidgetBuilder {
  static final _textKey = GlobalKey();

  Orientation orientation;
  Size size;
  static TextEditingController textController = TextEditingController();

  // build button in login page
  Widget _buildLoginButton(void Function(String input) onPress,
      BuildContext context, AuthState state) {
    return Center(
        key: UniqueKey(),
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
                child: Center(child: _getBtnText(context, state)),
              ),
            )));
  }

  // get button Child
  Widget _getBtnText(BuildContext context, AuthState state) {
    if (state is AuthStateStart) {
      return Text(Strings.next);
    } else {
      return Text(Strings.login);
    }
  }

  // build button based on AuthState
  Widget _buildLoginButtonByState(AuthState state, BuildContext context) {
    if (state is AuthStateStart) {
      return _buildLoginButton((input) {
        BlocProvider.of<AuthBLoC>(context).add(AuthEventAddUsername(input));
        textController.clear();
      }, context, state);
    } else if (state is AuthStateUsernameEntered) {
      return _buildLoginButton((input) {
        BlocProvider.of<AuthBLoC>(context).add(AuthEventAddPassword(input));
      }, context, state);
    } else {
      // todo other states
      return Center(
        key: UniqueKey(),
      );
    }
  }

  // get width of text field based on orientation
  double _getTextFieldWidth() =>
      orientation == Orientation.landscape ? size.width / 3 : size.width;

  // build input text field
  Widget _buildInputField(void Function(String input) btnPressed, isUsrLogin) {
    return Container(
        margin: EdgeInsets.all(20.0),
        width: _getTextFieldWidth(),
        child: TextField(
          key: _textKey,
          controller: textController,
          onSubmitted: btnPressed,
          textInputAction: TextInputAction.next,
          obscureText: !isUsrLogin,
          decoration: InputDecoration(
              labelText: isUsrLogin ? Strings.username : Strings.password),
        ));
  }

  // build text field based on AuthState
  Widget _buildInputTextFieldByState(AuthState state, BuildContext context) {
    if (state is AuthStateStart) {
      return _buildInputField((input) {
        BlocProvider.of<AuthBLoC>(context).add(AuthEventAddUsername(input));
        textController.clear();
      }, true);
    } else if (state is AuthStateUsernameEntered) {
      return _buildInputField((input) {
        BlocProvider.of<AuthBLoC>(context).add(AuthEventAddPassword(input));
      }, false);
    } else {
      // todo other states
      return Center(
        key: UniqueKey(),
      );
    }
  }

  // button to return to username
  Widget _getReturnWidget(void Function() onPresssed) {
    return Center(
      key: UniqueKey(),
      child: FlatButton(
          onPressed: onPresssed,
          child: Text(
            Strings.returnToUsername,
          )),
    );
  }

  // build the return button based on state
  Widget _buildReturnWidgetByState(AuthState state, BuildContext context) {
    if (state is AuthStateUsernameEntered) {
      return _getReturnWidget(() {
        BlocProvider.of<AuthBLoC>(context).add(AuthEventReturnToUsername());
        textController.clear();
      });
    } else {
      // todo other states
      return Center(
        key: UniqueKey(),
      );
    }
  }

  Widget build(BuildContext context, AuthState state) {
    if (state is AuthStatePasswordEntered) {
      return CircularProgressIndicator();
    } else {
      return Expanded(
          child:
              SingleChildScrollView(child: getWidgetsByState(state, context)));
    }
  }

  // build widgets based on BLoC state
  Widget getWidgetsByState(AuthState state, BuildContext context) {
    return (Column(children: <Widget>[
      _buildInputTextFieldByState(state, context),
      AnimationBuilder.build(_buildLoginButtonByState(state, context)),
      AnimationBuilder.build(_buildReturnWidgetByState(state, context))
    ]));
  }
}

///
/// Create Animation for State change.
///
class AnimationBuilder {
  static Widget build(Widget child) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 500), child: child);
  }
}
