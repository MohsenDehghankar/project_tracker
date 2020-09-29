import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/ui/detail/key_value_widget.dart';
import 'package:project_tracker/ui/detail/phases.dart';
import 'package:project_tracker/ui/detail/timeline_builder.dart';
import 'package:project_tracker/ui/project/bottom_app_bar.dart';
import 'package:project_tracker/ui/project/profile_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
                    SliverAppBar(
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
                      backgroundColor: Theme.of(context).buttonColor,
                      snap: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          children: [
                            SizedBox(
                              height: 60.0,
                            ),
                            Text(
                              "purchase & sales ERP platform",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        centerTitle: true,
                      ),
                    ),
                  ];
                },
                body: body)));
  }
}
