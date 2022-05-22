import 'dart:convert';

import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/proofOfAttendance.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Helpers to send transactions.
///
/// Refactor when the issue 'remove tx confirm page' is tackled.

Future<void> submitTx(BuildContext context, AppStore store, Api api, Function(CommunityIdentifier) submitFn) async {
  if (store.settings.cachedPin.isEmpty) {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return showPasswordInputDialog(
            context,
            store.account.currentAccount,
            Text(I18n.of(context)
                .translationsForLocale()
                .home
                .unlockAccount
                .replaceAll('CURRENT_ACCOUNT_NAME', store.account.currentAccount.name.toString())), (password) {
          store.settings.setPin(password);
        });
      },
    );
  }

  final txPaymentAsset = store.encointer.getTxPaymentAsset(store.encointer.chosenCid);

  return submitFn(txPaymentAsset);
}

Future<void> submitClaimRewards(
  BuildContext context,
  CommunityIdentifier chosenCid, {
  CommunityIdentifier txPaymentAsset,
}) async {
  var args = {
    "title": 'claim_rewards',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'claimRewards',
      "cid": chosenCid,
      "txPaymentAsset": txPaymentAsset,
    },
    "detail": "cid: ${chosenCid.toFmtString()}",
    "params": [chosenCid],
    'onFinish': (BuildContext txPageContext, Map res) {
      Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
    }
  };
  Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
}

Future<void> submitEndorseNewcomer(
  BuildContext context,
  CommunityIdentifier chosenCid,
  String newbie, {
  CommunityIdentifier txPaymentAsset,
}) async {
  var args = {
    "title": 'endorse_newcomer',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'endorseNewcomer',
      "cid": chosenCid,
      "txPaymentAsset": txPaymentAsset,
    },
    "detail": "cid: ${chosenCid.toFmtString()}, newbie: $newbie",
    "params": [chosenCid, newbie],
    'onFinish': (BuildContext txPageContext, Map res) {
      Navigator.pop(txPageContext);
    }
  };
  Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
}

Future<void> submitRegisterParticipant(
  BuildContext context,
  Api api,
  CommunityIdentifier chosenCid, {
  CommunityIdentifier txPaymentAsset,
  Future<ProofOfAttendance> proof,
  Function(BuildContext txPageContext, Map res) onFinish,
}) async {
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
      "txPaymentAsset": txPaymentAsset,
    },
    "detail": jsonEncode({
      "cid": chosenCid.toFmtString(),
      "proof": p == null
          ? "No proof of past attendance found" // Note: hardcoded strings are ok here, the page  will be removed.
          : "Sending proof for cIndex: ${p.ceremonyIndex}, community: ${p.communityIdentifier.toFmtString()}",
    }),
    "params": [
      chosenCid,
      p,
    ],
    'onFinish': onFinish
  };
  Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
}
