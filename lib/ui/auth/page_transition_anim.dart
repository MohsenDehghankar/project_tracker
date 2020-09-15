import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class AuthAnimationUtil {
  ///
  /// AnimatedSwitcher for User/Pass pages
  ///
  static AnimatedSwitcher getAnimation(Widget child){
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: child,
    );
  }
}