import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_tracker/style/strings.dart';

class RequirementDialogBuilder {
  static Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController detail = TextEditingController();
    TextEditingController priority = TextEditingController();

    return AlertDialog(
      title: Text(Strings.requirement),
      content: Container(
          constraints: BoxConstraints(maxHeight: 270.0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _getFields(context, title, detail, priority),
          ))),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop([]);
            },
            child: Text("Close")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop([
                title.value.text,
                detail.value.text,
                int.parse(priority.value.text)
              ]);
            },
            child: Text("Add"))
      ],
    );
  }

  static List<Widget> _getFields(
      BuildContext context,
      TextEditingController title,
      TextEditingController detail,
      TextEditingController prior) {
    return [
      TextField(
        controller: title,
        decoration: InputDecoration(
          labelText: 'Title',
          prefixIcon: Icon(Icons.title),
        ),
      ),
      TextField(
        controller: detail,
        decoration: InputDecoration(
          labelText: 'Detail',
          prefixIcon: Icon(Icons.description),
        ),
      ),
      TextField(
        inputFormatters: [],
        controller: prior,
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
