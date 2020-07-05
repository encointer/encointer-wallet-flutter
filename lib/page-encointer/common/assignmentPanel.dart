import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/page/account/txConfirmPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/utils/UI.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';
import 'package:polka_wallet/page-encointer/attesting/meetupPage.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class AssignmentPanel extends StatefulWidget {
  AssignmentPanel(this.store);

  final AppStore store;

  @override
  _AssignmentPanelState createState() => _AssignmentPanelState(store);
}

class _AssignmentPanelState extends State<AssignmentPanel> {
  _AssignmentPanelState(this.store);

  final AppStore store;

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  Future<void> _refreshData() async {
    // refreshed by parent!
    //await webApi.encointer.fetchCurrencyIdentifiers();
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;
    final int decimals = encointer_token_decimals;
    return Container(
        width: double.infinity,
        child: RoundedCard(
          margin: EdgeInsets.fromLTRB(16, 4, 16, 16),
          padding: EdgeInsets.all(8),
          child: Column(children: <Widget>[
            FutureBuilder<DateTime>(
                future: webApi.encointer.fetchNextMeetupTime(),
                builder: (BuildContext context,
                    AsyncSnapshot<DateTime> snapshot) {
                  if (snapshot.hasData) {
                    if (store.encointer.currencyIdentifiers.isEmpty) {
                      store.encointer.setChosenCid("");
                      return Text("no currencies found");
                    }
                    var selectedCid = store.encointer.chosenCid.isEmpty
                        ? store.encointer.currencyIdentifiers[0]
                        : store.encointer.chosenCid;
                    return Observer(
                        builder: (_) => Column(children: <Widget>[
                              Text("Next Ceremony Will Take Place on:"),
                              Text(new DateTime.fromMillisecondsSinceEpoch(
                                      store.encointer.nextMeetupTime)
                                  .toIso8601String()),
                              Text("at location:"),
                              Text(store.encointer.nextMeetupLocation.lat
                                      .toString() +
                                  " lat, " +
                                  store.encointer.nextMeetupLocation.lon
                                      .toString() +
                                  " lon"),
                            ]));
                  } else {
                    return CupertinoActivityIndicator();
                  }
                })
          ]),
        ));
  }
}
