import 'package:flutter/material.dart';
import 'package:project_tracker/ui/add_project/add_project_page.dart';

class FloatingButtonBuilder {
  static FloatingActionButton build(BuildContext context) {
    return new FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddProjectPage()));
      },
    );
  }
}
