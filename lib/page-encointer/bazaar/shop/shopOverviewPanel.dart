import 'dart:convert';

import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class ShopOverviewPanel extends StatefulWidget {
  ShopOverviewPanel(this.store);

  static const String route = '/encointer/bazaar/shopOverviewPanel';
  final AppStore store;

  @override
  _ShopOverviewPanelState createState() => _ShopOverviewPanelState(store);
}

class _ShopOverviewPanelState extends State<ShopOverviewPanel> {
  _ShopOverviewPanelState(this.store);

  final AppStore store;

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
      }
    };
    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    // only build dropdown after we have fetched the currency identifiers
    return (store.encointer.participantIndex == null)
        ? CupertinoActivityIndicator()
        : Column(
            children: <Widget>[
              Observer(
                builder: (_) => (store.encointer.meetupTime == null)
                    ? Container()
                    : Column(
                        children: <Widget>[
                          Text("Next ceremony will happen at high sun on:"),
                          Text(DateFormat('yyyy-MM-dd')
                              .format(new DateTime.fromMillisecondsSinceEpoch(store.encointer.meetupTime)))
                        ],
                      ),
              ),
              Observer(
                builder: (_) => store.encointer.participantIndex == 0
                    ? RoundedButton(text: "Register Participant", onPressed: () => _submit())
                    : RoundedButton(
                        text: "Unregister",
                        //for: " + Fmt.currencyIdentifier(store.encointer.chosenCid).toString(),
                        onPressed: null),
              )
            ],
          );
  }
}
