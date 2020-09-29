class Phase {
  String name;
  String desc;
  String deadline;
  List<Requirement> requirements;

  Phase.buildBrief(dynamic json)
      : name = json['name'],
        deadline = json['deadline'];
}

class Requirement {
  String title;
  String decs;
  int priority;
}
