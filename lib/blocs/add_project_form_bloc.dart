import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddProjectFormBloc extends FormBloc<String, String> {
  final text1 = TextFieldBloc();
  final text2 = TextFieldBloc();
  final boolean1 = BooleanFieldBloc();
  final boolean2 = BooleanFieldBloc();
  final select1 = SelectFieldBloc(
    items: ['First Person', 'Second Person'],
  );
  final select2 = SelectFieldBloc(
    items: ['Option 1', 'Option 2'],
  );
  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Option 1',
      'Option 2',
    ],
  );
  final date1 = InputFieldBloc<DateTime, Object>();
  final dateAndTime1 = InputFieldBloc<DateTime, Object>();
  final time1 = InputFieldBloc<TimeOfDay, Object>();

  AddProjectFormBloc() {
    addFieldBlocs(fieldBlocs: [
      text1,
      text2,
      boolean1,
      boolean2,
      select1,
      select2,
      multiSelect1,
      date1,
      dateAndTime1,
      time1,
    ]);
  }

  void addErrors() {
    text1.addFieldError('Awesome Error!');
    text2.addFieldError('Awsomw');
    boolean1.addFieldError('Awesome Error!');
    boolean2.addFieldError('Awesome Error!');
    select1.addFieldError('Awesome Error!');
    select2.addFieldError('Awesome Error!');
    multiSelect1.addFieldError('Awesome Error!');
    date1.addFieldError('Awesome Error!');
    dateAndTime1.addFieldError('Awesome Error!');
    time1.addFieldError('Awesome Error!');
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: 500));
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}
