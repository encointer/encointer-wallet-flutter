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

class RegisterParticipantPanel extends StatefulWidget {
  RegisterParticipantPanel(this.store);

  static const String route = '/encointer/registerParticipantPanel';
  final AppStore store;

  @override
  _RegisterParticipantPanel createState() => _RegisterParticipantPanel(store);


}

class _RegisterParticipantPanel extends State<RegisterParticipantPanel> {
  _RegisterParticipantPanel(this.store);

  final AppStore store;

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  Future<void> _refreshData() async {
    await webApi.encointer.fetchCurrencyIdentifiers();
  }

  Future<void> _submit() async {
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
        globalCeremonyRegistrationRefreshKey.currentState.show();
      }
    };
    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
  }


  @override
  Widget build(BuildContext context) {
    // only build dropdown after we have fetched the currency identifiers
    return  FutureBuilder(
        builder: (context, _currencyIdentifiers) => Column(
            children: <Widget>[
              Text("Choose currency:"),
              DropdownButton<dynamic>(
                value: store.encointer.chosenCid,
                icon: Icon(Icons.arrow_downward),
                iconSize: 32,
                elevation: 32,
                onChanged: (newValue) {
                  setState(() {
                    if (store.encointer.participantIndex == 0) {
                      store.encointer.chosenCid = newValue;
                    }
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
              Observer(
                  builder: (_) => store.encointer.participantIndex == 0 ?
                  RoundedButton(
                      text: "Register Participant",
                      onPressed: () => _submit()
                  ): RoundedButton(
                      text: "Unregister for: " + Fmt.currencyIdentifier(store.encointer.chosenCid).toString(),
                      onPressed: () => {}
                  )
              )
            ]
        ),
      future: webApi.encointer.fetchCurrencyIdentifiers(),
    );
  }

}


