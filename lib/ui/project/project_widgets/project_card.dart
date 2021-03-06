import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/style/fonts.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/project_detail/project_details_page.dart';
import 'package:project_tracker/ui/project/project_widgets/project_progress_indicator.dart';
import 'package:shamsi_date/shamsi_date.dart';

/// a project card in projects page
class ProjectCard {
  static Widget build(Color progressColor, Color timeColor, Size size,
      Project project, BuildContext context) {
    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.delete_outline, color: ConstColors.projectCardTxtColor),
        ),
        title: Text(
          project.name,
          style: GoogleFonts.getFont(Fonts.mainFont,
              color: ConstColors.projectCardTxtColor, fontWeight: FontWeight.bold),
        ),

        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.timeline,
                  color: ConstColors.projectCardTimeIconColor,
                  size: 15.0,
                ),
                Text(" Until ${project.nearestPhaseName}",
                    style: GoogleFonts.getFont(Fonts.mainFont,
                        color: ConstColors.projectCardTxtColor, fontSize: 12.0)),
              ],
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    " ${project.getNearestJalali()}",
                    style: GoogleFonts.getFont(Fonts.mainFont,
                        color: ConstColors.projectCardTxtColor, fontSize: 12.0)),
                Text(" [${project.getRemainingDays()} day(s)]",
                    style: GoogleFonts.getFont(Fonts.mainFont,
                        color: ConstColors.projectCardTxtColor)),
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ProjectProgressIndicator.build(progressColor,
                    project.getProgressPercent(), Strings.progress, size.width),
                ProjectProgressIndicator.build(
                    timeColor,
                    project.getRemainedTimePercent(),
                    Strings.timeRemained,
                    size.width)
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon:
              Icon(Icons.keyboard_arrow_right, color: ConstColors.projectCardTxtColor, size: 30.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(project.projectId)));
          },
        ));

    final makeCard = Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: ConstColors.projectCardBackground),
        child: makeListTile,
      ),
    );
    return makeCard;
  }
}
