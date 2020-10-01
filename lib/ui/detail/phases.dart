import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/model/project/project_phase.dart';
import 'package:project_tracker/model/project/requirement.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/detail/card.dart';
import 'package:project_tracker/ui/detail/key_value_widget.dart';


/// phases widget builder for detail page
class PhasesWidget {
  static Widget build(Project project) {
    return DetailPageCardBuilder.build(
        getPhaseList(project),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Phases",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(
                Icons.menu,
                color: Colors.white,
                size: 32.0,
              ),
            ]));
  }

  static Widget getPhaseList(Project project) {
    return Container(
        constraints: const BoxConstraints(maxHeight: 300.0),
        margin: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: project.phases.length,
            itemBuilder: (context, index) {
              var deadline = DateTime.parse(project.phases[index].deadline);
              return ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.phases[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DateTime.now().isAfter(deadline)
                        ? Icon(Icons.done, color: Colors.green)
                        : Icon(
                            Icons.access_time,
                            color: Colors.orange,
                          )
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(project.phases[index].desc),
                    Text(DateFormat(Strings.timeFormat).format(deadline))
                  ],
                ),
                children: _getRequirements(project.phases[index]),
              );
            }));
  }

  static Widget getRequirementWidget(Requirement requirement) {
    var title = requirement.title == null ? "" : requirement.title;
    var decs = requirement.description == null ? "" : requirement.description;
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder(
            horizontalInside: BorderSide(
                width: 1, color: Colors.blue, style: BorderStyle.solid)),
        children: [
          TableRow(children: [
            TableCell(child: TableWidget.getCell(title)),
            TableCell(child: TableWidget.getCell(decs))
          ]),
        ],
      ),
    );
  }

  static List<Widget> _getRequirements(Phase phase) {
    List<Widget> reqs = List<Widget>();
    for (var req in phase.requirements) {
      reqs.add(getRequirementWidget(req));
    }
    return reqs;
  }
}
