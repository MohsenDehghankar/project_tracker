import 'package:flutter/material.dart';
import 'package:project_tracker/ui/detail/card.dart';

class KeyPairBuilder {
  static Widget build() {
    return DetailPageCardBuilder.build(
        KeyList.build(),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // subheading('My Tasks'),
              Text(
                "Details",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(
                Icons.refresh,
                color: Colors.white,
                size: 32.0,
              ),
            ]));
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

class KeyList {
  static Widget build() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200.0),
      margin: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, int) {
            return Container(
                padding: const EdgeInsets.all(8.0),
                child: KeyValueWidget(
                  icon: Icons.info_outline,
                  iconBackgroundColor: Color(0xFF2ACA8E),
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
        /* CircleAvatar(
          radius: 20.0,
          backgroundColor: iconBackgroundColor,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),*/
        Icon(
          Icons.info_outline,
          color: iconBackgroundColor,
          size: 30.0,
        ),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45),
            ),
          ],
        )
      ],
    );
  }
}
