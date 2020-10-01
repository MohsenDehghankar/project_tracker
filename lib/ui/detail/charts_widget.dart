import 'package:flutter/material.dart';
import 'package:project_tracker/ui/detail/card.dart';
import 'package:charts_flutter/flutter.dart' as charts;

///
/// Chart Widget for a project
///   BurnDown Chart
///
class ChartsWidgetBuilder {
  static Widget build(DateTime startDate, DateTime endDate) {
    return DetailPageCardBuilder.build(
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              constraints: BoxConstraints(maxHeight: 200.0),
              child: _getBody(startDate, endDate),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: ChartLabel.build(),
            )
          ],
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // subheading('My Tasks'),
              Text(
                "Analytics",
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

  // get hard coded points in chart
  static Widget _getBody(DateTime start, DateTime endDate) {
    final data = [
      new TimeSeriesSales(start, 100),
      new TimeSeriesSales(start.add(Duration(days: 5)), 90),
      new TimeSeriesSales(start.add(Duration(days: 10)), 70),
      new TimeSeriesSales(start.add(Duration(days: 15)), 50),
      new TimeSeriesSales(start.add(Duration(days: 20)), 20),
      new TimeSeriesSales(start.add(Duration(days: 25)), 10),
      new TimeSeriesSales(endDate, 0),
    ];
    final data2 = [
      new TimeSeriesSales(start, 100),
      new TimeSeriesSales(endDate, 0)
    ];

    List<charts.Series<TimeSeriesSales, DateTime>> seriesList = [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'done',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Todo',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data2,
      )
    ];

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      animationDuration: Duration(milliseconds: 2000),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

///
/// Label builder for Chart
///
class ChartLabel {
  static Widget build() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Label("Todo", Colors.red),
        SizedBox(
          width: 10.0,
        ),
        Label("Done", Colors.black)
      ],
    );
  }
}

///
/// Label of chart
///
class Label extends StatelessWidget {
  final String _label;
  final Color _color;

  Label(this._label, this._color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 25),
        Text(_label, style: TextStyle(fontSize: 13)),
        Container(
          width: 100,
          height: 10,
          child: CustomPaint(
            size: Size(100, 100),
            painter: DrawLine(
              _color,
              Offset(10, 0),
              Offset(50, 0),
            ),
          ),
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }
}

/// line for a label of chart
class DrawLine extends CustomPainter {
  final Color color;
  final Offset from;
  final Offset to;

  DrawLine(this.color, this.from, this.to);

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(from, to, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
