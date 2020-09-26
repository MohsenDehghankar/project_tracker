import 'package:project_tracker/model/project.dart';

class ProjectListResult {
  List<Project> projects;
  String error;
  bool success;


  ProjectListResult(this.success);

  ProjectListResult.fromJson(List<dynamic> json){
    projects = List<Project>();
    for (var obj in json){
      projects.add(Project.fromJson(obj));
    }
    error = "";
    success = true;
  }
}