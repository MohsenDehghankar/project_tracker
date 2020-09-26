import 'package:intl/intl.dart';
import 'package:project_tracker/model/project/project_phase.dart';

///
/// Indicating a Project
///
class Project {
  String name;
  String detail;
  String clientId;
  String projectManager;
  String deadline;
  List<Phase> phases;

  Project(this.name, this.detail, this.clientId, this.projectManager,
      this.deadline);

  Project.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        detail = json['detail'],
        clientId = json['clientId'],
        projectManager = json['projectManager'],
        deadline = json['deadline'];

  set setPhases(List<Phase> phases) {
    this.phases = phases;
  }

  String getNearestDate() {
    // todo (API)
    var time = DateTime.parse(deadline);
    return DateFormat("yyyy-MM-dd").format(time);
  }

  int getRemainingDays() {
    // todo (API)
    var time = DateTime.parse(deadline);
    var now = DateTime.now();
    return time.difference(now).inDays;
  }
}
