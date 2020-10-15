import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:project_tracker/style/strings.dart';

/// Form BLoC for adding new project in add_project page.
class AddProjectFormBloc extends FormBloc<String, String> {
  final projectName = TextFieldBloc();
  final desc = TextFieldBloc();
  final manager = SelectFieldBloc(
    items: ['First Person', 'Second Person'],
  );
  final deadline = InputFieldBloc<DateTime, Object>();

  AddProjectFormBloc() {
    addFieldBlocs(fieldBlocs: [
      projectName,
      desc,
      manager,
      deadline,
    ]);
  }

  void addErrors() {
    projectName.addFieldError('Awesome Error!');
    desc.addFieldError('Awsomw');
    manager.addFieldError('Awesome Error!');
    deadline.addFieldError('Awesome Error!');
  }

  @override
  void onSubmitting() async {
    try {
      if (_validate()) {
        await Future<void>.delayed(Duration(milliseconds: 500));
        emitSuccess(canSubmitAgain: true);
      } else {
       emitFailure();
      }
    } catch (e) {
      emitFailure();
    }
  }

  bool _validate() {
    bool result = true;
    if (projectName.value.isEmpty) {
      projectName.addFieldError(Strings.fieldEmpty);
      result = false;
    }
    if (desc.value.isEmpty) {
      desc.addFieldError(Strings.fieldEmpty);
      result = false;
    }
    if (manager.value == null) {
      manager.addFieldError(Strings.fieldEmpty);
      result = false;
    }
    if (deadline.value == null) {
      deadline.addFieldError(Strings.fieldEmpty);
      result = false;
    }
    return result;
  }
}
