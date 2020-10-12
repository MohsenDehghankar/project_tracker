import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/model/auth/auth_model.dart';
import 'package:project_tracker/model/auth/auth_result.dart';
import 'package:project_tracker/repository/auth_repository.dart';
import 'package:project_tracker/ui/project/main_page.dart';

/// Auth BLoC events
abstract class AuthEvent {}

class AuthEventAddUsername extends AuthEvent {
  String username;

  AuthEventAddUsername(this.username);
}

class AuthEventAddPassword extends AuthEvent {
  String password;
  BuildContext context;

  AuthEventAddPassword(this.password, this.context);
}

class AuthEventReturnToUsername extends AuthEvent {}

class AuthEventError extends AuthEvent {}

class AuthEventSendLogin extends AuthEvent {}

/// Auth BLoC States
abstract class AuthState {}

class AuthStateStart extends AuthState {
  bool loginFailed;
  String error;

  AuthStateStart(this.loginFailed, this.error);
}

class AuthStateUsernameEntered extends AuthState {}

class AuthStatePasswordEntered extends AuthState {}

class AuthStateEmptyInput extends AuthState {
  bool inUserPage;

  AuthStateEmptyInput(this.inUserPage);
}

class AuthStateLoggedIn extends AuthState {}

/// BLoC pattern for login process in auth_page
class AuthBLoC extends Bloc<AuthEvent, AuthState> {
  final AuthModel authModel = AuthModel();
  final AuthRepository authRepository = AuthRepository();

  final GlobalKey<NavigatorState> navigatorKey;

  AuthBLoC(this.navigatorKey) : super(AuthStateStart(false, ""));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthEventAddPassword) {
      if (event.password.isEmpty) {
        yield AuthStateEmptyInput(false);
      } else {
        authModel.setPass(event.password);

        yield AuthStatePasswordEntered();

        AuthResult result = await authRepository.authenticate(authModel);
        if (result.status == AuthResultStatus.success) {
          navigatorKey.currentState
              .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
        } else {
          yield AuthStateStart(true, result.error);
        }
      }
    } else if (event is AuthEventAddUsername) {
      if (event.username.isEmpty) {
        yield AuthStateEmptyInput(true);
      } else {
        authModel.setUser(event.username);
        yield AuthStateUsernameEntered();
      }
    } else if (event is AuthEventReturnToUsername) {
      authModel.setUser("");
      yield AuthStateStart(false, "");
    }
  }
}
