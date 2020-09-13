import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthWidgets {
  static Widget buildUsernameInputWidget(
      BuildContext context, void Function() f) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(30.0),
              child: TextField(
                // todo
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  // hintText: "Username",
                  labelText: "Username",
                ),
              )),
          _buildLoginButton(context, f, "NEXT")
        ]);
  }

  ///
  ///
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

  static Widget buildDescriptionWidget(BuildContext context) {
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
                      """
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.
      """,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,
                    )))));
  }

  static Widget buildPasswordInputWidget(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(30.0),
              child: TextField(
                // todo
                controller: TextEditingController(),
                textInputAction: TextInputAction.send,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password"
                    ),
              )),
          _buildLoginButton(context, () {}, "Login")
        ]);
  }
}
