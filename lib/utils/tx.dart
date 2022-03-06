
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter/material.dart';

Future<void> submitClaimRewards(BuildContext context, CommunityIdentifier chosenCid) async {
  var args = {
    "title": 'claim_rewards',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'claimRewards',
      "cid": chosenCid,
    },
    "detail": "cid: ${chosenCid.toFmtString()}",
    "params": [chosenCid],
    'onFinish': (BuildContext txPageContext, Map res) {
      Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
    }
  };
  Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
}