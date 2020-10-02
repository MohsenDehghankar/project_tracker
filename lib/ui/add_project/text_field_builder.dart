import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class TextFieldBuilder {
  static Widget build(String label, Icon icon, TextFieldBloc fieldBloc){
    return TextFieldBlocBuilder(
      textFieldBloc: fieldBloc,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
      ),
    );
  }
}