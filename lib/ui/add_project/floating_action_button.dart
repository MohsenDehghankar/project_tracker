import 'package:flutter/material.dart';
import 'package:project_tracker/blocs/add_project_form_bloc.dart';

class FloatingButtons {
  static Widget build(AddProjectFormBloc formBloc){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: Colors.white,
          onPressed: formBloc.addErrors,
          icon: Icon(
            Icons.error_outline,
            color: Colors.blue[300],
          ),
          label: Text(
            'ADD ERRORS',
            style: TextStyle(color: Colors.blue[300]),
          ),
        ),
        SizedBox(height: 12),
        FloatingActionButton(
          heroTag: null,
          backgroundColor: Colors.white,
          onPressed: formBloc.submit,
          child: Icon(Icons.add, color: Colors.blue[300]),
        ),
      ],
    );
  }
}