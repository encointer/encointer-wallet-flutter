import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class MeetupPage extends StatefulWidget {
  MeetupPage(this.store);

  static const String route = '/encointer/attesting/';
  final AppStore store;

  @override
  _MeetupPageState createState() => _MeetupPageState(store);
}

class _MeetupPageState extends State<MeetupPage> {
  _MeetupPageState(this.store);

  final AppStore store;

  @override
  void initState() {
    super.initState();
  }

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
                  child: new TextField(
                    decoration: new InputDecoration(labelText: "Enter the amount of participants number"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ),
              ]
          ),
        )
    );
  }
}


