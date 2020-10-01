import 'package:flutter/material.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/model/project/time_line_data.dart';
import 'package:project_tracker/ui/detail/charts_widget.dart';
import 'package:project_tracker/ui/detail/key_value_widget.dart';
import 'package:project_tracker/ui/detail/phases.dart';
import 'package:project_tracker/ui/detail/timeline_builder.dart';


/// main body for detail page
class DetailPageBody {
  static Widget build(Project project) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        _getTimeline(project),
        SizedBox(
          height: 10.0,
        ),
        _getChart(project),
        SizedBox(
          height: 10.0,
        ),
        KeyPairBuilder.build(project.getKeyValues()),
        SizedBox(
          height: 10.0,
        ),
        PhasesWidget.build(project),
        SizedBox(
          height: 100.0,
        ),
      ],
    ));
  }

  static Widget _getTimeline(Project project) {
    return ProjectTimeLine(
        TimeLineData(project.startDate, project.deadline, project.phases));
  }

  static Widget _getChart(Project project) {
    // todo implement using API data
    return ChartsWidgetBuilder.build(DateTime.parse("2020-08-28T11:21:25.825Z"),
        DateTime.parse("2020-09-28T11:21:25.825Z"));
  }
}
