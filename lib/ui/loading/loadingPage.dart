import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/auth/auth_page.dart';
import 'package:project_tracker/ui/project/main_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  void _fetchData() async {
    final storage = FlutterSecureStorage();
    bool loadauthtmp = true;
    try {
      String token = await storage.read(key: "token");
      debugPrint("Hello $token");
      loadauthtmp = token == null;
    } catch (e) {}
    if (loadauthtmp) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AuthPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MainPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: Center(child: Column()));
  }
}
