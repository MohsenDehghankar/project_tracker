import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';
import 'package:project_tracker/ui/auth/auth_widget_utils.dart';

///
/// Auth Widget Builder for Landscape displays
/// Or in displays which (width > height)
///
class LandscapeAuthBuilder extends AuthWidgetBuilder {
  @override
  Widget buildLoginWidget(
      void Function(String input) onNextPressed,
      void Function(String input) onLoginPressed,
      void Function() returnToUsername) {
    var builder = LoginWidgetBuilder()
      ..size = MediaQuery.of(authState.context).size
      ..orientation = Orientation.landscape
      ..isUsrLogin = authState.isUsrPage;

    return builder.build(
        this.authState.isUsrPage ? onNextPressed : onLoginPressed,
        returnToUsername);
  }

  @override
  Widget buildDecsWidget() {
    var builder = DescWidgetBuilder()
      ..orientation = Orientation.landscape
      ..size = MediaQuery.of(authState.context).size
      ..desc = authState.isUsrPage
          ? Strings.userPageDescription
          : Strings.passPageDescription;

    return builder.build();
  }

  Widget build(
      void Function(String input) onNextPressed,
      void Function(String input) onLoginPressed,
      void Function() returnToUsername) {
    return Row(
      key: UniqueKey(),
      children: <Widget>[
        buildDecsWidget(),
        authState.requestSent
            ? CircularProgressIndicator()
            : buildLoginWidget(onNextPressed, onLoginPressed, returnToUsername),
      ],
    );
  }

  LandscapeAuthBuilder(AuthState state) : super(state);
}
