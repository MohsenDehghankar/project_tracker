import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/AuthWidgets.dart';

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
  bool isUsrPage;

  @override
  void initState() {
    super.initState();
    isUsrPage = true;
  }

  void enterPassword() {
    setState(() {
      isUsrPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                AuthWidgets.buildDescriptionWidget(context),
                isUsrPage
                    ? AuthWidgets.buildUsernameInputWidget(
                        context, enterPassword)
                    : AuthWidgets.buildPasswordInputWidget(context)
              ],
            ),
          ),
        ));
  }
}
