import 'package:encointer_wallet/page-encointer/common/currencyChooserPanel.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shop/shopOverviewPanel.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/encointerTypes.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
/*
class ShopOverviewPage extends StatefulWidget {
  ShopOverviewPage(this.store);

  static const String route = '/encointer/bazaar/shopOverviewPage';
  final AppStore store;

  @override
  _ShopOverviewPageState createState() => _ShopOverviewPageState(store);
}

class _ShopOverviewPageState extends State<ShopOverviewPage> {
  _ShopOverviewPageState(this.store);*/

class ShopOverviewPage extends StatelessWidget {
  ShopOverviewPage(this.store);

  static const String route = '/encointer/bazaar/shopOverviewPage';

  final AppStore store;

  String _tab = 'DOT';

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).bazaar;

    return Scaffold(
      appBar: AppBar(
        title: Text(dic['shops']),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Column(children: <Widget>[
          ShopObserver(store)
          //ShopOverviewPanel(store),
        ]),
      ),
    );
  }
}

class ShopObserver extends StatefulWidget {
  ShopObserver(this.store);

  static final String route = '/encointer/bazaar/shopObserver';

  final AppStore store;

  @override
  _ShopObserverState createState() => _ShopObserverState(store);
}

class _ShopObserverState extends State<ShopObserver> with SingleTickerProviderStateMixin {
  _ShopObserverState(this.store);

  final AppStore store;
  bool appConnected = false;

  @override
  void initState() {
    _checkConnectionState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _checkConnectionState() async {
    appConnected = await webApi.isConnected();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              CurrencyChooserPanel(store),
              SizedBox(
                height: 16,
              ),
              //appConnected ? _getShopView(store.encointer.currentPhase) : _getShopViewOffline(),
              _getShopView(),
            ])
          ],
        ),
      ),
    );
  }

  Widget _getShopView() {
    return SafeArea(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: ShopOverviewPanel(store),
        ),
      ]),
    );
  }

  Widget _getShopViewOffline() {
    return SafeArea(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: ShopOverviewPanel(store),
        ),
      ]),
    );
  }
}
