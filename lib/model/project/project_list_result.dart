import 'package:project_tracker/model/project/project.dart';

/// projects lists for a user, fetched in projects repository.
class ProjectListResult {
  List<Project> projects;
  String error;
  bool success;

  ProjectListResult(this.success);

  ProjectListResult.fromJson(List<dynamic> json) {
    projects = List<Project>();

    try {
      for (var obj in json) {
        Project project = Project.fromJson(obj, false);
        if (DateTime.parse(project.deadline).isAfter(DateTime.now())) {
          projects.add(project);
        }
      }
    } on Exception {
      this.error = "Error in creating projects from Json";
      this.success = false;
      return;
    }

    // debugging
    /*projects.add(Project("1", "Detail", "client 1", "man", "2020-10-24T11:21:25.825Z"));
    projects.add(Project("2", "Detail", "client 2", "man", "2020-10-26T11:21:25.825Z"));
    projects.add(Project("3", "Detail", "client 3", "man", "2020-12-25T11:21:25.825Z"));
    projects.add(Project("4", "Detail", "client 4", "man", "2020-12-10T11:21:25.825Z"));
    projects.add(Project("5", "Detail", "client 5", "man", "2020-11-24T11:21:25.825Z"));*/

    sortProjects();
    error = "";
    success = true;
  }

  // sort projects based on their nearest phase deadline
  void sortProjects() {
    projects.sort((a, b) => a.nearest.compareTo(b.nearest));
  }
}
