import 'package:encointer_wallet/common/components/JumpToBrowserLink.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class AssignmentPanel extends StatefulWidget {
  AssignmentPanel(this.store);

  final AppStore store;

  @override
  _AssignmentPanelState createState() => _AssignmentPanelState(store);
}

class _AssignmentPanelState extends State<AssignmentPanel> {
  _AssignmentPanelState(this.store);

  final AppStore store;

  Widget _meetupLocationLink() {
    var lat = store.encointer.meetupLocation.lat;
    var lon = store.encointer.meetupLocation.lon;
    return JumpToBrowserLink(
        'https://www.openstreetmap.org/?mlat=' +
            Fmt.degree(lat, fractionDisplay: 5) +
            '&mlon=' +
            Fmt.degree(lon, fractionDisplay: 5) +
            '&zoom=18',
        text: Fmt.degree(lat) + " lat, " + Fmt.degree(lon) + " lon");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: RoundedCard(
          padding: EdgeInsets.all(8),
          child: Column(children: <Widget>[
            Observer(
                builder: (_) => store.encointer.meetupTime != null
                    ? store.encointer.communityIdentifiers == null
                        ? Text("no currencies found")
                        : Column(children: <Widget>[
                            store.encointer.meetupIndex > 0
                                ? Column(children: <Widget>[
                                    Text("You are registered! ", style: TextStyle(color: Colors.green)),
                                    Text("Ceremony will take place on:"),
                                    Text(new DateTime.fromMillisecondsSinceEpoch(store.encointer.meetupTime)
                                        .toIso8601String()),
                                    Text("at location:"),
                                    _meetupLocationLink(),
                                  ])
                                : Text(
                                    "You are not registered for ceremony on " +
                                        DateFormat('yyyy-MM-dd').format(
                                            new DateTime.fromMillisecondsSinceEpoch(store.encointer.meetupTime)) +
                                        " for the selected community",
                                    style: TextStyle(color: Colors.red)),
                          ])
                    : CupertinoActivityIndicator())
          ]),
        ));
  }
}
