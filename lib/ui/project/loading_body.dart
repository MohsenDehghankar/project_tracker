import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';

class LoadingBody {
  static Widget build(BuildContext context) {
    BlocProvider.of<MainBloc>(context).add(MainEventLoadData());
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
