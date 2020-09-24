import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/model/auth_model.dart';
import 'package:project_tracker/model/auth_result.dart';
import 'package:project_tracker/repository/auth_repository.dart';
import 'package:project_tracker/ui/project/main_page.dart';
import 'package:project_tracker/ui/project/project_page.dart';

///
/// Auth Event as input for Auth BLoC
///
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

///
/// Auth State as output of Auth BLoC
///
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

///
/// Auth BLoC as Controller between UI & Logic
///
class AuthBLoC extends Bloc<AuthEvent, AuthState> {
  final AuthModel authModel = AuthModel();
  final AuthRepository authRepository = AuthRepository();

  final GlobalKey<NavigatorState> navigatorKey;

  AuthBLoC(this.navigatorKey);

  @override
  AuthState get initialState => AuthStateStart(false, "");

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthEventAddPassword) {
      if (event.password.isEmpty) {
        yield AuthStateEmptyInput(false);
      } else {
        authModel.setPass(event.password);

        // debug
        debugPrint(
            "authenticate: ${authModel.getUser()} : ${authModel.getPass()}");
        yield AuthStatePasswordEntered();

        // call API
        AuthResult result = await authRepository.authenticate(authModel);
        if (result.status == AuthResultStatus.success) {
          yield AuthStateLoggedIn();

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
