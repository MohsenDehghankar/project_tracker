import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/ui/auth/auth_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginWidget(title: 'Login'),
    );
  }
}

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginWidget> {

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(widget.title),
    );
    return Scaffold(
        appBar: appBar,
        // todo Go to Auth widget if not logged in.
        body: AuthWidget(appBar)
    );
  }
}
