import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tracker/style/fonts.dart';

/// detail page header
class PageHeader {
  static Widget build(Color backgroundColor, String title, String decs) {
    return SliverAppBar(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
      title: Text(
        title,
        style: GoogleFonts.getFont(Fonts.mainFont, color: Colors.black),
      ),
      expandedHeight: 100.0,
      floating: true,
      pinned: true,
      backgroundColor: Color.fromRGBO(189, 201, 255, 0.5),
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            SizedBox(
              height: 60.0,
            ),
            FittedBox(
                child: Text(
              decs,
              textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(Fonts.mainFont),
            )),
          ],
        ),
        centerTitle: true,
      ),
    );
  }
}
