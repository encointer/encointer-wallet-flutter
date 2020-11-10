import 'dart:async';

import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page-encointer/common/assignmentPanel.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class AssigningPage extends StatefulWidget {
  AssigningPage(this.store);

  static const String route = '/encointer/assigning';
  final AppStore store;

  @override
  _AssigningPageState createState() => _AssigningPageState(store);
}

class _AssigningPageState extends State<AssigningPage> {
  _AssigningPageState(this.store);

  final AppStore store;

  int timeToMeetup;
  StreamSubscription<CountdownTimer> sub;

  @override
  void initState() {
    // TODO: remove once we're doing this in init of attesting
    this.store.encointer.purgeAttestations();
    this.timeToMeetup = getTimeToMeetup();
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  void startTimer() {
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

  @override
  Widget build(BuildContext context) {
    Map dic = I18n.of(context).encointer;

    if (sub == null) {
      startTimer();
    }

    return SafeArea(
      child: Column(children: <Widget>[
        AssignmentPanel(store),
        RoundedButton(
          text: timeToMeetup > 60 ? "${dic['meetup.remaining']} ${Fmt.hhmmss(timeToMeetup)}" : dic['meetup.start'],
          onPressed: timeToMeetup > 60 ? null : null,
        )
      ]),
    );
  }

  /// Calculates the remaining time until the next meetup starts. As Gesell implements timewarp we cannot use the time
  /// received by the blockchain. Hence, we need to calculate it differently.
  int getTimeToMeetup() {
    if (store.settings.endpointIsGesell) {
      var now = DateTime.now();
      if (10 < now.minute && now.minute < 20) {
        return ((19 - now.minute) * 60 + 60 - now.second);
      } else if (40 < now.minute && now.minute < 50) {
        return ((49 - now.minute) * 60 + 60 - now.second);
      } else {
        print("Warning: Invalid time to meetup");
      }
    } else {
      return store.encointer.meetupTime;
    }
  }
}
