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
              // subheading('My Tasks'),
              Text(
                "Phases",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(
                Icons.refresh,
                color: Colors.white,
                size: 32.0,
              ),
            ]));
  }

  static Widget getPhaseList() {
    return Container(
        constraints: const BoxConstraints(maxHeight: 200.0),
        margin: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(
                  "Phase 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("design UI/UX"),
                    Text("2020-77-11")
                  ],
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
      child: Column(
        children: [
          KeyValueWidget(
              icon: Icons.arrow_right,
              iconBackgroundColor: Colors.blue,//Color(0xFF2ACA8E),
              title:  title,
              subtitle: desc),
          Text("Priority: $prior")
        ],
      ),
    );
  }
}
