import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/model/project.dart';
import 'package:project_tracker/ui/project/error_body.dart';
import 'package:project_tracker/ui/project/profile_widget.dart';
import 'package:project_tracker/ui/project/project_list.dart';

class MainBody {
  static Widget build(BuildContext context) {
    List<Project> projects = BlocProvider.of<MainBloc>(context).projects;
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      if (state is MainStateErrorLoading) {
        return ErrorBody.build(context, state.error);
      } else {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 220.0,
                floating: true,
                pinned: false,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: ProfileWidget().build(
                      Theme.of(context).buttonColor,
                      BlocProvider.of<MainBloc>(context).user),
                  centerTitle: true,
                ),
              ),
            ];
          },
          body: Center(
            child: ProjectList.build(
                Theme.of(context), MediaQuery.of(context).size, projects),
          ),
        );
      }
    });
  }
}