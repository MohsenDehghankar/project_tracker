import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DateTimeFieldBuilder {
  static Widget build(InputFieldBloc fieldBloc, String dateFormat, String label,
      String helper, Icon icon) {
    return DateTimeFieldBlocBuilder(
      dateTimeFieldBloc: fieldBloc,
      canSelectTime: true,
      format: DateFormat(dateFormat),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.calendar_today),
        helperText: helper,
      ),
    );
  }
}
