import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/components/infoItem.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/page/account/txConfirmPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/utils/UI.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

class AttestingPage extends StatefulWidget {
  AttestingPage(this.store);

  static const String route = '/encointer/attesting';
  final AppStore store;

  @override
  _AttestingPageState createState() => _AttestingPageState(store);


}

class _AttestingPageState extends State<AttestingPage> {
  _AttestingPageState(this.store);

  final AppStore store;

  String _tab = 'DOT';

  @override
  void initState() {
    webApi.encointer.fetchParticipantIndex();
    webApi.encointer.fetchParticipantCount();
    super.initState();
  }

  Widget _startMeetup(BuildContext context) {
    print("Start Meetup Pressed");
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
            RoundedButton(
                text: "start meetup",
                onPressed: () => _startMeetup() // for testing always allow sending
            ),
          ]
      ),
    );
  }

}


