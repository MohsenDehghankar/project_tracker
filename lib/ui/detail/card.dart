import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tracker/style/fonts.dart';

///
/// A Card in Project's Detail page
///
class DetailPageCardBuilder {
  static Widget build(Widget child, String title, Color barColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(237, 246, 247, 0.9), //const Color(0xFF5D6173),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            // margin: const EdgeInsets.all(2.0),
            // padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                // color: Colors.black,
                // borderRadius: BorderRadius.circular(10.0),
                borderRadius: BorderRadius.circular(5.0)),
            // child: bar,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(215, 217, 217, 1.0),
                  border: Border(top: BorderSide(color: barColor, width: 3.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      title,
                      style: GoogleFonts.getFont(Fonts.mainFont, fontSize: 22.0),
                      /*style: TextStyle(
                        fontSize: 22.0,
                      ),*/
                    ),
                  ),
                  Icon(
                    Icons.more_vert,
                    size: 30.0,
                    color: barColor,
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
