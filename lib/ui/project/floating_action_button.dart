import 'package:flutter/material.dart';
import 'package:project_tracker/ui/add_project/add_project_page.dart';

class FloatingButtonBuilder {
  static FloatingActionButton build(BuildContext context) {
    return new FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        /*Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddProjectPage()));*/

        Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (context, animation, anotheranimation) {
                  return AddProjectPage();
                },
                transitionDuration: Duration(milliseconds: 800),
                transitionsBuilder: (context, animation, anotheranimation,
                    child) {
                  var begin = Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }
            )
        );
      },
    );
  }
}
