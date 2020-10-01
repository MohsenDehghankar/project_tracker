import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/project_detail_bloc.dart';


/// loading page while fetching a project's data
class LoadingWidget {
  static Widget build(BuildContext context) {
    BlocProvider.of<ProjectDetailBloc>(context).add(DetailEventLoadData());

    return BlocListener<ProjectDetailBloc, DetailState>(
      listener: (context, state) {
        if (state is DetailStateError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              state.error,
              style: TextStyle(color: Colors.red),
            ),
          ));
        }
      },
      child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey, Colors.lightBlueAccent]),
          ),
          child: Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ))),
    );
  }
}
