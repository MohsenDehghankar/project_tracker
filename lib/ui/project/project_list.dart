import 'package:flutter/material.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/ui/project/project_card.dart';

class ProjectList {
  static Widget build(ThemeData theme, Size size, List<Project> projects) {
    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (BuildContext context, int index) {
          return ProjectCard.build(
              theme.accentColor, Colors.black, size, projects[index]);
        },
      ),
    );

    return makeBody;
  }
}
