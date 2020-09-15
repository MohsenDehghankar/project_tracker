import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/ui/auth/landscape_auth_state.dart';
import 'package:project_tracker/ui/auth/portrait_auth_state.dart';

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
  String username;
  String password;
  bool isUsrPage;


  // on Next button pressed
  void onNextPressed() {
    setState(() {
      isUsrPage = false;
    });
  }

  // on Login btn pressed
  void onLoginPressed() {
    // todo implement (API)
  }

  @override
  void initState() {
    super.initState();
    isUsrPage = true;
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? PortraitAuthBuilder(this).build(onNextPressed, onLoginPressed)
        : LandscapeAuthBuilder(this)
            .build(onNextPressed, onLoginPressed);
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

  Widget buildLoginWidget(
      void Function() onNextPressed, void Function() onLoginPressed);

  // build description widget
  Widget buildDecsWidget();
}
