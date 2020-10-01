import 'package:project_tracker/model/project/project_phase.dart';

///
/// A Project
///
class Project {
  String name;
  String detail;
  String clientId;
  String projectManager;
  String projectId;
  String deadline;
  String startDate;

  List<Phase> phases;

  // Nearest deadline
  DateTime nearest;
  String nearestPhaseName;

  Project(this.name, this.detail, this.clientId, this.projectManager,
      this.deadline, this.projectId, this.startDate);

  Project.fromJson(Map<String, dynamic> json, bool detail)
      : name = json['name'],
        detail = json['detail'],
        clientId = json['clientId'],
        projectManager = json['projectManager'],
        deadline = json['deadline'],
        projectId = json['projectId'],
        startDate = json['startDate'] {
    var phases = json['phases'];
    this.phases = List<Phase>();
    if (detail) {
      for (var phs in phases) {
        this.phases.add(Phase.fromJson(phs));
      }
    } else {
      for (var phs in phases) {
        this.phases.add(Phase.buildBrief(phs));
      }
    }
    getNearestDate();
    _sortPhases();
  }

  // sort phases based on deadline
  void _sortPhases() {
    this.phases.sort((a, b) => DateTime.parse(a.deadline)
        .difference(DateTime.parse(b.deadline))
        .inDays);
  }

  set setPhases(List<Phase> phases) {
    this.phases = phases;
  }

  // get phase with nearest deadline
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

  // get number of days remained till the project deadline
  int getRemainingDays() {
    var now = DateTime.now();
    return nearest.difference(now).inDays;
  }

  // get percent of project progress, based on done phases
  int getProgressPercent() {
    // todo based on done phases
    var now = DateTime.now();
    int n = 0;
    for (var phs in phases) {
      if (now.isAfter(DateTime.parse(phs.deadline))) n++;
    }
    return (n * 100) ~/ phases.length;
  }

  // get percent of remaining time
  int getRemainedTimePercent() {
    int diff =
        DateTime.parse(deadline).difference(DateTime.parse(startDate)).inDays;
    int now = DateTime.now().difference(DateTime.parse(startDate)).inDays;
    return (now * 100) ~/ diff;
  }

  // get deadline list of phases as String
  List<String> getPhaseDeadlineList(){
    List<String> result = List<String>();
    for (var phs in phases){
      result.add(phs.deadline);
    }
    return result;
  }

  // project dynamic key values
  Map<String, String> getKeyValues(){
    // todo
    Map<String, String> result = Map();
    result['name'] = name;
    result['description'] = detail;
    result['client'] = clientId;
    result['Project Manager'] = projectManager;
    result['Project Manager 2'] = projectManager;
    result['Project Manager 3'] = projectManager;
    result['Project Manager 4'] = projectManager;
    result['Project Manager 5'] = projectManager;
    return result;
  }
}
