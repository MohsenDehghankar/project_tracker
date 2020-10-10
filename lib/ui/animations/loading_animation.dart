import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/style/colors.dart';


class LoadingState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> animation2;
  Animation<double> animation3;
  Animation<double> animation4;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 40.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.05, 0.25, curve: Curves.easeIn)))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    animation2 = Tween<double>(begin: 0.0, end: 40.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.05, 0.5, curve: Curves.easeIn)));
    animation3 = Tween<double>(begin: 0.0, end: 40.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.30, 0.75, curve: Curves.easeIn)));
    animation4 = Tween<double>(begin: 0.0, end: 40.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.55, 0.95, curve: Curves.easeIn)));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget getChild(){
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Stack(
                children: [
                  SizedBox(
                      height: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 5.0, left: 5.0, top: animation.value),
                        child: Icon(Icons.circle, size: 15.0, color: ConstColors.loadingColor1),
                      )),
                  SizedBox(
                      height: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 5.0, left: 5.0, top: 40 - animation.value),
                        child:
                        Icon(Icons.circle, size: 15.0, color: ConstColors.loadingColor2),
                      )),
                ],
              )),
          Center(
              child: Stack(
                children: [
                  SizedBox(
                      height: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 5.0, left: 5.0, top: animation2.value),
                        child: Icon(Icons.circle, size: 15.0, color: ConstColors.loadingColor1),
                      )),
                  SizedBox(
                      height: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 5.0, left: 5.0, top: 40 - animation2.value),
                        child:
                        Icon(Icons.circle, size: 15.0, color: ConstColors.loadingColor2),
                      )),
                ],
              )),
          Center(
              child: Stack(
                children: [
                  SizedBox(
                      height: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 5.0, left: 5.0, top: animation3.value),
                        child: Icon(Icons.circle, size: 15.0, color: ConstColors.loadingColor1),
                      )),
                  SizedBox(
                      height: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 5.0, left: 5.0, top: 40 - animation3.value),
                        child:
                        Icon(Icons.circle, size: 15.0, color: ConstColors.loadingColor2),
                      )),
                ],
              )),
          Center(
              child: Stack(
                children: [
                  SizedBox(
                      height: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 5.0, left: 5.0, top: animation4.value),
                        child: Icon(Icons.circle, size: 15.0, color: ConstColors.loadingColor1),
                      )),
                  SizedBox(
                      height: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 5.0, left: 5.0, top: 40 - animation4.value),
                        child:
                        Icon(Icons.circle, size: 15.0, color: ConstColors.loadingColor2),
                      )),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
