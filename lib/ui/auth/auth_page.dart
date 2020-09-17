import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/logic/auth_model.dart';
import 'package:project_tracker/ui/appbar.dart';
import 'package:project_tracker/ui/auth/landscape_auth_widget.dart';
import 'package:project_tracker/ui/auth/portrait_auth_widget.dart';

///
/// Authentication Widget:
///   1. Input Fields
///   2. Description
///
class AuthPage extends StatefulWidget {
  @override
  AuthWidgetState createState() => AuthWidgetState();
}

///
/// An abstract class building Auth State.
/// (Portrait & Landscape extend this class)
///
class AuthWidgetState extends State<AuthPage> {
  bool isUsrPage;
  bool requestSent;

  // on Next button pressed
  /*void onNextPressed(String username) {
    setState(() {
      isUsrPage = false;
      authModel.setUser(username);
    });
  }*/

  // on Login btn pressed
  /*void onLoginPressed(String password) {
    // todo implement (API)
    setState(() {
      authModel.setPass(password);
      requestSent = true;
    });

    // todo to be removed
    debugPrint("Auth: ${authModel.getUser()}: ${authModel.getPass()}");
  }*/

  // return to username field
  /*void returnToUsername() {
    setState(() {
      isUsrPage = true;
    });
  }*/

  @override
  void initState() {
    super.initState();
    isUsrPage = true;
    requestSent = false;
    //authModel = AuthModel();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    Widget body = AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: orientation == Orientation.portrait
            ? PortraitAuthBuilder(this)
                .build()
            : LandscapeAuthBuilder(this)
                .build());
    return BlocProvider(
      create: (context) => AuthBLoC(),
      child: Scaffold(
        appBar: AppBarBuilder.build(),
        body: body,
      ),
    );
  }
}

///
/// Create widget for AuthState.
///
abstract class AuthWidgetBuilder {
  AuthWidgetState authState;

  AuthWidgetBuilder(this.authState);

  // Description part
  Widget descriptionWidget;

  // Input field & button
  Widget loginWidget;

  Widget buildLoginWidget();

  // build description widget
  Widget buildDecsWidget();
}
