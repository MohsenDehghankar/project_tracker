import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_tracker/blocs/project_detail_bloc.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/ui/animations/loading_animation.dart';

/// loading page while fetching a project's data
class LoadingWidget extends StatefulWidget {
  final ProjectDetailBloc bloc;

  LoadingWidget(this.bloc) {
    bloc.add(DetailEventLoadData());
  }

  @override
  LoadingState createState() => ProjectLoadingState();
}

class ProjectLoadingState extends LoadingState<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
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
                colors: [ConstColors.gradientStart, ConstColors.gradientEnd]),
          ),
          child: this.getChild()),
    );
  }
}
