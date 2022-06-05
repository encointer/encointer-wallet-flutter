import 'dart:convert';

import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/page/account/txConfirmLogic.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/proofOfAttendance.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Helpers to send transactions.
///
/// Refactor when we tackle: https://github.com/encointer/encointer-wallet-flutter/issues/335
///
/// A builder pattern would probably be nice here.

Future<void> submitTx(
  BuildContext context,
  AppStore store,
  Api api,
  Map txParams, {
  Function(BuildContext txPageContext, Map res) onFinish,
}) async {
  if (store.settings.cachedPin.isEmpty) {
    var unlockText = I18n.of(context).translationsForLocale().home.unlockAccount;
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return showPasswordInputDialog(
          context,
          store.account.currentAccount,
          Text(unlockText.replaceAll('CURRENT_ACCOUNT_NAME', store.account.currentAccount.name)),
          (password) => store.settings.setPin(password),
        );
      },
    );
  }

  final txPaymentAsset = store.encointer.getTxPaymentAsset(store.encointer.chosenCid);

  txParams["txInfo"]["txPaymentAsset"] = txPaymentAsset;
  txParams["onFinish"] = onFinish ??
      (BuildContext txPageContext, Map res) => res;

  return onSubmit(
    context,
    store,
    api,
    false,
    txParams: txParams,
    password: store.settings.cachedPin,
  );
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

Map<String, dynamic> registerParticipantParams(
  CommunityIdentifier chosenCid, {
  ProofOfAttendance proof,
}) {
  return {
    "title": 'register_participant',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'registerParticipant',
      "cid": chosenCid,
    },
    "detail": jsonEncode({
      "cid": chosenCid.toFmtString(),
      "proof": proof == null
          ? "No proof of past attendance found" // Note: hardcoded strings are ok here, the page  will be removed.
          : "Sending proof for cIndex: ${proof.ceremonyIndex}, community: ${proof.communityIdentifier.toFmtString()}",
    }),
    "params": [
      chosenCid,
      proof,
    ],
  };
}

Map<String, dynamic> attestClaimsParams(
  BuildContext context,
  CommunityIdentifier chosenCid,
  int scannedClaimsCount,
  List<ClaimOfAttendance> claims,
) {
  final dic = I18n.of(context).translationsForLocale();
  return {
    "title": 'attest_claims',
    "txInfo": {
      "module": 'encointerCeremonies',
      "call": 'attestClaims',
      "cid": chosenCid,
    },
    "detail": dic.encointer.claimsSubmitDetail.replaceAll('AMOUNT', scannedClaimsCount.toString()),
    "params": [claims],
  };
}

Map<String, dynamic> encointerBalanceTransferParams(
  CommunityIdentifier cid,
  String recipientAddress,
  double amount,
) {
  return {
    "title": 'encointerBalancesTransfer',
    "txInfo": {
      "module": 'encointerBalances',
      "call": 'transfer',
      "cid": cid,
    },
    "params": [
      recipientAddress,
      cid.toFmtString(),
      amount.toString(),
    ],
  };
}

Future<void> submitRegisterParticipant(BuildContext context, AppStore store, Api api) async {
  // this is called inside submitTx too, but we need to unlock the key for the proof of attendance.
  if (store.settings.cachedPin.isEmpty) {
    var unlockText = I18n.of(context).translationsForLocale().home.unlockAccount;
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return showPasswordInputDialog(
          context,
          store.account.currentAccount,
          Text(unlockText.replaceAll('CURRENT_ACCOUNT_NAME', store.account.currentAccount.name)),
          (password) => store.settings.setPin(password),
        );
      },
    );
  }

  return submitTx(
    context,
    store,
    api,
    registerParticipantParams(store.encointer.chosenCid, proof: await api.encointer.getProofOfAttendance()),
    onFinish: (BuildContext txPageContext, Map res) {
      store.encointer.updateAggregatedAccountData();
      Navigator.popUntil(
        txPageContext,
        ModalRoute.withName('/'),
      );
    },
  );
}

Future<void> submitAttestClaims(BuildContext context, AppStore store, Api api) async {
  final params = attestClaimsParams(
    context,
    store.encointer.chosenCid,
    store.encointer.communityAccount.scannedClaimsCount,
    store.encointer.communityAccount.participantsClaims.values.toList(),
  );

  return submitTx(
    context,
    store,
    api,
    params,
    onFinish: (BuildContext txPageContext, Map res) {
      store.encointer.communityAccount.setMeetupCompleted();
      Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
    },
  );
}
