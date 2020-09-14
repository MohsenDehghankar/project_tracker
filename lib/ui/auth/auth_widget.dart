import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/page_transition_anim.dart';

///
/// Authentication Widget:
///   1. Input Fields
///   2. App Description
///
class AuthWidget extends StatefulWidget {
  final AppBar appbar;

  AuthWidget(this.appbar);

  @override
  AuthState createState() => AuthState(appbar);
}

class AuthState extends State<AuthWidget> {
  // If it is Username page.
  bool isUsrPage;

  // If user/pass sent
  bool sent;

  final AppBar appBar;

  AuthState(this.appBar);

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
      BuildContext context, void Function() nxtBtnCallBack, bool isPortrait) {
    Widget field = TextField(
      key: UniqueKey(),
      onSubmitted: (input) => nxtBtnCallBack(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: Strings.username,
      ),
    );
    if (isPortrait) {
      return Column(
          key: UniqueKey(),
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(30.0), child: field),
            _buildLoginButton(context, nxtBtnCallBack, Strings.next, isPortrait)
          ]);
    } else {
      return Column(
        children: <Widget>[
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: field,
            ),
          ),
          _buildLoginButton(context, () {}, Strings.next, isPortrait)
        ],
      );
    }
  }

  ///
  /// Create Login (Next) button.
  ///
  static Widget _buildLoginButton(
      BuildContext context, void Function() f, String text, bool portrait) {
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
            width: portrait
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width / 3,
            child: Center(
                child: Text(
              text,
            ))));
  }

  ///
  /// Widget for App Desc.
  ///
  Widget _buildDescWidget(BuildContext context, String desc, bool isPortrait) {
    Size size = MediaQuery.of(context).size;
    var height = isPortrait
        ? size.height / 3
        : size.height - appBar.preferredSize.height;
    var width = isPortrait ? size.width : size.width / 2;
    return Container(
        key: UniqueKey(),
        height: height,
        width: width,
        child: Scrollbar(
            thickness: 20.0,
            radius: Radius.circular(20.0),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      desc,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,
                    )))));
  }

  ///
  /// Create Widgets for Password input.
  ///
  static Widget _buildPasswordInputWidget(
      BuildContext context, void Function() loginBtnCallBack, bool isPortrait) {
    Widget field = TextField(
      key: UniqueKey(),
      onSubmitted: (input) => loginBtnCallBack(),
      textInputAction: TextInputAction.send,
      obscureText: true,
      decoration: InputDecoration(labelText: Strings.password),
    );
    if (isPortrait) {
      return Column(
          key: UniqueKey(),
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(30.0), child: field),
            _buildLoginButton(
                context, loginBtnCallBack, Strings.login, isPortrait)
          ]);
    } else {
      return Expanded(
          child: Column(
        children: <Widget>[
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: field,
            ),
          ),
          _buildLoginButton(context, () {}, Strings.login, isPortrait)
        ],
      ));
    }
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

  ///
  /// Get Main Auth Widget based on Orientation
  ///
  Widget getAuthWidgetByOrient(BuildContext context, Orientation orientation) {
    AnimatedSwitcher switcher = AnimationBuilder.getAnimation(
      isUsrPage
          ? _buildUsernameInputWidget(
              context, _enterPassword, orientation == Orientation.portrait)
          : sent
              ? CircularProgressIndicator()
              : _buildPasswordInputWidget(
                  context, _loginCallBack, orientation == Orientation.portrait),
    );
    List<Widget> subWidgets = <Widget>[
      AnimationBuilder.getAnimation(isUsrPage
          ? _buildDescWidget(context, Strings.userPageDescription,
              orientation == Orientation.portrait)
          : _buildDescWidget(context, Strings.passPageDescription,
              orientation == Orientation.portrait)),
      orientation == Orientation.portrait ? switcher : Expanded(child: switcher)
    ];
    return orientation == Orientation.portrait
        ? Column(
            children: subWidgets,
          )
        : Row(
            /*crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  key: UniqueKey(),
                  height: MediaQuery.of(context).size.height -
                      appBar.preferredSize.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Scrollbar(
                      thickness: 20.0,
                      radius: Radius.circular(20.0),
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Text(
                                Strings.userPageDescription,
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.justify,
                              ))))),
              Expanded(
                  child: Column(children: <Widget>[
                Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: TextField(
                          key: UniqueKey(),
                          onSubmitted: (input) => {},
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: Strings.username,
                          ),
                        ))),
                _buildLoginButton(context, () => {}, Strings.next, false)
              ])),
            ],*/
            children: subWidgets,
          );
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
        child: Center(child: getAuthWidgetByOrient(context, orientation)));
  }
}
