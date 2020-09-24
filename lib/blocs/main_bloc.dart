import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/model/auth_model.dart';
import 'package:project_tracker/repository/project_repository.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';

///
/// Main Page Events as Input to Main Page BLoC
///
abstract class MainEvent {}

class MainEventLogout extends MainEvent {}

///
/// Main Page State as output of Main Page BLoC
///
abstract class MainState {}

class MainStateLoading extends MainState {}

class MainStateLogout extends MainState {}

///
/// Main Page BLoC as Controller between UI & Logic
///
class MainBloc extends Bloc<MainEvent, MainState> {
  final projectRepository = ProjectRepository();
  final GlobalKey<NavigatorState> navigatorKey;

  MainBloc(this.navigatorKey);

  @override
  MainState get initialState => MainStateLoading();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainEventLogout) {
      projectRepository.clearToken();
      navigatorKey.currentState
          .pushReplacement(MaterialPageRoute(builder: (_) => AuthPage()));
    }
  }
}
