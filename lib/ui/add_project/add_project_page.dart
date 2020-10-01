import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddProjectPage extends StatelessWidget {
  const AddProjectPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AllFieldsForm();
  }
}

class AllFieldsFormBloc extends FormBloc<String, String> {
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

  AllFieldsFormBloc() {
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

class AllFieldsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Scaffold(
              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: formBloc.addErrors,
                    icon: Icon(Icons.error_outline),
                    label: Text('ADD ERRORS'),
                  ),
                  SizedBox(height: 12),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: formBloc.submit,
                    icon: Icon(Icons.send),
                    label: Text('Send'),
                  ),
                ],
              ),
              body: Theme(
                  data: new ThemeData(
                    primaryColor: Colors.white,
                    accentColor: Colors.white70,
                  ),
                  child: Stack(children: <Widget>[
                    Scaffold(
                        extendBodyBehindAppBar: true,
                        backgroundColor: Colors.transparent,
                        appBar: new AppBar(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 30.0,
                                    color: Theme.of(context).buttonColor,
                                  ),
                                  onPressed: () {})
                            ],
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                        ),
                        body: Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.blueGrey,
                                    Colors.lightBlueAccent
                                  ]),
                            ),
                            child: FormBlocListener<AllFieldsFormBloc, String,
                                String>(
                              onSubmitting: (context, state) {
                                LoadingDialog.show(context);
                              },
                              onSuccess: (context, state) {
                                LoadingDialog.hide(context);

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => SuccessScreen()));
                              },
                              onFailure: (context, state) {
                                LoadingDialog.hide(context);

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(state.failureResponse)));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: AppBar().preferredSize.height),
                                child: SingleChildScrollView(
                                  physics: ClampingScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      children: <Widget>[
                                        TextFieldBlocBuilder(
                                          textFieldBloc: formBloc.text1,
                                          decoration: InputDecoration(
                                            labelText: 'Project Name',
                                            prefixIcon: Icon(Icons.title),
                                          ),
                                        ),
                                        TextFieldBlocBuilder(
                                          textFieldBloc: formBloc.text2,
                                          decoration: InputDecoration(
                                            labelText: 'Project Description',
                                            prefixIcon: Icon(Icons.description),
                                          ),
                                        ),
                                        DropdownFieldBlocBuilder<String>(
                                          selectFieldBloc: formBloc.select1,
                                          decoration: InputDecoration(
                                              labelText: 'Project Manager',
                                              prefixIcon: Icon(Icons.portrait),
                                              helperText: 'choose'),
                                          itemBuilder: (context, value) =>
                                              value,
                                        ),
                                        /*RadioButtonGroupFieldBlocBuilder<String>(
                                selectFieldBloc: formBloc.select2,
                                decoration: InputDecoration(
                                  labelText: 'RadioButtonGroupFieldBlocBuilder',
                                  prefixIcon: SizedBox(),
                                ),
                                itemBuilder: (context, item) => item,
                              ),*/
                                        /*CheckboxGroupFieldBlocBuilder<String>(
                                multiSelectFieldBloc: formBloc.multiSelect1,
                                itemBuilder: (context, item) => item,
                                decoration: InputDecoration(
                                  labelText: 'CheckboxGroupFieldBlocBuilder',
                                  prefixIcon: SizedBox(),
                                ),
                              ),*/
                                        DateTimeFieldBlocBuilder(
                                          dateTimeFieldBloc: formBloc.date1,
                                          canSelectTime: true,
                                          format:
                                              DateFormat('dd-mm-yyyy  hh:mm'),
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                          decoration: InputDecoration(
                                            labelText: 'Project Deadline',
                                            prefixIcon:
                                                Icon(Icons.calendar_today),
                                            helperText: 'Date',
                                          ),
                                        ),
                                        /*TimeFieldBlocBuilder(
                                timeFieldBloc: formBloc.time1,
                                format: DateFormat('hh:mm a'),
                                initialTime: TimeOfDay.now(),
                                decoration: InputDecoration(
                                  labelText: 'TimeFieldBlocBuilder',
                                  prefixIcon: Icon(Icons.access_time),
                                ),
                              ),*/
                                        /*SwitchFieldBlocBuilder(
                                booleanFieldBloc: formBloc.boolean2,
                                body: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text('CheckboxFieldBlocBuilder'),
                                ),
                              ),
                              CheckboxFieldBlocBuilder(
                                booleanFieldBloc: formBloc.boolean1,
                                body: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text('CheckboxFieldBlocBuilder'),
                                ),
                              ),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )))
                  ])));
        },
      ),
    );
  }
}

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
            child: CircularProgressIndicator(),
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
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => AllFieldsForm())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
