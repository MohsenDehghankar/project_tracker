import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_tracker/style/strings.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineBuilder {
  static Widget build(String startDate, List<String> phasesDeadline,
      String deadline, BuildContext context) {
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
                        DeliveryTimeline(
                            TimeLineData(startDate, deadline, phasesDeadline)),
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

class DeliveryTimeline extends StatefulWidget {
  // const _DeliveryTimeline();

  final TimeLineData data;

  DeliveryTimeline(this.data);

  @override
  DeliveryTimelineState createState() => DeliveryTimelineState(data);
}

class TimeLineData {
  final String startDate;
  final String endDate;

  // should be sorted
  final List<String> phaseDeadline;
  List<String> mainList;
  int now;

  TimeLineData(this.startDate, this.endDate, this.phaseDeadline) {
    this.setMainList();
  }

  void setMainList() {
    phaseDeadline.sort((a, b) {
      var time1 = DateTime.parse(a);
      var time2 = DateTime.parse(b);
      return time1.difference(time2).inHours;
    });
    mainList = <String>[];
    mainList
        .add(DateFormat(Strings.timeFormat).format(DateTime.parse(startDate)));
    bool less = true;
    var now = DateTime.now();
    for (var time in phaseDeadline) {
      var dead = DateTime.parse(time);
      if (dead.difference(now).inHours > 0 && less) {
        mainList.add(DateFormat(Strings.timeFormat).format(now));
        this.now = mainList.length - 1;
        mainList.add(DateFormat(Strings.timeFormat).format(dead));
        less = false;
      } else {
        mainList.add(DateFormat(Strings.timeFormat).format(dead));
      }
    }
    mainList
        .add(DateFormat(Strings.timeFormat).format(DateTime.parse(endDate)));
  }
}

class DeliveryTimelineState extends State<DeliveryTimeline> {
  ScrollController _scrollController;
  final TimeLineData data;

  DeliveryTimelineState(this.data);

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

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF5D6173),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8.0),
      // padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
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
                      "Time Line",
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
          Container(
            margin: const EdgeInsets.all(8),
            constraints: const BoxConstraints(maxHeight: 210),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              // phases + end + start + now
              itemCount: data.mainList.length,
              itemBuilder: (BuildContext context, int index) {
                var indicatorSize = 30.0;
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
                  step = 'Phase ${index - 1} Deadline';
                  addr = "images/location.png";
                  status = TimeSteps.phaseDeadline;
                } else {
                  step = 'Phase ${index - 2} Deadline';
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
        ],
      ),
    );
  }
}

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
          // Image.asset('images/location.png', height: 64),
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

enum TimeSteps {
  /*done,
  todo,
  doing,*/
  // main part
  start,
  now,
  phaseDeadline,
  end
}

enum ShowCase { done, doing, todo }

class _IndicatorDelivery extends StatelessWidget {
  // const _IndicatorDelivery({Key key, this.status}) : super(key: key);

  final TimeSteps status;
  final int nowIndx;
  final int crrIndx;

  @override
  Widget build(BuildContext context) {
    // debugPrint("index ==> $crrIndx");

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
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
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
