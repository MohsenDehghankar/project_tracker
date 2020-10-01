import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_tracker/model/project/project_phase.dart';
import 'package:project_tracker/model/project/time_line_data.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:project_tracker/ui/detail/card.dart';
import 'package:timeline_tile/timeline_tile.dart';

/// timeline widget for detail page
class TimeLineBuilder {
  static Widget build(String startDate, List<Phase> phases, String deadline,
      BuildContext context) {
    // String current date
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF8F8F8),
            Colors.white,
          ],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFF35577D).withOpacity(0.2),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            body: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverPadding(padding: EdgeInsets.only(top: 15)),
                        ProjectTimeLine(
                            TimeLineData(startDate, deadline, phases)),
                        SliverPadding(padding: EdgeInsets.only(top: 60)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectTimeLine extends StatefulWidget {
  // const _DeliveryTimeline();

  final TimeLineData data;

  ProjectTimeLine(this.data);

  @override
  ProjectTimeLineState createState() => ProjectTimeLineState(data);
}

class ProjectTimeLineState extends State<ProjectTimeLine> {
  ScrollController _scrollController;
  final TimeLineData data;

  ProjectTimeLineState(this.data);

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentStep = data.now;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(currentStep * 120.0);
    });

    return DetailPageCardBuilder.build(
        Container(
          margin: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxHeight: 210),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: data.mainList.length,
            itemBuilder: (BuildContext context, int index) {
              var indicatorSize = 20.0;
              var beforeLineStyle = LineStyle(
                color: Colors.white.withOpacity(0.8),
              );

              TimeSteps status;
              LineStyle afterLineStyle;
              String step;
              String addr = "";

              if (index == 0) {
                status = TimeSteps.start;
                step = Strings.start;
                addr = "images/start.png";
              } else if (index == data.now) {
                status = TimeSteps.now;
                step = Strings.now;
                afterLineStyle = const LineStyle(color: Color(0xFF747888));
              } else if (index == data.mainList.length - 1) {
                status = TimeSteps.end;
                step = Strings.end;
                indicatorSize = 20;
                beforeLineStyle = const LineStyle(color: Color(0xFF747888));
              } else if (index < currentStep) {
                step = '${data.phases[index - 1].name} Deadline';
                addr = "images/location.png";
                status = TimeSteps.phaseDeadline;
              } else {
                step = '${data.phases[index - 2].name} Deadline';
                afterLineStyle = const LineStyle(color: Color(0xFF747888));
                beforeLineStyle = const LineStyle(color: Color(0xFF747888));
                status = TimeSteps.phaseDeadline;
              }

              return TimelineTile(
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.manual,
                lineXY: 0.6,
                isFirst: index == 0,
                isLast: index == data.mainList.length - 1,
                beforeLineStyle: beforeLineStyle,
                afterLineStyle: afterLineStyle,
                indicatorStyle: IndicatorStyle(
                  width: indicatorSize,
                  height: indicatorSize,
                  indicator: _IndicatorDelivery(status, currentStep, index),
                ),
                startChild:
                    _StartChildDelivery(index, data.mainList[index], addr),
                endChild: _EndChildDelivery(
                  text: step,
                  current: index == currentStep,
                ),
              );
            },
          ),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // subheading('My Tasks'),
              Text(
                "Status",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(
                Icons.menu,
                color: Colors.white,
                size: 32.0,
              ),
            ]));
  }
}

/// start child in the timeline
class _StartChildDelivery extends StatelessWidget {
  _StartChildDelivery(this.index, this.time, this.assetAddr);

  final int index;
  final String time;
  final String assetAddr;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          assetAddr.isEmpty
              ? Container(
                  height: 64,
                )
              : Image.asset(
                  assetAddr,
                  height: 50.0,
                ),
          Text(time)
        ],
      )),
    );
  }
}

/// last child in the timeline
class _EndChildDelivery extends StatelessWidget {
  const _EndChildDelivery({
    Key key,
    @required this.text,
    @required this.current,
  }) : super(key: key);

  final String text;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: current ? const Color(0xFF2ACA8E) : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// time steps of a project
enum TimeSteps { start, now, phaseDeadline, end }

/// status for showing
enum ShowCase { done, doing, todo }

/// a step's widget
class _IndicatorDelivery extends StatelessWidget {
  // const _IndicatorDelivery({Key key, this.status}) : super(key: key);

  final TimeSteps status;
  final int nowIndx;
  final int crrIndx;

  @override
  Widget build(BuildContext context) {
    ShowCase show;
    switch (status) {
      case TimeSteps.start:
        show = ShowCase.done;
        break;
      case TimeSteps.now:
        show = ShowCase.doing;
        break;
      case TimeSteps.phaseDeadline:
        if (nowIndx >= crrIndx) {
          show = ShowCase.done;
        } else {
          show = ShowCase.todo;
        }
        break;
      case TimeSteps.end:
        show = ShowCase.todo;
        break;
    }

    switch (show) {
      case ShowCase.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2ACA8E),
          ),
          child: const Center(
              child: Icon(
            Icons.access_time,
            size: 20.0,
          )),
        );

      case ShowCase.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Center(
              // child: Icon(Icons.check, color: Color(0xFF5D6173)),
              ),
        );
      case ShowCase.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF747888),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5D6173),
              ),
            ),
          ),
        );
    }
    return Container();
  }

  _IndicatorDelivery(this.status, this.nowIndx, this.crrIndx);
}
