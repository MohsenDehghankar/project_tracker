import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_tracker/blocs/auth_bloc.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';
import 'package:project_tracker/ui/loading/loadingPage.dart';
import 'package:project_tracker/ui/project/main_page.dart';

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
  bool loadAuth;
  bool load;


  @override
  void initState() {
    super.initState();
    loadAuth = true;
    load = true;
  }

  @override
  Widget build(BuildContext context) {
    // todo check existence of token
    // return loadAuth ? AuthPage() : MainPage();
    // return MainPage();
    return LoadingPage();
    // return load ? LoadingPage() : loadAuth ? AuthPage() : MainPage();
  }
}
