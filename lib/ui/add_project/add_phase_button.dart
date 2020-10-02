import 'package:flutter/material.dart';
import 'package:project_tracker/ui/add_project/add_phase_dialog.dart';

class AddPhaseButton {
  static Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        height: 40,
        constraints: BoxConstraints(maxWidth: 120.0),
        // width: size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300],
              blurRadius: 10.0,
              // has the effect of softening the shadow
              spreadRadius: 1.0,
              // has the effect of extending the shadow
              offset: Offset(
                5.0,
                // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddPhaseDialogBuilder.build(context);
                  });
            },
            child: Center(
              child: Text(
                "Add Phase",
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )));
  }
}
