///
/// Phase Requirements
///
class Requirement {
  String title;
  String description;
  int priority;

  Requirement.fromJson(dynamic json)
      : title = json['title'],
        description = json['description'],
        priority = json['priority'];

  Requirement(this.title, this.description, this.priority);
}
