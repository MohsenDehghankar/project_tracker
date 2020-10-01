import 'package:project_tracker/model/project/requirement.dart';

class Phase {
  String name;
  String desc;
  String deadline;
  List<Requirement> requirements;

  Phase.buildBrief(dynamic json)
      : name = json['name'],
        deadline = json['deadline'];

  Phase.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        deadline = json['deadline'],
        desc = json['description'] {
    var requirements = json['requirements'];
    this.requirements = List<Requirement>();
    for (var req in requirements) {
      this.requirements.add(Requirement.fromJson(req));
    }
    _sortRequirements();
  }

  void _sortRequirements(){
    this.requirements.sort((a, b) => b.priority.compareTo(a.priority));
  }
}
