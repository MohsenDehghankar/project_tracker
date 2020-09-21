import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
        bottomNavigationBar:
            BottomAppBarBuilder().build(Theme.of(context).buttonColor),
        floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: body);
  }
}
