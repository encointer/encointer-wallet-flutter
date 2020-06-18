import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/page-encointer/registering/registeringPage.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/utils/i18n/index.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/utils/UI.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/page/account/txConfirmPage.dart';

import 'package:polka_wallet/store/encointer/types/encointerTypes.dart';

class EncointerEntry extends StatelessWidget {
  EncointerEntry(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n
        .of(context)
        .encointer;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dic['encointer'] ?? 'Encointer Platform',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme
                          .of(context)
                          .cardColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Text('Hello World')
            ),
            PhaseAwareBox(store)
          ],
        ),
      ),
    );
  }
}

class PhaseAwareBox extends StatefulWidget {
  PhaseAwareBox(this.store);

  static final String route = '/encointer/phaseawarebox';

  final AppStore store;

  @override
  _PhaseAwareBoxState createState() => _PhaseAwareBoxState(store);
}

class _PhaseAwareBoxState extends State<PhaseAwareBox>
    with SingleTickerProviderStateMixin {
  _PhaseAwareBoxState(this.store);

  final AppStore store;

  final String _currentPhaseSubscribeChannel = 'currentPhase';

  TabController _tabController;
  int _txsPage = 0;
  bool _isLastPage = false;
  ScrollController _scrollController;

  Future<void> _updateData() async {
    String pubKey = store.account.currentAccount.pubKey;
    await webApi.assets.fetchBalance(pubKey);
  }

  Future<void> _refreshData() async {
    setState(() {
      _txsPage = 0;
      _isLastPage = false;
    });
    await _updateData();
  }

  Future<void> _onSubmit() async {
    var cids = await webApi.encointer.fetchCurrencyIdentifiers();
    var cid0 = cids.values.toList()[0][0];
    print("Cids: " + cid0.toString());
    final Map dic = I18n.of(context).assets;
    final String pubKey = widget.store.account.currentAccount.pubKey;
    final String accountId = widget.store.account.pubKeyAddressMap[0][pubKey];
    var args = {
      "title": 'register_participant',
      "txInfo": {
        "module": 'encointerCeremonies',
        "call": 'registerParticipant',
      },
      "detail": jsonEncode({
        "cid": cid0,
        "proof": {},
      }),
      "params": [
        cid0,
        "",
      ],
      'onFinish': (BuildContext txPageContext, Map res) {
        Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
        globalBalanceRefreshKey.currentState.show();
      }
    };
    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
  }

  @override
  void initState() {
    super.initState();
    // get current phase before we subscribe
    webApi.encointer.fetchCurrentPhase();

    if (!store.settings.loading) {
      print('Subscribing to current phase');
      webApi.encointer.subscribeCurrentPhase();
    }
  }

  @override
  void dispose() {
    webApi.encointer.unsubscribeCurrentPhase();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    _refreshData();
    return Container(
        color: const Color(0xFFFFFE306),
        child: Column(
            children: <Widget>[
              Observer(
                  builder: (_) => Text(store.encointer.currentPhase.toString())
              ),
              RoundedButton(
                  text: "Register Participant for Ceremony",
                  onPressed: store.encointer.currentPhase == CeremonyPhase.REGISTERING ?
                  () => _onSubmit() :  () => _onSubmit() // for testing always allow sending
              ),
            ]
        ),
    );
  }
}
