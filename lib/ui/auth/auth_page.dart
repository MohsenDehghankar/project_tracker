import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/main.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/ui/auth/widgets/auth_widget_utils.dart';
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
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    Widget body = orientation == Orientation.portrait
        ? PortraitAuthBuilder(this).build()
        : LandscapeAuthBuilder(this).build();

    body = Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [ConstColors.gradientStart, ConstColors.gradientEnd]),
        ),
        child: body);

    return BlocProvider(
        create: (context) => AuthBLoC(MyApp.navigatorKey),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(accentColor: ConstColors.accentColor),
          home: Scaffold(
              // resizeToAvoidBottomInset: false,
              // body: body,
              body: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(child: body),
              ),
              floatingActionButton: BlocBuilder<AuthBLoC, AuthState>(
                builder: (context, state) {
                  var builder = LoginWidgetBuilder()
                    ..size = MediaQuery.of(context).size
                    ..orientation = MediaQuery.of(context).orientation;
                  return builder.buildLoginButtonByState(state, context);
                },
              )),
        ));
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

  Widget buildLoginWidget(BuildContext context, AuthState state);

  // build description widget
  Widget buildDecsWidget(BuildContext context, AuthState state);
}
