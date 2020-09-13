import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        primarySwatch: Colors.orange,
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

  Widget _buildDescriptionWidget() {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              """
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.
      """,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.justify,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: _buildDescriptionWidget(),
            ),
            Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                        decoration: InputDecoration(
                        hintText: "Username"
                    ),
                  )),
                  RaisedButton(
                    textTheme: ButtonTextTheme.normal,
                    onPressed: () {},
                    child: Text(
                      "NEXT"
                    )
                  )
                ]
            )
          ],
        ),
      ),
    );
  }
}
