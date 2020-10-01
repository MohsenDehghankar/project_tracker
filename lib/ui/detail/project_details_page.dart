import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/project_detail_bloc.dart';
import 'package:project_tracker/ui/detail/detail_page_body.dart';
import 'package:project_tracker/ui/detail/loading_page.dart';
import 'package:project_tracker/ui/detail/page_header.dart';
import 'package:project_tracker/ui/project/bottom_app_bar.dart';

class DetailPage extends StatefulWidget {
  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
            create: (context) => ProjectDetailBloc(),
            child: Scaffold(
                extendBody: true,
                bottomNavigationBar:
                    BlocBuilder<ProjectDetailBloc, DetailState>(
                  builder: (context, state) {
                    return BottomAppBarBuilder()
                        .build(Theme.of(context).buttonColor, context, false);
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
                      return LoadingWidget.build(context);
                    } else if (state is DetailStateDataLoaded) {
                      return Center(
                          child: NestedScrollView(
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
                                return <Widget>[
                                  PageHeader.build(
                                      Theme.of(context).buttonColor,
                                      state.project.name,
                                      state.project.detail)
                                ];
                              },
                              body: DetailPageBody.build(state.project)));
                    } else {
                      // todo handle other states
                      return Center();
                    }
                  },
                ))));
  }
}
