import 'dart:convert';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RoundedCard(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            Text("Choose shop:"),
            Observer(
              builder: (_) => (store.encointer.shopRegistry == null)
                  ? CupertinoActivityIndicator()
                  : (store.encointer.shopRegistry.isEmpty)
                      ? Text("no shops found")
                      : DropdownButton<dynamic>(
                          value: (store.encointer.shopRegistry[0]),
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 32,
                          elevation: 32,
                          onChanged: (newValue) {
                            setState(() {
                              //store.encointer.setChosenCid(newValue);
                            });
                          },
                          items: store.encointer.shopRegistry
                              .map<DropdownMenuItem<dynamic>>((value) => DropdownMenuItem<dynamic>(
                                    value: value,
                                    child: Text(Fmt.address(value)),
                                  ))
                              .toList(),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
