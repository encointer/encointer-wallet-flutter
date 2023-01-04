import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/common/components/password_input_dialog.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/src/params.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_js.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/ui.dart';
import 'package:encointer_wallet/service/notification.dart';

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
  dynamic Function(BuildContext txPageContext, Map res)? onFinish,
}) async {
  if (store.settings.cachedPin.isEmpty) {
    final unlockText = I18n.of(context)!.translationsForLocale().home.unlockAccount;
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) {
        return showPasswordInputDialog(
          context,
          store.account.currentAccount,
          Text(unlockText.replaceAll('CURRENT_ACCOUNT_NAME', store.account.currentAccount.name)),
          (String password) => store.settings.setPin(password),
        );
      },
    );
  }

  final txPaymentAsset = store.encointer.getTxPaymentAsset(store.encointer.chosenCid);

  if (txPaymentAsset != null) {
    txParams['txInfo']['txPaymentAsset'] = txPaymentAsset;
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
  final txParams = claimRewardsParams(chosenCid);

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
  final txParams = endorseNewcomerParams(chosenCid!, newbie!);

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

Future<void> submitRegisterParticipant(BuildContext context, AppStore store, Api api) async {
  // this is called inside submitTx too, but we need to unlock the key for the proof of attendance.
  if (store.settings.cachedPin.isEmpty) {
    final unlockText = I18n.of(context)!.translationsForLocale().home.unlockAccount;
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) {
        return showPasswordInputDialog(
          context,
          store.account.currentAccount,
          Text(unlockText.replaceAll('CURRENT_ACCOUNT_NAME', store.account.currentAccount.name)),
          (String password) => store.settings.setPin(password),
        );
      },
    );
  }

  return submitTx(
    context,
    store,
    api,
    registerParticipantParams(store.encointer.chosenCid!, proof: await api.encointer.getProofOfAttendance()),
    onFinish: (BuildContext txPageContext, Map res) async {
      final data = await webApi.encointer.getAggregatedAccountData(
        store.encointer.chosenCid!,
        store.account.currentAddress,
      );
      Log.d('$data', 'AggregatedAccountData from register participant');
      final registrationType = data.personal?.participantType;
      if (registrationType != null) {
        _showEducationalDialog(registrationType, context);
        if (store.settings.endpoint == networkEndpointEncointerMainnet) {
          await registerMeetupScheduleNotification(store.encointer.community!.meetupTime!, context);
        }
      }
      // Registering the participant burns the reputation.
      // Hence, we should fetch the new state afterwards.
      store.dataUpdate.setInvalidated();
    },
  );
}

Future<void> submitAttestClaims(BuildContext context, AppStore store, Api api) async {
  final params = attestAttendeesParams(
    store.encointer.chosenCid!,
    store.encointer.communityAccount!.participantCountVote!,
    store.encointer.communityAccount!.attendees!.toList(),
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
Future<dynamic> submitReapVoucher(
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
        key: const Key('educate-dialog'),
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
              onPressed: () => UI.launchURL(leuZurichCycleAssignmentFAQLink(languageCode)),
            ),
        ],
      );
    },
  );
}

Future<void> registerMeetupScheduleNotification(int meetupTime, BuildContext context) async {
  final dic = I18n.of(context)!.translationsForLocale().encointer;
  final meetupDateTime = DateTime.fromMillisecondsSinceEpoch(meetupTime);
  final beforeOneHour = tz.TZDateTime.from(meetupDateTime.subtract(const Duration(hours: 1)), tz.local);
  final beforeOneDay = tz.TZDateTime.from(meetupDateTime.subtract(const Duration(days: 1)), tz.local);
  if (beforeOneHour.isAfter(DateTime.now())) {
    await NotificationPlugin.scheduleNotification(
      1 + generateMeetupIdByTimeStamp(meetupTime),
      dic.scheduleNotificationBeforeOneHourTitle,
      dic.scheduleNotificationBeforeOneHourContent,
      beforeOneHour,
    );
  }
  if (beforeOneDay.isAfter(DateTime.now())) {
    await NotificationPlugin.scheduleNotification(
      24 + generateMeetupIdByTimeStamp(meetupTime),
      dic.scheduleNotificationBeforeOneDayTitle,
      dic.scheduleNotificationBeforeOneDayContent,
      beforeOneDay,
    );
  }
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

int generateMeetupIdByTimeStamp(int meetupTime) {
  final now = DateTime.now().millisecondsSinceEpoch;
  // 1 day = 86400000 milliseconds
  final id = ((meetupTime - now) / 86400000).ceil();
  return id + 200;
}
