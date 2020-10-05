import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:project_tracker/model/project/requirement.dart';
import 'package:project_tracker/ui/add_project/add_requirement_dialog.dart';
import 'package:project_tracker/ui/add_project/datetime_field_builder.dart';
import 'package:project_tracker/ui/add_project/text_field_builder.dart';

class PhaseForm extends StatefulWidget {
  @override
  PhaseFormState createState() => PhaseFormState();
}

class PhaseFormState extends State<PhaseForm> {
  List<Requirement> requirements;

  @override
  void initState() {
    super.initState();
    requirements = [];
  }

  Widget getReqs(List<Requirement> reqs) {
    List<Widget> chips = [];
    for (var rq in reqs) {
      chips.add(Container(
        padding: const EdgeInsets.all(5.0),
        child: ActionChip(
          avatar: CircleAvatar(
            child: Icon(Icons.close),
          ),
          label: Text(rq.title),
          onPressed: () {setState(() {
            reqs.remove(rq);
          });},
        ),
      ));
    }
    return SingleChildScrollView(
      scrollDirection: mat.Axis.horizontal,
      child: Row(
        children: chips,
      ),
    );
  }

  List<Widget> _getFields(
      BuildContext context, AddPhaseFormBloc formBloc, List<Requirement> reqs) {
    return [
      TextFieldBuilder.build('Phase Name', Icon(Icons.title), formBloc.text1),
      TextFieldBuilder.build('Phase Detail', Icon(Icons.title), formBloc.text2),
      DateTimeFieldBuilder.build(formBloc.date1, 'dd-mm-yyyy  hh:mm',
          'Deadline', '', Icon(Icons.calendar_today)),
      getReqs(reqs),
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
              }).then((value) {
            setState(() {
              reqs.add(Requirement(value[0], value[1], value[2]));
            });
          });
        },
        child: Text(
          "Add Requirement",
          style: mat.TextStyle(color: Colors.white),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
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
                    children: _getFields(context, formBloc, requirements),
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
                    Navigator.of(context).pop([
                      formBloc.text1.value,
                      formBloc.text2.value,
                      formBloc.date1.value,
                      requirements
                    ]);
                  },
                  child: Text("Add"),
                );
              },
            )
          ],
        ));
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
