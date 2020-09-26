import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/style/strings.dart';

class LoadingBody {
  static Widget build(BuildContext context) {
    BlocProvider.of<MainBloc>(context).add(MainEventLoadData());

    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state is MainStateErrorLoading) {
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

    return Container(
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
        )));
  }
}
