import 'package:intl/intl.dart';
import 'package:project_tracker/model/project/project_phase.dart';
import 'package:project_tracker/style/strings.dart';

/// Data for showing a project's timeline
class TimeLineData {
  final String startDate;
  final String endDate;

  // should be sorted
  final List<Phase> phases;
  List<String> mainList;
  int now;

  TimeLineData(this.startDate, this.endDate, this.phases) {
    this.setMainList();
  }

  // list of times in timeline Axis
  void setMainList() {
    phases.sort((a, b) {
      var time1 = DateTime.parse(a.deadline);
      var time2 = DateTime.parse(b.deadline);
      return time1.difference(time2).inHours;
    });
    mainList = <String>[];
    mainList
        .add(DateFormat(Strings.timeFormat).format(DateTime.parse(startDate)));
    bool less = true;
    var now = DateTime.now();
    for (var ph in phases) {
      var time = ph.deadline;
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
