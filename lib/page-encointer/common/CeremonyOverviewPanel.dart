import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/page/account/txConfirmPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/utils/UI.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';
import 'package:polka_wallet/page-encointer/attesting/meetupPage.dart';

class CeremonyOverviewPanel extends StatefulWidget {
  CeremonyOverviewPanel(this.store);

  final AppStore store;

  @override
  _CeremonyOverviewPanelState createState() => _CeremonyOverviewPanelState(store);

}

class _CeremonyOverviewPanelState extends State<CeremonyOverviewPanel> {
  _CeremonyOverviewPanelState(this.store);

  final AppStore store;

  String _tab = 'DOT';

  @override
  void initState() {
    webApi.encointer.fetchParticipantIndex();
    webApi.encointer.fetchParticipantCount();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;
    final int decimals = encointer_token_decimals;
    return SafeArea(
      child: Column(
          children: <Widget>[
            Observer(
                builder: (_) => Text(store.encointer.currentPhase.toString())
            ),
            store.encointer.participantIndex != 0 ? Text("You are registered for CID: " +
                Fmt.currencyIdentifier(store.encointer.chosenCid)) : Text("You are not registered for a ceremony..."),
            Text("Number of participants:"),
            store.encointer.participantIndex != 0 ? Text(store.encointer.participantCount.toString()) : Text(""),
            Text("Next Ceremony Will Take Place on:"),
            Observer(
                builder: (_) => Text(new DateTime.fromMillisecondsSinceEpoch(store.encointer.nextMeetupTime).toIso8601String())
            ),
          ]
      ),
    );
  }
}


