import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/main.dart';
import 'package:project_tracker/ui/project/bottom_app_bar.dart';
import 'package:project_tracker/ui/project/loading_body.dart';
import 'package:project_tracker/ui/project/main_body.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) => MainBloc(MyApp.navigatorKey),
          child: Scaffold(
              extendBody: true,
              bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  return BottomAppBarBuilder()
                      .build(Theme.of(context).buttonColor, context, true);
                },
              ),
              floatingActionButton: new FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {},
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                return (state is MainStateLoading)
                    ? LoadingBody.build(context)
                    : MainBody.build(context);
              }))),
    );
  }
}
