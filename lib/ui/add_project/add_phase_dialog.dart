import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:project_tracker/model/project/requirement.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/add_project/add_requirement_button.dart';
import 'package:project_tracker/ui/add_project/add_requirement_dialog.dart';
import 'package:project_tracker/ui/add_project/datetime_field_builder.dart';
import 'package:project_tracker/ui/add_project/text_field_builder.dart';

/// Form for Adding Phase
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
    scrollCtrnlr = ScrollController();
  }

  void scrollToBtm() {
    scrollCtrnlr.animateTo(scrollCtrnlr.position.maxScrollExtent,
        curve: Curves.ease, duration: Duration(milliseconds: 100));
  }

  Widget getReqs(List<Requirement> reqs) {
    List<Widget> chips = [];
    for (var rq in reqs) {
      chips.add(Container(
        padding: const EdgeInsets.all(5.0),
        child: ActionChip(
          backgroundColor: ConstColors.chipBackColor,
          avatar: CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(Icons.close, color: Colors.white,),
          ),
          label: Text(rq.title),
          onPressed: () {
            setState(() {
              reqs.remove(rq);
            });
          },
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
      TextFieldBuilder.build(
          Strings.phaseName, Icon(Icons.title), formBloc.text1),
      TextFieldBuilder.build(
          Strings.phaseDetail, Icon(Icons.title), formBloc.text2),
      DateTimeFieldBuilder.build(formBloc.date1, Strings.phaseDeadlineFormat,
          Strings.deadline, '', Icon(Icons.calendar_today)),
      getReqs(reqs),
      AddRequirementButton.build(() {
        showDialog(
            context: context,
            builder: (context) {
              return RequirementDialogBuilder.build(context);
            }).then((value) {
          try {
            setState(() {
              reqs.add(Requirement(value[0], value[1], value[2]));
            });
          } on Exception {
            debugPrint(Strings.requirementFormNoResult);
          } on Error {
            debugPrint(Strings.requirementFormNoResult);
          }
          Future.delayed(Duration(milliseconds: 200))
              .then((value) => scrollToBtm());
        });
      }, context)
    ];
  }

  ScrollController scrollCtrnlr;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddPhaseFormBloc(),
        child: Theme(
            data: ThemeData(
              primaryColor: ConstColors.accentColor,
              accentColor: ConstColors.accentColor,
              dialogBackgroundColor: ConstColors.dialogBackgroundColor,
            ),
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(8.0),
              content: Builder(
                builder: (context) {
                  final formBloc = BlocProvider.of<AddPhaseFormBloc>(context);

                  return Container(
                      constraints: BoxConstraints(maxHeight: 290.0),
                      child: SingleChildScrollView(
                          controller: scrollCtrnlr,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                                _getFields(context, formBloc, requirements),
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
                    return FlatButton(
                      onPressed: () {
                        var formBloc =
                            BlocProvider.of<AddPhaseFormBloc>(context);
                        Navigator.of(context).pop([
                          formBloc.text1.value,
                          formBloc.text2.value,
                          formBloc.date1.value,
                          requirements
                        ]);
                      },
                      child: Text("Add", style: TextStyle(color: Colors.black)),
                    );
                  },
                )
              ],
            )));
  }
}

/// Phase form BLoC
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
