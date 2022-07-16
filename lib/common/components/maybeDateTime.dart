import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

/// Either returns the Text widget with the date or a [CupertinoActivityIndicator].
///
/// Useful because we have many cases where the time is first 'null' because it is still being fetched.
class MaybeDateTime extends StatelessWidget {
  MaybeDateTime(this.meetupTime, {this.dateFormat, this.style});

  final int meetupTime;

  final DateFormat dateFormat;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    String date;

    if (meetupTime != null) {
      date = dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(meetupTime));
    }

    return meetupTime != null ? Text(date, style: this.style) : CupertinoActivityIndicator();
  }
}
