import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/page-encointer/common/currencyChooserPanel.dart';
import 'package:polka_wallet/page-encointer/phases/assigning/assigningPage.dart';
import 'package:polka_wallet/page-encointer/phases/attesting/attestingPage.dart';
import 'package:polka_wallet/page-encointer/phases/registering/registeringPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/encointerTypes.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

class EncointerEntry extends StatelessWidget {
  EncointerEntry(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;
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
                    dic['encointer'] ?? 'Encointer Ceremony',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            //Expanded(
            //    child: Observer(
            //        builder: (_) =>
            //            Text(store.encointer.currentPhase.toString()))),
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

class _PhaseAwareBoxState extends State<PhaseAwareBox> with SingleTickerProviderStateMixin {
  _PhaseAwareBoxState(this.store);

  final AppStore store;




  TabController _tabController;
  int _txsPage = 0;
  bool _isLastPage = false;
  ScrollController _scrollController;

  Future<void> _updateData() async {
    String pubKey = store.account.currentAccount.pubKey;
    await webApi.assets.fetchBalance();
  }

  Future<void> _refreshData() async {
    setState(() {
      _txsPage = 0;
      _isLastPage = false;
    });
    await _updateData();
  }

  @override
  void initState() {
    super.initState();
    webApi.encointer.getCurrencyIdentifiers();
  }

  @override
  void dispose() {
    print("stopping subscriptions and closing webview");
    webApi.encointer.stopSubscriptions();
    webApi.closeWebView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CeremonyPhase>(
        future: webApi.encointer.getCurrentPhase(),
        builder: (BuildContext context, AsyncSnapshot<CeremonyPhase> snapshot) {
          if (snapshot.hasData) {
            return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              CurrencyChooserPanel(store),
              //CeremonyOverviewPanel(store),
              Observer(builder: (_) => _getPhaseView(store.encointer.currentPhase))
            ]);
          } else {
            return CupertinoActivityIndicator();
          }
        });
  }

  Widget _getPhaseView(CeremonyPhase phase) {
    //return RegisteringPage(store);
    //return AssigningPage(store);
    //return AttestingPage(store);
    switch (phase) {
      case CeremonyPhase.REGISTERING:
        return RegisteringPage(store);
      case CeremonyPhase.ASSIGNING:
        return AssigningPage(store);
      case CeremonyPhase.ATTESTING:
        return AttestingPage(store);
    }
  }
}
