import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/appbar.dart';
import 'package:project_tracker/ui/auth/auth_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainApp(title: Strings.appTitle),
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
  Widget build(BuildContext context) {
    AppBar appBar = AppBarBuilder.build();

    return Scaffold(
        appBar: appBar,
        // todo Go to Auth widget if not logged in.
        body: AuthStatefulWidget());
  }
}
