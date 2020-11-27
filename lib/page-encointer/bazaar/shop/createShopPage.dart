import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/page-encointer/homePage.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shop/createShopForm.dart';
import 'package:encointer_wallet/page-encointer/common/currencyChooserPanel.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:encointer_wallet/page-encointer/bazaar/components/shopClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CreateShopPage extends StatefulWidget {
  const CreateShopPage(this.store);

  static final String route = '/encointer/bazaar/createShopPage';
  final AppStore store;

  @override
  _CreateShopPageState createState() => _CreateShopPageState(store);
}

class _CreateShopPageState extends State<CreateShopPage> {
  _CreateShopPageState(this.store);
  final AppStore store;

  bool _submitting = false;

  TextEditingController nameController = TextEditingController();
/*
  void addItemToList() {
    setState(() {});
  }

  Future<void> _createShop() async {
    setState(() {
      _submitting = true;
    });*/

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).bazaar;

    return Scaffold(
      appBar: AppBar(title: Text(dic['shop.create'])),
      body: SafeArea(
       // child: !_submitting
         //   ?
        child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    CurrencyChooserPanel(store),
                    SizedBox(
                      height: 16,
                    ),
                    CreateShopForm(store),
                      /*setNewShop: store.encointer.setNewShop,
                      submitting: _submitting,
                      onSubmit: () {
                        setState(() {
                          _createShop();
                        });
                      },*/
                        )
                  ]),
                ),
              ])
           // : Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
