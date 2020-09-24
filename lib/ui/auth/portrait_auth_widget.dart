import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';
import 'package:project_tracker/ui/auth/auth_widget_utils.dart';
import 'package:project_tracker/ui/project/project_page.dart';

///
/// Auth Widget Builder for Portrait displays
///
class PortraitAuthBuilder extends AuthWidgetBuilder {
  // build description widget
  @override
  Widget buildDecsWidget(BuildContext context, AuthState state) {
    var builder = DescWidgetBuilder()
      ..orientation = Orientation.portrait
      ..size = MediaQuery.of(authState.context).size;

    return builder.build(context, state);
  }

  // build login widget
  @override
  Widget buildLoginWidget(BuildContext context, AuthState state) {
    var builder = LoginWidgetBuilder()
      ..size = MediaQuery.of(authState.context).size
      ..orientation = Orientation.portrait;

    return builder.build(context, state);
  }

  BoxConstraints _getConstraints() {
    return BoxConstraints(
        maxWidth: MediaQuery.of(authState.context).size.width,
        minHeight: MediaQuery.of(authState.context).size.height -
            AppBar().preferredSize.height * 2);
  }

  Widget build() {
    return BlocBuilder<AuthBLoC, AuthState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            buildDecsWidget(context, state),
            // test,
            buildLoginWidget(context, state)
          ],
        );
      },
    );
  }

  PortraitAuthBuilder(AuthWidgetState state) : super(state);
}
