import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tracker/style/colors.dart';
import 'package:project_tracker/style/fonts.dart';
import 'package:project_tracker/ui/project_detail/widgets/card.dart';

/// key value widget builder for detail page
class KeyPairBuilder {
  static Widget build(Map<String, String> keyValues) {
    return DetailPageCardBuilder.build(
        TableWidget.build(keyValues), "Details", Colors.lightGreenAccent);
  }
}

/// Table Builder for Key Value widget
class TableWidget {
  static Widget build(Map<String, String> keyvalues) {
    return Container(
        constraints: const BoxConstraints(maxHeight: 200.0),
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Table(
          border: TableBorder(
              horizontalInside: BorderSide(
                  width: 1,
                  color: ConstColors.tableBorder,
                  style: BorderStyle.solid)),
          children: _getTableRows(keyvalues),
        )));
  }

  static List<TableRow> _getTableRows(Map<String, String> keyVal) {
    List<TableRow> result = List<TableRow>();
    for (var key in keyVal.keys) {
      result.add(TableRow(children: [
        TableCell(
          child: getCell(key),
        ),
        TableCell(
          child: getCell(keyVal[key]),
        )
      ]));
    }
    return result;
  }

  static Widget getCell(String txt) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Text(
        txt,
        style: GoogleFonts.getFont(Fonts.mainFont),
        textAlign: TextAlign.center,
      ),
    );
  }
}
