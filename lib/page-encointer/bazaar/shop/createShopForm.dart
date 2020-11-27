import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import 'package:encointer_wallet/common/components/AddressInputField.dart';
import 'package:encointer_wallet/common/components/currencyWithIcon.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/common/consts/settings.dart';
import 'package:encointer_wallet/page/account/scanPage.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/page/assets/asset/assetPage.dart';
import 'package:encointer_wallet/page/assets/transfer/currencySelectPage.dart';
import 'package:encointer_wallet/page/assets/transfer/transferCrossChainPage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CreateShopForm extends StatefulWidget {
  CreateShopForm(this.store);

  final AppStore store;
  static final String route = '/encointer/bazaar/createShopForm';

  @override
  _CreateShopForm createState() => _CreateShopForm(store);
}

class _CreateShopForm extends State<CreateShopForm> {
  _CreateShopForm(this.store);
  // CreateShopForm({this.setNewShop, this.submitting, this.onSubmit});

  final AppStore store;
  static final String route = '/encointer/bazaar/createShopForm';

  /*
  final Function setNewShop;
  final Function onSubmit;
  final bool submitting;*/

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _urlCtrl = new TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      int decimals = store.settings.networkState.tokenDecimals;
      var args = {
        "title": 'new_store',
        "txInfo": {
          "module": 'encointerBazaar',
          "call": 'newStore',
        },
        "detail": jsonEncode({
          "cid": store.encointer.chosenCid,
          "url": _urlCtrl.text.trim(),
        }),
        "params": [
          store.encointer.chosenCid,
          Fmt.tokenInt(_urlCtrl.text.trim(), decimals).toString(),
        ],
        'onFinish': (BuildContext txPageContext, Map res) {
          Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
        }
      };
      Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dic = I18n.of(context).bazaar;

    // TODO: Input fields for description, location usw., convert to json, upload and copy URL to blockchain.
    // TODO: IPFS
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: <Widget>[
                TextFormField(
                  // URL
                  decoration: InputDecoration(
                    icon: Icon(Icons.cake),
                    hintText: dic['shop.url'],
                    labelText: "${dic['shop.url']}: ${dic['shop.url']}",
                  ),
                  controller: _urlCtrl,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: RoundedButton(
              text: I18n.of(context).bazaar['shop.create'],
              onPressed: () {
                _submit();
              },
            ),
          ),
        ],
      ),
    );
  }
}
