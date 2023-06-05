import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/src/params.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_js.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';

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
  Map<String, dynamic> txParams, {
  dynamic Function(BuildContext txPageContext, Map res)? onFinish,
}) async {
  final txPaymentAsset = store.encointer.getTxPaymentAsset(store.encointer.chosenCid);

  if (txPaymentAsset != null) {
    (txParams['txInfo'] as Map<String, dynamic>)['txPaymentAsset'] = txPaymentAsset;
  }

  txParams['onFinish'] = onFinish ?? ((BuildContext txPageContext, Map res) => res);

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
  CommunityIdentifier chosenCid,
) async {
  final dic = I18n.of(context)!.translationsForLocale();
  final txParams = claimRewardsParams(chosenCid, dic);

  return submitTx(
    context,
    store,
    api,
    txParams,
    onFinish: (BuildContext txPageContext, Map res) {
      // Claiming the rewards creates a new reputation if successful.
      // Hence, we should update the state afterwards.
      store.dataUpdate.setInvalidated();
      return res;
    },
  );
}

Future<void> submitEndorseNewcomer(
  BuildContext context,
  AppStore store,
  Api api,
  CommunityIdentifier? chosenCid,
  String? newbie,
) async {
  final dic = I18n.of(context)!.translationsForLocale();
  final txParams = endorseNewcomerParams(chosenCid!, newbie!, dic);

  return submitTx(
    context,
    store,
    api,
    txParams,
    onFinish: (BuildContext txPageContext, Map res) {
      store.encointer.account!.getNumberOfNewbieTicketsForReputable();
      store.encointer.communityAccount!.getNumberOfNewbieTicketsForBootstrapper();
    },
  );
}

Future<void> submitUnRegisterParticipant(BuildContext context, AppStore store, Api api) {
  final dic = I18n.of(context)!.translationsForLocale();

  final lastProofOfAttendance = store.encointer.communityAccount?.participantType?.isReputable ?? false
      ? store.encointer.account
          ?.lastProofOfAttendance // can still be null if the participant did not register on the same phone.
      : null;

  return submitTx(
    context,
    store,
    webApi,
    unregisterParticipantParams(store.encointer.chosenCid!, lastProofOfAttendance, dic),
    onFinish: (txPageContext, res) => store.dataUpdate.setInvalidated(),
  );
}

Future<void> submitRegisterParticipant(BuildContext context, AppStore store, Api api) async {
  // this is called inside submitTx too, but we need to unlock the key for the proof of attendance.
  final dic = I18n.of(context)!.translationsForLocale();
  final proof = await api.encointer.getProofOfAttendance();

  return submitTx(
    context,
    store,
    api,
    registerParticipantParams(store.encointer.chosenCid!, dic, proof: proof),
    onFinish: (BuildContext txPageContext, Map res) async {
      store.encointer.account!.lastProofOfAttendance = proof;
      final data = await webApi.encointer.getAggregatedAccountData(
        store.encointer.chosenCid!,
        store.account.currentAccountPubKey!,
      );
      Log.d('$data', 'AggregatedAccountData from register participant');
      final registrationType = data.personal?.participantType;

      if (registrationType != null) {
        _showEducationalDialog(registrationType, context);
        if (store.settings.endpoint == networkEndpointEncointerMainnet) {
          await CeremonyNotifications.scheduleMeetupReminders(
            ceremonyIndex: data.global.ceremonyIndex,
            meetupTime: store.encointer.community!.meetupTime!,
            dic: I18n.of(context)!.translationsForLocale().encointer,
            cid: store.encointer.community?.cid.toFmtString(),
          );
        }
      }
      // Registering the participant burns the reputation.
      // Hence, we should fetch the new state afterwards.
      store.dataUpdate.setInvalidated();
    },
  );
}

Future<void> submitAttestClaims(BuildContext context, AppStore store, Api api) async {
  final dic = I18n.of(context)!.translationsForLocale();
  final params = attestAttendeesParams(
    store.encointer.chosenCid!,
    store.encointer.communityAccount!.participantCountVote!,
    store.encointer.communityAccount!.attendees!.toList(),
    dic,
  );

  return submitTx(
    context,
    store,
    api,
    params,
    onFinish: (BuildContext txPageContext, Map res) {
      store.encointer.communityAccount!.setMeetupCompleted();
      Navigator.popUntil(txPageContext, (route) => route.isFirst);
    },
  );
}

// todo: replace this with `encointerBalances.transfer_all`, when we have it in the runtime.
Future<Map<String, dynamic>> submitReapVoucher(
  Api api,
  String voucherUri,
  String recipientAddress,
  CommunityIdentifier cid,
) async {
  return api.js.evalJavascript('encointer.reapVoucher("$voucherUri","$recipientAddress", ${jsonEncode(cid)})');
}

void _showEducationalDialog(ParticipantType registrationType, BuildContext context) {
  final dic = I18n.of(context)!.translationsForLocale();
  final texts = _getEducationalDialogTexts(registrationType, context);
  final languageCode = Localizations.localeOf(context).languageCode;

  showCupertinoDialog<void>(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        key: Key('educate-dialog-${registrationType.name}'),
        title: Text('${texts['title']}'),
        content: Text(
          '${texts['content']}',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          if (registrationType == ParticipantType.Newbie) const SizedBox(),
          CupertinoButton(
            key: const Key('close-educate-dialog'),
            child: Text(dic.home.ok),
            onPressed: () => Navigator.of(context).pop(),
          ),
          if (registrationType == ParticipantType.Newbie)
            CupertinoButton(
              child: Text(
                dic.encointer.leuZurichFAQ,
                textAlign: TextAlign.center,
              ),
              onPressed: () => AppLaunch.launchURL(leuZurichCycleAssignmentFAQLink(languageCode)),
            ),
        ],
      );
    },
  );
}

Map<String, String> _getEducationalDialogTexts(ParticipantType type, BuildContext context) {
  final dic = I18n.of(context)!.translationsForLocale().encointer;
  switch (type) {
    case ParticipantType.Newbie:
      return {'title': dic.newbieTitle, 'content': dic.newbieContent};
    case ParticipantType.Endorsee:
      return {'title': dic.endorseeTitle, 'content': dic.endorseeContent};
    case ParticipantType.Reputable:
      return {'title': dic.reputableTitle, 'content': dic.reputableContent};
    case ParticipantType.Bootstrapper:
      return {'title': dic.bootstrapperTitle, 'content': dic.bootstrapperContent};
  }
}

/// Calls `encointerScheduler.nextPhase()` with Alice.
///
/// This will only work on the local dev-setup.
Future<dynamic> submitNextPhase(Api api) async {
  return api.js.evalJavascript('encointer.sendNextPhaseTx()');
}
