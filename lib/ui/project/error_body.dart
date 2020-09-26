import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorBody {
  static Widget build(BuildContext context, String error) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: Center(child: Text(error)));
  }
}
