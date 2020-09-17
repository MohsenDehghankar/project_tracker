import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/logic/auth_model.dart';

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

  AuthEventAddPassword(this.password);
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
        yield AuthStatePasswordEntered();
        // todo API call
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
