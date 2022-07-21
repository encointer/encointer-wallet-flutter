import 'dart:convert';

import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';

import 'params.dart';
import 'submitToJS.dart';

/// Helpers to submit transactions.

/// Submit tx to the chain.
///
/// Asks for the pin input if it's not cached and submits the tx via the JS interface.
///
/// This function is intended to be the universal interface for sending transactions.
Future<void> submitTx(
  BuildContext context,
  AppStore store,
  Api api,
  Map txParams, {
  Function(BuildContext txPageContext, Map res)? onFinish,
}) async {
  if (store.settings.cachedPin.isEmpty) {
    var unlockText = I18n.of(context)!.translationsForLocale().home.unlockAccount;
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
  txParams["onFinish"] = onFinish ?? ((BuildContext txPageContext, Map res) => res);

  return submitToJS(
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
  AppStore store,
  Api api,
  CommunityIdentifier? chosenCid,
) async {
  var txParams = claimRewardsParams(chosenCid);

  return submitTx(
    context,
    store,
    api,
    txParams,
    onFinish: (BuildContext txPageContext, Map res) => (res),
  );
}

Future<void> submitEndorseNewcomer(
  BuildContext context,
  AppStore store,
  Api api,
  CommunityIdentifier? chosenCid,
  String? newbie,
) async {
  var txParams = endorseNewcomerParams(chosenCid, newbie);

  return submitTx(
    context,
    store,
    api,
    txParams,
    onFinish: (BuildContext txPageContext, Map res) => (res),
  );
}

Future<void> submitRegisterParticipant(BuildContext context, AppStore store, Api api) async {
  // this is called inside submitTx too, but we need to unlock the key for the proof of attendance.
  if (store.settings.cachedPin.isEmpty) {
    var unlockText = I18n.of(context)!.translationsForLocale().home.unlockAccount;
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
    store.encointer.chosenCid,
    store.encointer.communityAccount!.scannedClaimsCount,
    store.encointer.communityAccount!.participantsClaims!.values.toList(),
  );

  return submitTx(
    context,
    store,
    api,
    params,
    onFinish: (BuildContext txPageContext, Map res) {
      store.encointer.communityAccount!.setMeetupCompleted();
      Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
    },
  );
}

// todo: replace this with `encointerBalances.transfer_all`, when we have it in the runtime.
Future<dynamic> submitReapVoucher(
  Api api,
  String voucherUri,
  String recipientAddress,
  CommunityIdentifier cid,
) async {
  return api.js.evalJavascript('encointer.reapVoucher("$voucherUri","$recipientAddress", ${jsonEncode(cid)})');
}
