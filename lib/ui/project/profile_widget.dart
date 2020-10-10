import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tracker/model/user/user.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/style/fonts.dart';

/// builder for profile widget in projects page
class ProfileWidget {
  Widget build(Color color, User user) {
    return new Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0))),
      height: 150.0,
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
                        fontWeight: FontWeight.bold,
                        color: ConstColors.topBarTxtColor),
                  ),
                  Text(
                    user.role,
                    style: GoogleFonts.getFont(Fonts.mainFont,
                        color: ConstColors.topBarTxtColor),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
