import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tracker/model/user/user.dart';
import 'package:project_tracker/style/fonts.dart';

/// builder for profile widget in projects page
class ProfileWidget {
  Widget build(Color color, User user) {
    return new Container(
      height: 150.0,
      color: color,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: new Stack(fit: StackFit.loose, children: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      new Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  image: AssetImage('images/profile.png'),
                                  fit: BoxFit.cover))),
                      new Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: NetworkImage(user.avatarAddr),
                                fit: BoxFit.cover,
                              ))),
                    ],
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 90.0, right: 100.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 18.0,
                        child: new Icon(
                          Icons.camera_alt,
                          color: color,
                        ),
                      )
                    ],
                  )),
            ]),
          ),
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    user.name,
                    style: GoogleFonts.getFont(Fonts.mainFont,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.role,
                    style: GoogleFonts.getFont(Fonts.mainFont),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
