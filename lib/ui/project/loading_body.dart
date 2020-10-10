import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/ui/animations/loading_animation.dart';

/// loading body when fetching data in projects page
class LoadingBody extends StatefulWidget {
  final MainBloc bloc;

  LoadingBody(this.bloc) {
    bloc.add(MainEventLoadData());
  }

  @override
  LoadingState createState() => AllProjectsLoadingState();
}

class AllProjectsLoadingState extends LoadingState<LoadingBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state is MainStateErrorLoading) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              state.error,
              style: TextStyle(color: ConstColors.authErrorSnackBarColor),
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
                colors: [ConstColors.gradientStart, ConstColors.gradientEnd]),
          ),
          child: getChild()),
    );
  }
}
