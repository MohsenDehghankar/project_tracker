import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/loading/loadingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: Strings.appTitle,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MainApp(title: Strings.appTitle),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainApp extends StatefulWidget {
  MainApp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<MainApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return MainPage();
    return LoadingPage();
    // return DetailPage("test_id");
    // return AddProjectPage();
  }
}
