import 'package:flutter/material.dart';

class BottomAppBarBuilder {
  Widget build(Color color) {
    return new BottomAppBar(
      color: color,
      shape: CircularNotchedRectangle(),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          IconButton(icon: Icon(Icons.refresh), onPressed: () {})
        ],
      ),
    );
  }
}
