import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/project/project_progress_indicator.dart';

class ProjectCard {
  static Widget build(Color progressColor, Color timeColor, Size size) {
    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          "Project Name",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.linear_scale, color: Colors.yellowAccent),
                Text(" Until 99/08/30", style: TextStyle(color: Colors.white)),
                Text(" [24 day(s)]", style: TextStyle(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ProjectProgressIndicator.build(
                    progressColor, 50, Strings.progress, size.width),
                ProjectProgressIndicator.build(
                    timeColor, 20, Strings.timeRemained, size.width)
              ],
            ),
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));

    final makeCard = Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: ConstColors.cardColor),
        child: makeListTile,
      ),
    );
    return makeCard;
  }
}
