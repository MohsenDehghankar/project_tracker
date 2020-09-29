import 'package:flutter/material.dart';

class PageHeader {
  static Widget build(Color backgroundColor) {
    return SliverAppBar(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
      title: Text(
        "Sourcit",
        style: TextStyle(color: Colors.black),
      ),
      expandedHeight: 100.0,
      floating: true,
      pinned: true,
      backgroundColor: backgroundColor,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            SizedBox(
              height: 60.0,
            ),
            FittedBox(
                child: Text(
              "purchase & sales ERP platform",
              textAlign: TextAlign.center,
            )),
          ],
        ),
        centerTitle: true,
      ),
    );
  }
}
