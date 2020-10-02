import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DateTimeFieldBuilder {
  static Widget build(InputFieldBloc fieldBloc, String dateFormat, String label,
      String helper, Icon icon) {
    return DateTimeFieldBlocBuilder(
      dateTimeFieldBloc: fieldBloc,
      canSelectTime: true,
      format: DateFormat('dd-mm-yyyy  hh:mm'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      decoration: InputDecoration(
        labelText: 'Project Deadline',
        prefixIcon: Icon(Icons.calendar_today),
        helperText: 'Date',
      ),
    );
  }
}
