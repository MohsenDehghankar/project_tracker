import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';
import 'package:project_tracker/ui/auth/auth_widget_utils.dart';

///
/// Auth Widget Builder for Landscape displays
/// Or in displays which (width > height)
///
class LandscapeAuthBuilder extends AuthWidgetBuilder {
  @override
  Widget buildLoginWidget() {
    var builder = LoginWidgetBuilder()
      ..size = MediaQuery.of(authState.context).size
      ..orientation = Orientation.landscape;
    return builder.build();
  }

  @override
  Widget buildDecsWidget() {
    var builder = DescWidgetBuilder()
      ..orientation = Orientation.landscape
      ..size = MediaQuery.of(authState.context).size;

    return builder.build();
  }

  Widget build() {
    return Row(
      key: UniqueKey(),
      children: <Widget>[
        buildDecsWidget(),
        BlocBuilder<AuthBLoC, AuthState>(builder: (context, state) {
          if (state is AuthStatePasswordEntered) {
            return CircularProgressIndicator();
          } else {
            return buildLoginWidget();
          }
        })
      ],
    );
  }

  LandscapeAuthBuilder(AuthWidgetState state) : super(state);
}
