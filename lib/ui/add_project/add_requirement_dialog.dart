import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequirementDialogBuilder {
  static Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Requirement"),
      content: Container(
          constraints: BoxConstraints(maxHeight: 270.0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _getFields(context),
          ))),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Add"))
      ],
    );
  }

  static List<Widget> _getFields(BuildContext context) {
    return [
      TextField(
        decoration: InputDecoration(
          labelText: 'Title',
          prefixIcon: Icon(Icons.title),
        ),
      ),
      TextField(
        decoration: InputDecoration(
          labelText: 'Detail',
          prefixIcon: Icon(Icons.description),
        ),
      ),
      TextField(
        inputFormatters: [
        ],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Priority (1-5)',
          prefixIcon: Icon(Icons.description),
        ),
      ),
    ];
  }
}

class SliderValue {
  int value;
}
