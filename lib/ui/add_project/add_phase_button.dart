import 'package:flutter/material.dart';
import 'package:project_tracker/model/project/project_phase.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/add_project/add_phase_dialog.dart';

/// Build Button for adding phase
class AddPhaseButton {
  static Widget build(BuildContext context, void Function(Phase value) onPhaseAdded) {
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
                    return PhaseForm();
                  }).then((value) {
                    try {
                      var name = value[0];
                      var detail = value[1];
                      var deadline = value[2];
                      onPhaseAdded(
                          Phase(name, detail, deadline.toString(), []));
                    } on Error {
                      debugPrint(Strings.phaseFormNoResult);
                    } on Exception {
                      debugPrint(Strings.phaseFormNoResult);
                    }
              });
            },
            child: Center(
              child: Text(
                Strings.addPhase,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )));
  }
}
