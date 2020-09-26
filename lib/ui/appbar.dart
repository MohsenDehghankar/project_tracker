import 'package:flutter/material.dart';
import 'package:project_tracker/style/strings.dart';

class AppBarBuilder {
  static Widget build() => AppBar(
        title: Text(Strings.appTitle),
      );
}
