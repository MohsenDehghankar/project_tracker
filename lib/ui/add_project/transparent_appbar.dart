import 'package:flutter/material.dart';

class TransparentAppBar {
  static AppBar build(BuildContext context) {
    return new AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: Icon(
                Icons.close,
                size: 30.0,
                color: Theme.of(context).buttonColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
