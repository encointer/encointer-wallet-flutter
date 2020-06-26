import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/components/infoItem.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/page-encointer/common/CeremonyOverviewPanel.dart';
import 'package:polka_wallet/page/account/txConfirmPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/utils/UI.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

class AssigningPage extends StatefulWidget {
  AssigningPage(this.store);

  static const String route = '/encointer/assigning';
  final AppStore store;

  @override
  _AssigningPageState createState() => _AssigningPageState(store);


}

class _AssigningPageState extends State<AssigningPage> {
  _AssigningPageState(this.store);

  final AppStore store;

  String _tab = 'DOT';

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  Future<void> _refreshData() async {
    await webApi.encointer.fetchParticipantIndex();
    await webApi.encointer.fetchParticipantCount();
    await webApi.encointer.fetchMeetupIndex();
    await webApi.encointer.fetchNextMeetupTime();
    await webApi.encointer.fetchNextMeetupLocation();
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;
    final int decimals = encointer_token_decimals;
    return SafeArea(
      child: Column(
          children: <Widget>[
            CeremonyOverviewPanel(store),
          ]
      ),
    );
  }

}


