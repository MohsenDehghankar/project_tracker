import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tracker/style/fonts.dart';
import 'package:project_tracker/ui/detail/card.dart';

/// key value widget builder for detail page
class KeyPairBuilder {
  static Widget build(Map<String, String> keyValues) {
    return DetailPageCardBuilder.build(
        TableWidget.build(keyValues), "Details", Colors.lightGreenAccent);
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: Colors.green,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
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
                  width: 1, color: Colors.blue, style: BorderStyle.solid)),
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
      child: Text(txt),
    );
  }
}

class KeyList {
  static Widget build() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200.0),
      margin: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, int) {
            return Container(
                padding: const EdgeInsets.all(8.0),
                child: KeyValueWidget(
                  icon: Icons.arrow_right,
                  iconBackgroundColor: Colors.blue, //Color(0xFF2ACA8E),
                  title: 'projectManager',
                  subtitle: 'g.ahmadi',
                ));
          }),
    );
  }
}

class KeyValueWidget extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;

  KeyValueWidget({
    this.icon,
    this.iconBackgroundColor,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: iconBackgroundColor,
          size: 30.0,
        ),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: GoogleFonts.getFont(Fonts.mainFont,
                    fontSize: 16.0, fontWeight: FontWeight.w700)),
            Text(subtitle,
                style: GoogleFonts.getFont(Fonts.mainFont,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45)),
          ],
        )
      ],
    );
  }
}
