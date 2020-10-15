import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:project_tracker/style/strings.dart';

/// Dialog for creating requirements of a phase
class RequirementDialogBuilder {
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddRequirementFormBloc(),
        child: AlertDialog(
          title: Text(Strings.requirement),
          content: Builder(
            builder: (context) {
              var formBloc = BlocProvider.of<AddRequirementFormBloc>(context);
              return Container(
                  constraints: BoxConstraints(maxHeight: 270.0),
                  child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _getFields(context, formBloc),
                      )));
            },
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop([]);
                },
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.black),
                )),
            Builder(
              builder: (context) {
                var formBloc = BlocProvider.of<AddRequirementFormBloc>(context);
                return FlatButton(
                    onPressed: () {
                      if (formBloc.validate()) {
                      Navigator.of(context).pop([
                        formBloc.titleField.value,
                        formBloc.detailField.value,
                        int.parse(formBloc.priorField.value)
                      ]);
                      }
                    },
                    child: Text("Add", style: TextStyle(color: Colors.black)));
              },
            )
          ],
        ));
  }

  List<Widget> _getFields(BuildContext context,
      AddRequirementFormBloc formBloc) {
    return [
      TextFieldBlocBuilder(
        textFieldBloc: formBloc.titleField,
        decoration: InputDecoration(
          labelText: 'Title',
          prefixIcon: Icon(Icons.title),
        ),
      ),
      TextFieldBlocBuilder(
        textFieldBloc: formBloc.detailField,
        decoration: InputDecoration(
          labelText: 'Detail',
          prefixIcon: Icon(Icons.description),
        ),
      ),
      TextFieldBlocBuilder(
        textFieldBloc: formBloc.priorField,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Priority (1-5)',
          prefixIcon: Icon(Icons.description),
        ),
      )
    ];
  }
}

class AddRequirementFormBloc extends FormBloc<String, String> {
  final titleField = TextFieldBloc();
  final detailField = TextFieldBloc();
  final priorField = TextFieldBloc();

  AddRequirementFormBloc() {
    addFieldBlocs(fieldBlocs: [
      titleField,
      detailField,
      priorField,
    ]);
  }

  bool validate() {
    bool result = true;
    if (titleField.value.isEmpty) {
      result = false;
      titleField.addFieldError(Strings.fieldEmpty);
    }
    if (detailField.value.isEmpty) {
      result = false;
      detailField.addFieldError(Strings.fieldEmpty);
    }
    if (priorField.value.isEmpty) {
      result = false;
      priorField.addFieldError(Strings.fieldEmpty);
    } else {
      try {
        var val = int.parse(priorField.value);
        if (val > 5 || val <= 0) {
          result = false;
          priorField.addFieldError(Strings.invalidPrio);
        }
      } catch (e) {
        result = false;
        priorField.addFieldError(Strings.invalidPrio);
      }
    }
    return result;
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
