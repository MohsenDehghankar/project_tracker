import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/model/project/project_detail_result.dart';
import 'package:project_tracker/repository/project_repository.dart';

///
/// Events for Project Detail Page's BLoC
///
abstract class DetailEvent {}

class DetailEventLoadData extends DetailEvent {}

class DetailEventReloadData extends DetailEvent {}

///
/// States for Project Detail Page's BLoC
///
abstract class DetailState {}

class DetailStateLoading extends DetailState {}

class DetailStateError extends DetailState {
  String error;
}

class DetailStateDataLoaded extends DetailState {
  Project project;
}


///
/// BLoC for project detail page
///
class ProjectDetailBloc extends Bloc<DetailEvent, DetailState> {
  Project project;
  ProjectRepository repository = ProjectRepository();


  ProjectDetailBloc():super(DetailStateLoading());

 /* @override
  DetailState get initialState => DetailStateLoading();*/

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is DetailEventLoadData) {
      ProjectDetailResult result = await repository.fetchProjectDetails("");

      if (result.success) {
        yield DetailStateDataLoaded()..project = result.project;
      } else {
        yield DetailStateError()..error = result.error;
      }
    } else if (event is DetailEventReloadData) {
      yield DetailStateLoading();
    }
  }
}
