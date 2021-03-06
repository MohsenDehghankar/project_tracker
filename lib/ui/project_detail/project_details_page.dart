import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/project_detail_bloc.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/ui/project_detail/body_widget.dart';
import 'package:project_tracker/ui/project_detail/loading_page.dart';
import 'package:project_tracker/ui/project_detail/page_header.dart';
import 'package:project_tracker/ui/project/bottom_app_bar.dart';

class DetailPage extends StatefulWidget {
  final String projectId;

  DetailPage(this.projectId);

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
            create: (context) => ProjectDetailBloc(),
            child: Scaffold(
                extendBody: true,
                backgroundColor: ConstColors.projectBackGround,//Colors.blueGrey[100],
                bottomNavigationBar:
                    BlocBuilder<ProjectDetailBloc, DetailState>(
                  builder: (context, state) {
                    return BottomAppBarBuilder()
                        .build(ConstColors.bottomAppBarColor, context, false);
                  },
                ),
                floatingActionButton: new FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {},
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                body: BlocBuilder<ProjectDetailBloc, DetailState>(
                  builder: (context, state) {
                    if (state is DetailStateLoading) {
                      return LoadingWidget(BlocProvider.of<ProjectDetailBloc>(context));
                    } else if (state is DetailStateDataLoaded) {
                      return Center(
                          child: NestedScrollView(
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
                                return <Widget>[
                                  PageHeader.build(
                                      state.project.name,
                                      state.project.detail)
                                ];
                              },
                              body: DetailPageBody.build(state.project)));
                    } else {
                      return Center();
                    }
                  },
                )));
  }
}
