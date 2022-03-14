import 'dart:convert';

import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/proofOfAttendance.dart';
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

Future<void> submitEndorseNewcomer(BuildContext context, CommunityIdentifier chosenCid, String newbie) async {
  var args = {
    "title": 'endorse_newcomer',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'endorseNewcomer',
      "cid": chosenCid,
    },
    "detail": "cid: ${chosenCid.toFmtString()}, newbie: $newbie",
    "params": [chosenCid, newbie],
    'onFinish': (BuildContext txPageContext, Map res) {
      Navigator.pop(txPageContext);
    }
  };
  Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
}

Future<void> submitRegisterParticipant(BuildContext context, Api api, CommunityIdentifier chosenCid,
    {Future<ProofOfAttendance> proof}) async {
  ProofOfAttendance p;
  if (proof != null) {
    p = await proof;
  }

  var args = {
    "title": 'register_participant',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'registerParticipant',
      "cid": chosenCid,
    },
    "detail": jsonEncode({
      "cid": chosenCid.toFmtString(),
      "proof for ceremonyIndex": p == null
          ? "No proof for past attendance" // Note: hardcoded strings are ok here, the page  will be removed.
          : "Sending proof for cIndex: ${p.ceremonyIndex}, community: ${p.communityIdentifier.toFmtString()}",
    }),
    "params": [
      chosenCid,
      p,
    ],
    'onFinish': (BuildContext txPageContext, Map res) {
      api.encointer.getParticipantIndex();
      Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
    }
  };
  Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
}
