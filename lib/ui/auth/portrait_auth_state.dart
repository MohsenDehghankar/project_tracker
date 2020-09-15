import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/auth_widget.dart';
import 'package:project_tracker/ui/auth/auth_widget_utils.dart';

///
/// Auth Widget Builder for Portrait displays
///
class PortraitAuthBuilder extends AuthWidgetBuilder {
  // build description widget
  @override
  Widget buildDecsWidget() {
    var builder = DescWidgetBuilder()
      ..orientation = Orientation.portrait
      ..size = MediaQuery.of(authState.context).size
      ..desc = authState.isUsrPage
          ? Strings.userPageDescription
          : Strings.passPageDescription;

    return builder.build();
  }

  // build login widget
  @override
  Widget buildLoginWidget(
      void Function() onNextPressed, void Function() onLoginPressed) {
    var builder = LoginWidgetBuilder()
      ..orientation = Orientation.portrait
      ..isUsrLogin = authState.isUsrPage;

    return builder
        .build(this.authState.isUsrPage ? onNextPressed : onLoginPressed);
  }

  Widget build(void Function() onNextPressed, void Function() onLoginPressed) {
    return Column(
      children: <Widget>[
        buildDecsWidget(),
        buildLoginWidget(onNextPressed, onLoginPressed)
      ],
    );
  }

  PortraitAuthBuilder(AuthState state) : super(state);
}
