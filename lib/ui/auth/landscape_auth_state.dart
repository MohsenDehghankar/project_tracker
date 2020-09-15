import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/appbar.dart';
import 'package:project_tracker/ui/auth/auth_widget.dart';
import 'package:project_tracker/ui/auth/auth_widget_utils.dart';

///
/// Auth Widget Builder for Landscape displays
/// Or in displays which (width > height)
///
class LandscapeAuthBuilder extends AuthWidgetBuilder {
  @override
  Widget buildLoginWidget(
      void Function() onNextPressed, void Function() onLoginPressed) {
    var builder = LoginWidgetBuilder()
      ..size = MediaQuery.of(authState.context).size
      ..orientation = Orientation.landscape
      ..isUsrLogin = authState.isUsrPage;

    return builder
        .build(this.authState.isUsrPage ? onNextPressed : onLoginPressed);
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

  Widget build(void Function() onNextPressed, void Function() onLoginPressed) {
    return Row(
      children: <Widget>[
        buildDecsWidget(),
        buildLoginWidget(onNextPressed, onLoginPressed)
      ],
    );
  }

  LandscapeAuthBuilder(AuthState state) : super(state);
}
