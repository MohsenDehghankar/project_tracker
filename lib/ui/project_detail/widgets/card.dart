import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/style/fonts.dart';

///
/// A Card in Project's Detail page
///
class DetailPageCardBuilder {
  static Widget build(Widget child, String title, Color barColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ConstColors.cardBackground,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: ConstColors.cardShadow,//Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
              decoration: BoxDecoration(
                  color: ConstColors.cardTopBar,//Color.fromRGBO(215, 217, 217, 1.0),
                  border: Border(top: BorderSide(color: ConstColors.cardBar, width: 3.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      title,
                      style: GoogleFonts.getFont(Fonts.mainFont, fontSize: 20.0, color: ConstColors.cardBarTxt),
                    ),
                  ),
                  Icon(
                    Icons.more_vert,
                    size: 28.0,
                    color: ConstColors.cardBar,
                  )
                ],
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
