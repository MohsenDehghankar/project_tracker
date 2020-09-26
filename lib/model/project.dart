import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

///
/// Indicating a Project
///
class Project {
  String name;
  String detail;
  String clientId;
  String projectManager;
  String deadline;

  Project(this.name, this.detail, this.clientId, this.projectManager,
      this.deadline);

  Project.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        detail = json['detail'],
        clientId = json['clientId'],
        projectManager = json['projectManager'],
        deadline = json['deadline'];

  String getDate(){
    var time = DateTime.parse(deadline);
    return DateFormat("yyyy-MM-dd").format(time);
  }

  int getRemainingDays(){
    var time = DateTime.parse(deadline);
    var now = DateTime.now();
    return time.difference(now).inDays;
  }
}
