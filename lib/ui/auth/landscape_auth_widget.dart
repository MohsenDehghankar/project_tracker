import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';
import 'package:project_tracker/ui/auth/auth_widget_utils.dart';

///
/// Auth Widget Builder for Landscape displays
/// Or in displays which (width > height)
///
class LandscapeAuthBuilder extends AuthWidgetBuilder {
  @override
  Widget buildLoginWidget(BuildContext context, AuthState state) {
    var builder = LoginWidgetBuilder()
      ..size = MediaQuery.of(authState.context).size
      ..orientation = Orientation.landscape;
    return builder.build(context, state);
  }

  @override
  Widget buildDecsWidget(BuildContext context, AuthState state) {
    var builder = DescWidgetBuilder()
      ..orientation = Orientation.landscape
      ..size = MediaQuery.of(authState.context).size;

    return builder.build(context, state);
  }

  Widget build() {
    return BlocBuilder<AuthBLoC, AuthState>(
      builder: (context, state) {
        if (state is AuthStateStart && state.loginFailed) {
          Scaffold.of(context)
              .showSnackBar(SnackBarFailedBuilder.build(state.error));
        }
        return Row(
          children: <Widget>[
            buildDecsWidget(context, state),
            buildLoginWidget(context, state)
          ],
        );
      },
    );
  }

  LandscapeAuthBuilder(AuthWidgetState state) : super(state);
}
