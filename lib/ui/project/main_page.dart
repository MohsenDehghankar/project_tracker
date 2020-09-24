import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/main.dart';
import 'package:project_tracker/ui/project/bottom_app_bar.dart';
import 'package:project_tracker/ui/project/profile_widget.dart';
import 'package:project_tracker/ui/project/project_list.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Widget body = NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 220.0,
            floating: true,
            pinned: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: ProfileWidget().build(Theme.of(context).buttonColor),
              centerTitle: true,
            ),
          ),
        ];
      },
      body: Center(
        child:
            ProjectList.build(Theme.of(context), MediaQuery.of(context).size),
      ),
    );

    return BlocProvider(
        create: (context) => MainBloc(MyApp.navigatorKey),
        child: Scaffold(
            extendBody: true,
            bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                return BottomAppBarBuilder()
                    .build(Theme.of(context).buttonColor, context);
              },
            ),
            floatingActionButton: new FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: body));
  }
}
