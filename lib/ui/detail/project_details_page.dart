import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/ui/detail/timeline_builder.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailPage extends StatefulWidget {
  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TimeLineBuilder.build(
          "2020-08-28T11:21:25.825Z",
          [
            "2020-08-29T11:21:25.825Z",
            "2020-10-15T11:21:25.825Z",
            "2020-11-15T11:21:25.825Z"
          ],
          "2020-12-28T11:21:25.825Z",
          context),
    ));
  }
}

class _HorizontalTimelineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horizontal Timeline',
      home: _HorizontalTimeline(),
    );
  }
}

class _HorizontalTimeline extends StatefulWidget {
  @override
  _HorizontalTimelineState createState() => _HorizontalTimelineState();
}

class _HorizontalTimelineState extends State<_HorizontalTimeline> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 16),
                  Text(
                    'Horizontal Timelines',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  const Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverPadding(padding: EdgeInsets.only(top: 20)),
                        SliverPadding(padding: EdgeInsets.only(top: 20)),
                        _DeliveryTimeline(),
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

const deliverySteps = [
  'Take your phone',
  'Choose a restaurant',
  'Order the food',
  'Wait for delivery',
  'Pay',
  'Eat and enjoy',
];

class _DeliveryTimeline extends StatefulWidget {
  const _DeliveryTimeline();

  @override
  _DeliveryTimelineState createState() => _DeliveryTimelineState();
}

class _DeliveryTimelineState extends State<_DeliveryTimeline> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const currentStep = 3;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(currentStep * 120.0);
    });

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(8),
        constraints: const BoxConstraints(maxHeight: 210),
        color: const Color(0xFF5D6173),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemCount: deliverySteps.length,
          itemBuilder: (BuildContext context, int index) {
            final step = deliverySteps[index];
            var indicatorSize = 30.0;
            var beforeLineStyle = LineStyle(
              color: Colors.white.withOpacity(0.8),
            );

            _DeliveryStatus status;
            LineStyle afterLineStyle;
            if (index < currentStep) {
              status = _DeliveryStatus.done;
            } else if (index > currentStep) {
              status = _DeliveryStatus.todo;
              indicatorSize = 20;
              beforeLineStyle = const LineStyle(color: Color(0xFF747888));
            } else {
              afterLineStyle = const LineStyle(color: Color(0xFF747888));
              status = _DeliveryStatus.doing;
            }

            return TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.6,
              isFirst: index == 0,
              isLast: index == deliverySteps.length - 1,
              beforeLineStyle: beforeLineStyle,
              afterLineStyle: afterLineStyle,
              indicatorStyle: IndicatorStyle(
                width: indicatorSize,
                height: indicatorSize,
                indicator: _IndicatorDelivery(status: status),
              ),
              startChild: _StartChildDelivery(index: index),
              endChild: _EndChildDelivery(
                text: step,
                current: index == currentStep,
              ),
            );
          },
        ),
      ),
    );
  }
}

enum _DeliveryStatus { done, doing, todo }

class _StartChildDelivery extends StatelessWidget {
  const _StartChildDelivery({Key key, this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset('images/location.png', height: 64),
      ),
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

class _IndicatorDelivery extends StatelessWidget {
  const _IndicatorDelivery({Key key, this.status}) : super(key: key);

  final _DeliveryStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _DeliveryStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Color(0xFF5D6173)),
          ),
        );
      case _DeliveryStatus.doing:
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
      case _DeliveryStatus.todo:
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
}
