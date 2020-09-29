import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/model/project/time_line_data.dart';
import 'package:project_tracker/ui/detail/charts_widget.dart';
import 'package:project_tracker/ui/detail/key_value_widget.dart';
import 'package:project_tracker/ui/detail/page_header.dart';
import 'package:project_tracker/ui/detail/phases.dart';
import 'package:project_tracker/ui/detail/timeline_builder.dart';
import 'package:project_tracker/ui/project/bottom_app_bar.dart';

class DetailPage extends StatefulWidget {
  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Widget body = SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        DeliveryTimeline(TimeLineData(
          "2020-08-28T11:21:25.825Z",
          "2020-12-28T11:21:25.825Z",
          [
            "2020-09-03T11:21:25.825Z",
            "2020-08-29T11:21:25.825Z",
            "2020-10-15T11:21:25.825Z",
            "2020-11-15T11:21:25.825Z"
          ],
        )),
        SizedBox(
          height: 10.0,
        ),
        ChartsWidgetBuilder.build(DateTime.parse("2020-08-28T11:21:25.825Z"),
            DateTime.parse("2020-09-28T11:21:25.825Z")),
        SizedBox(
          height: 10.0,
        ),
        KeyPairBuilder.build(),
        SizedBox(
          height: 10.0,
        ),
        PhasesWidget.build(),
        SizedBox(
          height: 100.0,
        ),
      ],
    ));

    return Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomAppBarBuilder()
            .build(Theme.of(context).buttonColor, context, false),
        floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Center(
            child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    PageHeader.build(Theme.of(context).buttonColor)
                  ];
                },
                body: body)));
  }
}
