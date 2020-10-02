import 'package:flutter/material.dart';

class AddPhaseButton {
  static Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        height: 40,
        constraints: BoxConstraints(maxWidth: 120.0),
        // width: size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300],
              blurRadius: 10.0,
              // has the effect of softening the shadow
              spreadRadius: 1.0,
              // has the effect of extending the shadow
              offset: Offset(
                5.0,
                // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(8.0),
                      title: Text("Title"),
                      content: Container(
                          constraints: BoxConstraints(maxHeight: 200.0),
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Phase Name',
                                  prefixIcon: Icon(Icons.description),
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Phase Detail',
                                  prefixIcon: Icon(Icons.description),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              FlatButton(
                                color: Colors.black,
                                highlightColor: Colors.yellow,
                                splashColor: Colors.yellow,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Requirement"),
                                          content: Text("Add Requirements"),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Add"))
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "Add Requirement",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ))),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close")),
                        FlatButton(
                          onPressed: () {},
                          child: Text("Add"),
                        )
                      ],
                    );
                  });
            },
            child: Center(
              child: Text(
                "Add Phase",
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )));
  }
}
