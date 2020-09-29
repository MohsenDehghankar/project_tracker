import 'dart:convert';

import 'package:flutter/widgets.dart';
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
  String projectId;
  String deadline;
  String startDate;

  // brief detail of phases (deadline, name)
  List<Phase> phases;

  // Nearest deadline
  DateTime nearest;
  String nearestPhaseName;

  Project(this.name, this.detail, this.clientId, this.projectManager,
      this.deadline, this.projectId, this.startDate);

  Project.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        detail = json['detail'],
        clientId = json['clientId'],
        projectManager = json['projectManager'],
        deadline = json['deadline'],
        projectId = json['projectId'],
        startDate = json['startDate'] {
    var phases = json['phases'];
    this.phases = List<Phase>();
    for (var phs in phases) {
      this.phases.add(Phase.buildBrief(phs));
    }
    getNearestDate();
  }

  set setPhases(List<Phase> phases) {
    this.phases = phases;
  }

  void getNearestDate() {
    var now = DateTime.now();
    var near = DateTime.parse(deadline);
    var name = "deadline";
    for (var phs in phases) {
      var time = DateTime.parse(phs.deadline);
      if (time.isAfter(now) && time.isBefore(near)) {
        near = time;
        name = phs.name;
      }
    }
    this.nearest = near;
    this.nearestPhaseName = name;
  }

  int getRemainingDays() {
    var now = DateTime.now();
    return nearest.difference(now).inDays;
  }

  int getProgressPercent() {
    // todo based on done phases
    var now = DateTime.now();
    int n = 0;
    for (var phs in phases) {
      if (now.isAfter(DateTime.parse(phs.deadline))) n++;
    }
    return (n * 100) ~/ phases.length;
  }

  int getRemainedTimePercent() {
    int diff =
        DateTime.parse(deadline).difference(DateTime.parse(startDate)).inDays;
    int now = DateTime.now().difference(DateTime.parse(startDate)).inDays;
    return (now * 100) ~/ diff;
  }
}
