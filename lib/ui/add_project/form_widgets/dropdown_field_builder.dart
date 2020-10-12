import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:project_tracker/style/strings.dart';

class DropDownFieldBuilder {
  static Widget build(
      SelectFieldBloc fieldBloc, String label, String helper, Icon icon) {
    return DropdownFieldBlocBuilder<String>(
      selectFieldBloc: fieldBloc,
      decoration: InputDecoration(
          labelText: Strings.projectManager,
          prefixIcon: Icon(Icons.portrait),
          helperText: 'choose'),
      itemBuilder: (context, value) => value,
    );
  }
}
