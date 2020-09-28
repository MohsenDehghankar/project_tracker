import 'package:flutter/material.dart';

class KeyPairBuilder {
  static Widget build() {
    return Container(
        margin: const EdgeInsets.all(8),
        // constraints: const BoxConstraints(maxHeight: 250.0),
        decoration: BoxDecoration(
          color: const Color(0xFF5D6173),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
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
                    ])),
            KeyList.build()
          ],
        ));
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
                child: TaskColumn(
                  icon: Icons.alarm,
                  iconBackgroundColor: Colors.red,
                  title: 'To Do',
                  subtitle: '5 tasks now. 1 started',
                ));
          }),
    );
  }
}

class TaskColumn extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;

  TaskColumn({
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
        CircleAvatar(
          radius: 20.0,
          backgroundColor: iconBackgroundColor,
          child: Icon(
            icon,
            size: 15.0,
            color: Colors.white,
          ),
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
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
          ],
        )
      ],
    );
  }
}
