import 'package:flutter/material.dart';
import 'package:project_tracker/blocs/add_project_form_bloc.dart';
import 'package:project_tracker/style/colors.dart';

class FloatingButtons {
  static Widget build(AddProjectFormBloc formBloc) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: null,
          backgroundColor: ConstColors.authButtonColor,
          onPressed: formBloc.submit,
          child: Icon(Icons.done, color: ConstColors.authButtonTextColor),
        ),
      ],
    );
  }
}
