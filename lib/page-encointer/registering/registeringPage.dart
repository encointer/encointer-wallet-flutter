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
    super.initState();
  }

  Future<void> _onSubmit() async {
    var args = {
      "title": 'register_participant',
      "txInfo": {
        "module": 'encointerCeremonies',
        "call": 'registerParticipant',
      },
      "detail": jsonEncode({
        "cid": store.encointer.chosenCid,
        "proof": {},
      }),
      "params": [
        store.encointer.chosenCid,
        null,
      ],
      'onFinish': (BuildContext txPageContext, Map res) {
        Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
        globalBalanceRefreshKey.currentState.show();
      }
    };
    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
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
                Text("Currency Identifier:"),
                DropdownButton<dynamic>(
                  value: store.encointer.chosenCid,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 16,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      store.encointer.chosenCid = newValue;
                    });
                  },
                  items: store.encointer.currencyIdentifiers
                      .map<DropdownMenuItem<dynamic>>((value) =>
                      DropdownMenuItem<dynamic>(
                      value: value,
                    child: Text(Fmt.currencyIdentifier(value)),
                  )
                  ).toList(),
                ),
                RoundedButton(
                    text: "Register Participant for Ceremony",
                    onPressed: () => _onSubmit() // for testing always allow sending
                ),
                Text("Next Ceremony Will Take Place on:"),
                Observer(
                    builder: (_) => Text(new DateTime.fromMillisecondsSinceEpoch(store.encointer.nextMeetupTime).toIso8601String())
                ),
              ]
          ),
      );
  }

}


