import 'package:intl/intl.dart';
import 'package:project_tracker/style/strings.dart';

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
