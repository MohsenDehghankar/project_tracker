import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';
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
      ..size = MediaQuery.of(authState.context).size;

    return builder.build();
  }

  // build login widget
  @override
  Widget buildLoginWidget() {
    var builder = LoginWidgetBuilder()
      ..size = MediaQuery.of(authState.context).size
      ..orientation = Orientation.portrait;

    return builder.build();
  }

  BoxConstraints _getConstraints() {
    return BoxConstraints(
        maxWidth: MediaQuery.of(authState.context).size.width,
        minHeight: MediaQuery.of(authState.context).size.height -
            AppBar().preferredSize.height * 2);
  }

  Widget build() {
    return SingleChildScrollView(
      key: UniqueKey(),
      child: ConstrainedBox(
        constraints: _getConstraints(),
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              buildDecsWidget(),
              BlocBuilder<AuthBLoC, AuthState>(builder: (context, state) {
                if (state is AuthStatePasswordEntered) {
                  return CircularProgressIndicator();
                } else {
                  return buildLoginWidget();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  PortraitAuthBuilder(AuthWidgetState state) : super(state);
}
