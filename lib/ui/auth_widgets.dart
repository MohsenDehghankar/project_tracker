import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/style/strings.dart';

class AuthWidget extends StatefulWidget {
  @override
  AuthState createState() => AuthState();
}

class AuthState extends State<AuthWidget> {
  // If it is Username page.
  bool isUsrPage;

  // If user/pass sent
  bool sent;

  @override
  void initState() {
    super.initState();
    isUsrPage = true;
    sent = false;
  }

  ///
  /// Go to Password page
  ///
  void _enterPassword() {
    setState(() {
      isUsrPage = false;
    });
  }

  ///
  /// Create Widgets related to username input.
  ///
  static Widget _buildUsernameInputWidget(
      BuildContext context, void Function() nxtBtnCallBack) {
    return Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(30.0),
              child: TextField(
                // todo
                // controller: TextEditingController(),
                key: UniqueKey(),
                onSubmitted: (input) => nxtBtnCallBack(),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  // hintText: "Username",
                  labelText: "Username",
                ),
              )),
          _buildLoginButton(context, nxtBtnCallBack, "NEXT")
        ]);
  }

  ///
  /// Create Login (Next) button.
  ///
  static Widget _buildLoginButton(
      BuildContext context, void Function() f, String text) {
    return RaisedButton(
        // color: Theme.of(context).backgroundColor,
        elevation: 6.0,
        // splashColor: Theme.of(context).,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        textTheme: ButtonTextTheme.normal,
        onPressed: f,
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
                child: Text(
              text,
            ))));
  }

  ///
  /// Widget for App Desc.
  ///
  static Widget _buildDescWidget(BuildContext context) {
    var spaceForDesc = MediaQuery.of(context).size.height / 3;
    return Container(
        height: spaceForDesc,
        child: Scrollbar(
            thickness: 20.0,
            radius: Radius.circular(20.0),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      Strings.appDescription,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,
                    )))));
  }

  ///
  /// Create Widgets for Password input.
  ///
  static Widget _buildPasswordInputWidget(
      BuildContext context, void Function() loginBtnCallBack) {
    return Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(30.0),
              child: TextField(
                key: UniqueKey(),
                onSubmitted: (input) => loginBtnCallBack(),
                textInputAction: TextInputAction.send,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              )),
          _buildLoginButton(context, loginBtnCallBack, "Login")
        ]);
  }

  ///
  /// Login Button Callback
  ///
  void _loginCallBack() {
    setState(() {
      // todo work with API request
      sent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            _buildDescWidget(context),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: isUsrPage
                  ? _buildUsernameInputWidget(context, _enterPassword)
                  : sent
                      ? CircularProgressIndicator()
                      : _buildPasswordInputWidget(context, _loginCallBack),
            )
          ],
        ),
      ),
    );
  }
}
