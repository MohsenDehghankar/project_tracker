import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/rendering.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart' as gFont;
import 'package:project_tracker/blocs/add_project_form_bloc.dart';
import 'package:project_tracker/model/project/project_phase.dart';
import 'package:project_tracker/style/fonts.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/add_project/add_phase_button.dart';
import 'package:project_tracker/ui/add_project/datetime_field_builder.dart';
import 'package:project_tracker/ui/add_project/dropdown_field_builder.dart';
import 'package:project_tracker/ui/add_project/floating_action_button.dart';
import 'package:project_tracker/ui/add_project/form_body_widget.dart';
import 'package:project_tracker/ui/add_project/text_field_builder.dart';
import 'package:project_tracker/ui/add_project/transparent_appbar.dart';

/// Page for creating new projects
class AddProjectPage extends StatefulWidget {
  @override
  AddProjectFormState createState() => AddProjectFormState();
}

class AddProjectFormState extends State<AddProjectPage> {
  // added phases
  List<Phase> phases;

  @override
  void initState() {
    super.initState();
    phases = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProjectFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AddProjectFormBloc>(context);

          return Scaffold(
              floatingActionButton: FloatingButtons.build(formBloc),
              body: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.white,
                    accentColor: Colors.white70,
                  ),
                  child: Stack(children: <Widget>[
                    Scaffold(
                        resizeToAvoidBottomInset: false,
                        extendBodyBehindAppBar: true,
                        backgroundColor: Colors.transparent,
                        appBar: TransparentAppBar.build(context),
                        body: FormBodyBuilder.build(
                            context,
                            Column(
                              children: <Widget>[
                                TextFieldBuilder.build(Strings.projectName,
                                    Icon(Icons.title), formBloc.text1),
                                TextFieldBuilder.build(Strings.projectDesc,
                                    Icon(Icons.description), formBloc.text2),
                                DropDownFieldBuilder.build(
                                    formBloc.select1,
                                    Strings.projectManager,
                                    'choose',
                                    Icon(Icons.portrait)),
                                DateTimeFieldBuilder.build(
                                    formBloc.date1,
                                    Strings.phaseDeadlineFormat,
                                    Strings.projectDeadline,
                                    'Date',
                                    Icon(Icons.calendar_today)),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _getPhases(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                AddPhaseButton.build(context, (value) {
                                  setState(() {
                                    phases.add(value);
                                  });
                                })
                              ],
                            ), () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                    Strings.projectSuccess,
                                    style: gFont.GoogleFonts.getFont(
                                        Fonts.mainFont),
                                  ),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          formBloc.clear();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"))
                                  ],
                                );
                              });
                        }))
                  ])));
        },
      ),
    );
  }

  Widget _getPhases() {
    List<Widget> chips = [];
    for (var phs in phases) {
      chips.add(Container(
          padding: const EdgeInsets.all(5.0),
          child: ActionChip(
            avatar: CircleAvatar(
              child: Icon(Icons.close),
            ),
            label: Text(phs.name),
            onPressed: () {
              setState(() {
                phases.remove(phs);
              });
            },
          )));
    }
    return SingleChildScrollView(
        scrollDirection: mat.Axis.horizontal,
        child: Row(
          children: chips,
        ));
  }
}

/// loading after form submitted
class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'Success',
              style: mat.TextStyle(fontSize: 54, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => AddProjectPage())),
              icon: Icon(Icons.replay),
              label: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
