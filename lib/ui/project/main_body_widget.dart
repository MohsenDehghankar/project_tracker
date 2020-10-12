import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/ui/project/error_body.dart';
import 'package:project_tracker/ui/project/profile_widget/profile_widget.dart';
import 'package:project_tracker/ui/project/project_widgets/project_list.dart';

/// main body of projects page
class MainBody {
  static Widget build(BuildContext context) {
    List<Project> projects = BlocProvider.of<MainBloc>(context).projects;

    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      if (state is MainStateErrorLoading) {
        return ErrorBody.build(context);
      } else {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: ConstColors.topBarColor,
                expandedHeight: 200.0,
                floating: true,
                pinned: false,
                snap: false,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(55.0),
                        bottomRight: Radius.circular(55.0))),
                flexibleSpace: FlexibleSpaceBar(
                  background: ProfileWidget().build(
                      ConstColors.topBarColorBackground,
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
