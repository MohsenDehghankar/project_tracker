import 'package:flutter/material.dart';

class ProfileWidget {
  Widget build(Color color) {
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
                  new Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        /*gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.red, Colors.lightBlueAccent]),*/
                        // todo profile
                        image: new DecorationImage(
                          image: new ExactAssetImage(
                              'images/profile.png'),
                          fit: BoxFit.cover,
                        )

                      )),
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
                  Text("Mammd Mammadi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("Flutter Developer"),
                ],
              )
          )
        ],
      ),
    );
  }
}
