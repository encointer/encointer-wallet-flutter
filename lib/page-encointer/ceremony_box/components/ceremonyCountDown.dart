import 'dart:async';

import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quiver/async.dart';

class CeremonyCountDown extends StatefulWidget {
  CeremonyCountDown(this.nextCeremonyDate);

  static const String route = '/encointer/assigning';

  final DateTime nextCeremonyDate;

  @override
  _CeremonyCountDownState createState() => _CeremonyCountDownState();
}

class _CeremonyCountDownState extends State<CeremonyCountDown> {
  _CeremonyCountDownState();

  int timeToMeetup;
  StreamSubscription<CountdownTimer> sub;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  void resetTimer() {
    _cancelTimer();

    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: timeToMeetup),
      new Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        timeToMeetup = duration.remaining.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  void _cancelTimer() {
    if (sub != null) {
      sub.cancel();
      sub = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var timeToMeetup =
        widget.nextCeremonyDate != null ? widget.nextCeremonyDate.difference(DateTime.now()).inSeconds : 0;

    if (timeToMeetup <= 0) {
      timeToMeetup = 0;
      _cancelTimer();
    } else {
      this.timeToMeetup = timeToMeetup;
      resetTimer();
    }

    Duration timeLeftUntilCeremonyStarts = Duration(seconds: timeToMeetup);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Iconsax.timer_start,
          color: encointerGrey,
          size: 18,
        ),
        SizedBox(width: 8),
        Text(
          '${timeLeftUntilCeremonyStarts.inDays}d ${timeLeftUntilCeremonyStarts.inHours.remainder(24)}h ${timeLeftUntilCeremonyStarts.inMinutes.remainder(60)}min ${timeLeftUntilCeremonyStarts.inSeconds.remainder(60)}s',
          style: Theme.of(context).textTheme.headline2.copyWith(color: encointerBlack),
        ),
      ],
    );
  }
}
