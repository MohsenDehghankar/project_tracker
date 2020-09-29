import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/ui/detail/card.dart';
import 'package:project_tracker/ui/detail/key_value_widget.dart';

class PhasesWidget {
  static Widget build() {
    return DetailPageCardBuilder.build(
        getPhaseList(),
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

  static Widget getPhaseList() {
    return Container(
        constraints: const BoxConstraints(maxHeight: 300.0),
        margin: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phase 1",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    index == 0
                        ? Icon(Icons.done, color: Colors.green)
                        : Icon(
                            Icons.access_time,
                            color: Colors.orange,
                          )
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("design UI/UX"), Text("2020-77-11")],
                ),
                children: [
                  getRequirementWidget("req 1", "req 1 decs", 1),
                  getRequirementWidget("req 2", "req 1 decs", 2),
                  getRequirementWidget("req 3", "", 0),
                ],
              );
            }));
  }

  static Widget getRequirementWidget(String title, String desc, int prior) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder(
            horizontalInside: BorderSide(
                width: 1, color: Colors.blue, style: BorderStyle.solid)),
        children: [
          TableRow(children: [
            TableCell(child: TableWidget.getCell(title)),
            TableCell(child: TableWidget.getCell(desc))
          ]),
        ],
      ),
    );
  }
}
