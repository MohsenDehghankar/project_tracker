import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/button.dart';
import 'package:project_tracker/ui/auth/textInput.dart';

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
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
      child: Container(
        //color: Colors.green,
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
            ),
            Center(
              child: Text(
                desc,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // get child based on BLoC state
  Widget _getChild(BuildContext context, AuthState state) {
    if (state is AuthStatePasswordEntered) {
      return AnimationBuilder.build(_getChildByStr(Strings.authing));
    } else {
      return AnimationBuilder.build((state is AuthStateStart ||
              (state is AuthStateEmptyInput && state.inUserPage))
          ? _getChildByStr(Strings.userPageDescription)
          : _getChildByStr(Strings.passPageDescription));
    }
  }

  Widget build(BuildContext context, AuthState state) {
    return orientation == Orientation.landscape
        ? Container(
            width: _getWidth(),
            child: _getChild(context, state),
          )
        : _getChild(context, state);
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
      BuildContext context, AuthState state, bool error) {
    Button button = Button(size, error, textController);
    return button.build(onPress,
        state is AuthStateStart ? Strings.next : Strings.login, orientation);
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
      }, context, state, state is AuthStateEmptyInput);
    } else if (state is AuthStateUsernameEntered) {
      return _buildLoginButton((input) {
        BlocProvider.of<AuthBLoC>(context)
            .add(AuthEventAddPassword(input, context));
      }, context, state, state is AuthStateEmptyInput);
    } else if (state is AuthStateEmptyInput) {
      if (state.inUserPage) {
        return _buildLoginButtonByState(AuthStateStart(false, ""), context);
      } else {
        return _buildLoginButtonByState(AuthStateUsernameEntered(), context);
      }
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
  Widget _buildInputField(
      void Function(String input) btnPressed, isUsrLogin, bool error) {
    TextInput textInput =
        TextInput(size, _textKey, textController, isUsrLogin, error);
    return textInput.build(btnPressed);
  }

  // build text field based on AuthState
  Widget _buildInputTextFieldByState(
      AuthState state, BuildContext context, bool error) {
    if (state is AuthStateStart) {
      return _buildInputField((input) {
        BlocProvider.of<AuthBLoC>(context).add(AuthEventAddUsername(input));
        textController.clear();
      }, true, error);
    } else if (state is AuthStateUsernameEntered) {
      return _buildInputField((input) {
        BlocProvider.of<AuthBLoC>(context)
            .add(AuthEventAddPassword(input, context));
      }, false, error);
    } else if (state is AuthStateEmptyInput) {
      if (state.inUserPage) {
        return _buildInputTextFieldByState(AuthStateStart(false, ""), context, true);
      } else {
        return _buildInputTextFieldByState(
            AuthStateUsernameEntered(), context, true);
      }
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
    if (state is AuthStateUsernameEntered ||
        (state is AuthStateEmptyInput && !state.inUserPage)) {
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
    if (state is AuthStatePasswordEntered)
      return Expanded(
          child: Center(
              child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).buttonColor,
      )));
    else
      return Expanded(child: getWidgetsByState(state, context));
  }

  // build widgets based on BLoC state
  Widget getWidgetsByState(AuthState state, BuildContext context) {
    return (Column(children: <Widget>[
      _buildInputTextFieldByState(state, context, state is AuthStateEmptyInput),
      AnimationBuilder.build(_buildLoginButtonByState(state, context)),
      AnimationBuilder.build(_buildReturnWidgetByState(state, context)),
    ]));
  }
}

///
/// Create Animation for State change.
///
class AnimationBuilder {
  static Widget build(Widget child) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 700), child: child);
  }
}

///
/// build login failed snackbar
///
class SnackBarFailedBuilder {
  static Widget build(String text) {
    return SnackBar(
        content: Text(
      text,
    ));
  }
}
