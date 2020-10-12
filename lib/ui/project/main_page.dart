import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/main.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/ui/project/bottom_app_bar.dart';
import 'package:project_tracker/ui/project/floating_action_button.dart';
import 'package:project_tracker/ui/project/loading_body.dart';
import 'package:project_tracker/ui/project/main_body_widget.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: ConstColors.accentColor
      ),
      home: BlocProvider(
          create: (context) => MainBloc(MyApp.navigatorKey),
          child: Scaffold(
            backgroundColor: ConstColors.projectBackGround,
              extendBody: true,
              bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  return BottomAppBarBuilder()
                      .build(ConstColors.bottomAppBarColor, context, true);
                },
              ),
              floatingActionButton: FloatingButtonBuilder.build(context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                return (state is MainStateLoading)
                    ? LoadingBody(BlocProvider.of<MainBloc>(context))
                    : MainBody.build(context);
              }))),
    );
  }
}
