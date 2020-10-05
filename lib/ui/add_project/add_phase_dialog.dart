import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:project_tracker/ui/add_project/add_requirement_dialog.dart';
import 'package:project_tracker/ui/add_project/datetime_field_builder.dart';
import 'package:project_tracker/ui/add_project/text_field_builder.dart';

class AddPhaseDialogBuilder {
  static Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddPhaseFormBloc(),
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          content: Builder(
            builder: (context) {
              final formBloc = BlocProvider.of<AddPhaseFormBloc>(context);

              return Container(
                  constraints: BoxConstraints(maxHeight: 280.0),
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
                  Navigator.of(context).pop();
                },
                child: Text("Close")),
            Builder(
              builder: (context) {
                return FlatButton(
                  onPressed: () {
                    var formBloc = BlocProvider.of<AddPhaseFormBloc>(context);
                    Navigator.of(context)
                        .pop([formBloc.text1.value, formBloc.text2.value, formBloc.date1.value]);
                  },
                  child: Text("Add"),
                );
              },
            )
          ],
        ));
  }

  static List<Widget> _getFields(
      BuildContext context, AddPhaseFormBloc formBloc) {
    return [
      TextFieldBuilder.build('Phase Name', Icon(Icons.title), formBloc.text1),
      TextFieldBuilder.build('Phase Detail', Icon(Icons.title), formBloc.text2),
      DateTimeFieldBuilder.build(formBloc.date1, 'dd-mm-yyyy  hh:mm',
          'Deadline', '', Icon(Icons.calendar_today)),
      FlatButton(
        color: Colors.black,
        highlightColor: Colors.yellow,
        height: 20.0,
        splashColor: Colors.yellow,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return RequirementDialogBuilder.build(context);
              });
        },
        child: Text(
          "Add Requirement",
          style: TextStyle(color: Colors.white),
        ),
      )
    ];
  }
}

class AddPhaseFormBloc extends FormBloc<String, String> {
  final text1 = TextFieldBloc();
  final text2 = TextFieldBloc();
  final date1 = InputFieldBloc<DateTime, Object>();

  AddPhaseFormBloc() {
    addFieldBlocs(fieldBlocs: [
      text1,
      text2,
      date1,
    ]);
  }

  void addErrors() {
    text1.addFieldError('Error!');
    text2.addFieldError('Error');
    date1.addFieldError('Error!');
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
