import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:project_tracker/blocs/add_project_form_bloc.dart';
import 'package:project_tracker/ui/add_project/add_project_page.dart';
import 'package:project_tracker/ui/app_theme.dart';

class FormBodyBuilder {
  static Widget build(BuildContext context, Column mainFields) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: ContainerDecoration.getDecoration(),
        child: FormBlocListener<AddProjectFormBloc, String, String>(
            onSubmitting: (context, state) {
              LoadingDialog.show(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => SuccessScreen()));
            },
            onFailure: (context, state) {
              LoadingDialog.hide(context);

              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.failureResponse)));
            },
            child: Padding(
                padding: EdgeInsets.only(top: AppBar().preferredSize.height),
                child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: mainFields)))));
  }
}
