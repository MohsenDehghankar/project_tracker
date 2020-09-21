import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/model/auth_model.dart';
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

class AuthStateStart extends AuthState {}

class AuthStateUsernameEntered extends AuthState {}

class AuthStatePasswordEntered extends AuthState {}

class AuthStateEmptyInput extends AuthState {
  bool inUserPage;

  AuthStateEmptyInput(this.inUserPage);
}

///
/// Auth BLoC as Controller between UI & Logic
///
class AuthBLoC extends Bloc<AuthEvent, AuthState> {
  final AuthModel authModel = AuthModel();

  @override
  AuthState get initialState => AuthStateStart();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthEventAddPassword) {
      if (event.password.isEmpty){
        yield AuthStateEmptyInput(false);
      }else {
        authModel.setPass(event.password);
        debugPrint("user: ${authModel.getUser()} : ${authModel.getPass()}");
        // yield AuthStatePasswordEntered();
        // todo API call
        Navigator.pushReplacement(event.context, MaterialPageRoute(builder: (_) {
          return MainPage();
        }));
      }
    } else if (event is AuthEventAddUsername) {
      if (event.username.isEmpty){
        yield AuthStateEmptyInput(true);
      }else {
        authModel.setUser(event.username);
        yield AuthStateUsernameEntered();
      }
    } else if (event is AuthEventReturnToUsername) {
      authModel.setUser("");
      yield AuthStateStart();
    }
  }
}
