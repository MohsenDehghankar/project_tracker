import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/logic/auth_model.dart';
import 'package:project_tracker/ui/auth/landscape_auth_widget.dart';
import 'package:project_tracker/ui/auth/portrait_auth_widget.dart';

///
/// Authentication Widget:
///   1. Input Fields
///   2. Description
///
class AuthStatefulWidget extends StatefulWidget {
  @override
  AuthState createState() => AuthState();
}

///
/// An abstract class building Auth State.
/// (Portrait & Landscape extend this class)
///
class AuthState extends State<AuthStatefulWidget> {
  // keeping auth state
  AuthModel authModel;
  bool isUsrPage;
  bool requestSent;

  // on Next button pressed
  void onNextPressed(String username) {
    setState(() {
      isUsrPage = false;
      authModel.setUser(username);
    });
  }

  // on Login btn pressed
  void onLoginPressed(String password) {
    // todo implement (API)
    setState(() {
      authModel.setPass(password);
      requestSent = true;
    });

    // todo to be removed
    debugPrint("Auth: ${authModel.getUser()}: ${authModel.getPass()}");
  }

  // return to username field
  void returnToUsername() {
    setState(() {
      isUsrPage = true;
    });
  }

  @override
  void initState() {
    super.initState();
    isUsrPage = true;
    requestSent = false;
    authModel = AuthModel();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: orientation == Orientation.portrait
            ? PortraitAuthBuilder(this)
                .build(onNextPressed, onLoginPressed, returnToUsername)
            : LandscapeAuthBuilder(this)
                .build(onNextPressed, onLoginPressed, returnToUsername));
  }
}

///
/// Create widget for AuthState.
///
abstract class AuthWidgetBuilder {
  AuthState authState;

  AuthWidgetBuilder(this.authState);

  // Description part
  Widget descriptionWidget;

  // Input field & button
  Widget loginWidget;

  Widget buildLoginWidget(void Function(String input) onNextPressed,
      void Function(String input) onLoginPressed, void Function() returnToUsername);

  // build description widget
  Widget buildDecsWidget();
}
