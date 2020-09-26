import 'package:project_tracker/model/project/project.dart';

class ProjectListResult {
  List<Project> projects;
  String error;
  bool success;

  ProjectListResult(this.success);

  ProjectListResult.fromJson(List<dynamic> json) {
    projects = List<Project>();

    /*for (var obj in json) {
      projects.add(Project.fromJson(obj));
    }*/

    // debug
    projects.add(Project("1", "Detail", "client 1", "man", "2020-10-24T11:21:25.825Z"));
    projects.add(Project("2", "Detail", "client 2", "man", "2020-10-26T11:21:25.825Z"));
    projects.add(Project("3", "Detail", "client 3", "man", "2020-12-25T11:21:25.825Z"));
    projects.add(Project("4", "Detail", "client 4", "man", "2020-12-10T11:21:25.825Z"));
    projects.add(Project("5", "Detail", "client 5", "man", "2020-11-24T11:21:25.825Z"));

    sortProjects();
    error = "";
    success = true;
  }

  void sortProjects() {
    projects.sort((a, b) => a.getNearestDate().compareTo(b.getNearestDate()));
  }
}
