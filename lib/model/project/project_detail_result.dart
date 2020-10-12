import 'package:project_tracker/model/project/project.dart';

/// project details fetched in projects repository
class ProjectDetailResult {
  Project project;
  bool success;
  String error;
}