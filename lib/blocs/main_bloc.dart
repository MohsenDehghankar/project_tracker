import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/model/project.dart';
import 'package:project_tracker/model/project_list_result.dart';
import 'package:project_tracker/model/user.dart';
import 'package:project_tracker/model/user_result.dart';
import 'package:project_tracker/repository/project_repository.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';

///
/// Main Page Events as Input to Main Page BLoC
///
abstract class MainEvent {}

class MainEventLogout extends MainEvent {}

class MainEventLoadData extends MainEvent {}

class MainEventRefresh extends MainEvent {}

///
/// Main Page State as output of Main Page BLoC
///
abstract class MainState {}

class MainStateLoading extends MainState {}

class MainStateLogout extends MainState {}

class MainStateLoaded extends MainState {}

class MainStateErrorLoading extends MainState {
  String error;

  MainStateErrorLoading(this.error);
}

///
/// Main Page BLoC as Controller between UI & Logic
///
class MainBloc extends Bloc<MainEvent, MainState> {
  final projectRepository = ProjectRepository();
  final GlobalKey<NavigatorState> navigatorKey;

  User user;
  List<Project> projects;
  String error;

  MainBloc(this.navigatorKey);

  @override
  MainState get initialState => MainStateLoading();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainEventLogout) {
      projectRepository.clearToken();
      navigatorKey.currentState
          .pushReplacement(MaterialPageRoute(builder: (_) => AuthPage()));
    } else if (event is MainEventLoadData) {
      UserResult result = await projectRepository.fetchUserData();
      ProjectListResult projectListResult =
          await projectRepository.fetchProjects();

      if (result.success && projectListResult.success) {
        this.user = result.user;
        this.projects = projectListResult.projects;

        projects[0].getDate();

        yield MainStateLoaded();
      } else {
        yield MainStateErrorLoading(
            result.success ? projectListResult.error : result.error);
      }
    } else if (event is MainEventRefresh) {
      yield MainStateLoading();
    }
  }
}
