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
import 'package:polka_wallet/page-encointer/registering/registerParticipantPanel.dart';


class RegisteringPage extends StatefulWidget {
  RegisteringPage(this.store);

  static const String route = '/encointer/registering';
  final AppStore store;

  @override
  _RegisteringPageState createState() => _RegisteringPageState(store);


}

class _RegisteringPageState extends State<RegisteringPage> {
  _RegisteringPageState(this.store);

  final AppStore store;

  String _tab = 'DOT';

  @override
  void initState() {
    webApi.encointer.fetchCurrencyIdentifiers();
    webApi.encointer.fetchNextMeetupTime();
    webApi.encointer.fetchParticipantIndex();
    super.initState();
  }

  Future<void> _refresh() async {
      webApi.encointer.fetchParticipantIndex();
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;
    final int decimals = encointer_token_decimals;
    return RefreshIndicator(
        key: globalBalanceRefreshKey,
        onRefresh: _refresh,
        child: SafeArea(
          child: Column(
              children: <Widget>[
                Observer(
                    builder: (_) => Text(store.encointer.currentPhase.toString())
                ),
                store.encointer.participantIndex != 0 ?
                Text("Registered for cid: " + Fmt.currencyIdentifier(store.encointer.chosenCid)) :
                RegisterParticipantPanel(store),
                Text("Next Ceremony Will Take Place on:"),
                Observer(
                    builder: (_) => Text(new DateTime.fromMillisecondsSinceEpoch(store.encointer.nextMeetupTime).toIso8601String())
                ),
              ]
          ),
      ),
    );
  }

}


