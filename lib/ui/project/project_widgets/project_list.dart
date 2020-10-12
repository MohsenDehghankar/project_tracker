import 'package:flutter/material.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/ui/project/project_widgets/project_card.dart';

/// builder for list of projects in projects page
class ProjectList {
  static Widget build(ThemeData theme, Size size, List<Project> projects) {
    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (BuildContext context, int index) {
          return ProjectCard.build(
              ConstColors.progressIndicator, ConstColors.timeRemainedIndicator, size, projects[index], context);
        },
      ),
    );

    return makeBody;
  }
}
