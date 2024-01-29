import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/src/tx_notification.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/modules/login/logic/login_store.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/service/tx/lib/src/tx_builder.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/tuples_1.dart';
import 'package:ew_test_keys/ew_test_keys.dart';

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
  OpaqueExtrinsic xt,
  TxNotification notification, {
  dynamic Function(BuildContext txPageContext, ExtrinsicReport report)? onFinish,
  void Function(DispatchError report)? onError,
}) async {
  final pin = await context.read<LoginStore>().getPin(context);
  if (pin != null) {
    return submitTxInner(
      context,
      store,
      api,
      xt,
      notification,
      false,
      onError: onError,
      onFinish: onFinish,
    );
  }
}

Future<void> submitClaimRewards(
  BuildContext context,
  AppStore store,
  Api api,
  KeyringAccount signer,
  CommunityIdentifier chosenCid, {
  required CommunityIdentifier? txPaymentAsset,
}) async {
  // meetupIndex = null; the chain will figure out the meetup index.
  final call = api.encointer.encointerKusama.tx.encointerCeremonies.claimRewards(cid: chosenCid.toPolkadart());
  final xt = await TxBuilder(api.provider).createSignedExtrinsic(
    signer.pair,
    call,
    paymentAsset: txPaymentAsset?.toPolkadart(),
  );

  return submitTx(
    context,
    store,
    api,
    OpaqueExtrinsic(xt),
    TxNotification.claimRewards(context.l10n),
    onFinish: (BuildContext txPageContext, ExtrinsicReport report) {
      // Claiming the rewards creates a new reputation if successful.
      // Hence, we should update the state afterwards.
      store.dataUpdate.setInvalidated();
      return report;
    },
  );
}

Future<void> submitEndorseNewcomer(
  BuildContext context,
  AppStore store,
  Api api,
  KeyringAccount signer,
  CommunityIdentifier chosenCid,
  String newbie, {
  required CommunityIdentifier? txPaymentAsset,
}) async {
  final call = api.encointer.encointerKusama.tx.encointerCeremonies.endorseNewcomer(
    cid: chosenCid.toPolkadart(),
    newbie: newbie,
  );
  final xt = await TxBuilder(api.provider).createSignedExtrinsic(
    signer.pair,
    call,
    paymentAsset: txPaymentAsset?.toPolkadart(),
  );

  return submitTx(
    context,
    store,
    api,
    OpaqueExtrinsic(xt),
    TxNotification.endorseNewcomer(context.l10n),
    onFinish: (BuildContext txPageContext, ExtrinsicReport report) {
      store.encointer.account!.getNumberOfNewbieTicketsForReputable(at: report.blockHashBytes);
      store.encointer.communityAccount!.getNumberOfNewbieTicketsForBootstrapper(at: report.blockHashBytes);
    },
  );
}

Future<void> submitUnRegisterParticipant(
  BuildContext context,
  AppStore store,
  Api api,
  KeyringAccount signer,
  CommunityIdentifier chosenCid, {
  required ProofOfAttendance? lastProofOfAttendance,
  required CommunityIdentifier? txPaymentAsset,
}) async {
  final call = api.encointer.encointerKusama.tx.encointerCeremonies.unregisterParticipant(
    cid: chosenCid.toPolkadart(),
    maybeReputationCommunityCeremony: Tuple2(
      lastProofOfAttendance?.communityIdentifier.toPolkadart(),
      lastProofOfAttendance?.ceremonyIndex,
    ),
  );

  final xt = await TxBuilder(api.provider).createSignedExtrinsic(
    signer.pair,
    call,
    paymentAsset: txPaymentAsset?.toPolkadart(),
  );

  return submitTx(
    context,
    store,
    webApi,
    OpaqueExtrinsic(xt),
    TxNotification.unregisterParticipant(context.l10n),
    onFinish: (BuildContext txPageContext, ExtrinsicReport report) async {
      await Future.wait([
        webApi.encointer.getReputations(),
        webApi.encointer
            .getAggregatedAccountData(
              store.encointer.chosenCid!, store.account.currentAccountPubKey!,
              // Get data at included block to prevent race conditions with `store.chain.latestHead`.
              at: report.blockHashBytes,
            )
            .then((data) => store.encointer
                .setAggregatedAccountData(store.encointer.chosenCid!, store.account.currentAddress, data)),
      ]);
    },
  );
}

Future<void> submitRegisterParticipant(
  BuildContext context,
  AppStore store,
  Api api,
  KeyringAccount signer,
  CommunityIdentifier chosenCid, {
  required CommunityIdentifier? txPaymentAsset,
}) async {
  final proof = api.encointer.getProofOfAttendance();

  final call = api.encointer.encointerKusama.tx.encointerCeremonies.registerParticipant(
    cid: chosenCid.toPolkadart(),
    proof: proof,
  );

  final xt = await TxBuilder(api.provider).createSignedExtrinsic(
    signer.pair,
    call,
    paymentAsset: txPaymentAsset?.toPolkadart(),
  );

  return submitTx(
    context,
    store,
    api,
    OpaqueExtrinsic(xt),
    TxNotification.registerParticipant(context.l10n),
    onFinish: (BuildContext txPageContext, ExtrinsicReport report) async {
      store.encointer.account!.lastProofOfAttendance = (proof != null) ? ProofOfAttendance.fromPolkadart(proof) : null;
      final data = await webApi.encointer
          .getAggregatedAccountData(store.encointer.chosenCid!, store.account.currentAccountPubKey!,
              // Get data at included block to prevent race conditions with `store.chain.latestHead`.
              at: report.blockHashBytes);
      store.encointer.setAggregatedAccountData(store.encointer.chosenCid!, store.account.currentAddress, data);

      Log.d('$data', 'AggregatedAccountData from register participant');
      final registrationType = data.personal?.participantType;

      if (registrationType != null) {
        _showEducationalDialog(registrationType, context);
        if (store.settings.endpoint == networkEndpointEncointerMainnet) {
          await CeremonyNotifications.scheduleMeetupReminders(
            ceremonyIndex: data.global.ceremonyIndex,
            meetupTime: store.encointer.community!.meetupTime!,
            l10n: context.l10n,
            cid: store.encointer.community?.cid.toFmtString(),
          );
        }
      }

      await webApi.encointer.getReputations();
    },
  );
}

Future<void> submitAttestAttendees(
  BuildContext context,
  AppStore store,
  Api api,
  KeyringAccount signer,
  CommunityIdentifier chosenCid, {
  required CommunityIdentifier? txPaymentAsset,
}) async {
  final attestations =
      store.encointer.communityAccount!.attendees!.map((address) => Address.decode(address).pubkey).toList();

  final call = api.encointer.encointerKusama.tx.encointerCeremonies.attestAttendees(
    cid: chosenCid.toPolkadart(),
    numberOfParticipantsVote: store.encointer.communityAccount!.participantCountVote,
    attestations: attestations,
  );

  final xt = await TxBuilder(api.provider).createSignedExtrinsic(
    signer.pair,
    call,
    paymentAsset: txPaymentAsset?.toPolkadart(),
  );

  return submitTx(
    context,
    store,
    api,
    OpaqueExtrinsic(xt),
    TxNotification.attestAttendees(context.l10n),
    onFinish: (BuildContext txPageContext, ExtrinsicReport report) {
      store.encointer.communityAccount!.setMeetupCompleted();
      Navigator.popUntil(txPageContext, (route) => route.isFirst);
    },
  );
}

Future<void> submitFaucetDrip(
  BuildContext context,
  AppStore store,
  Api api,
  KeyringAccount signer,
  String faucetPubKey,
  CommunityIdentifier cid,
  int cIndex, {
  required CommunityIdentifier? txPaymentAsset,
}) async {
  final call = api.encointer.encointerKusama.tx.encointerFaucet.drip(
    faucetAccount: AddressUtils.pubKeyHexToPubKey(faucetPubKey).toList(),
    cid: cid.toPolkadart(),
    cindex: cIndex,
  );

  final xt = await TxBuilder(api.provider).createSignedExtrinsic(
    signer.pair,
    call,
    paymentAsset: txPaymentAsset?.toPolkadart(),
  );

  return submitTx(
    context,
    store,
    api,
    OpaqueExtrinsic(xt),
    TxNotification.faucetDrip(context.l10n),
  );
}

Future<Map<String, dynamic>> submitReapVoucher(
  Api api,
  String voucherUri,
  String recipientAddress,
  CommunityIdentifier cid,
) async {
  return api.js.evalJavascript('encointer.reapVoucher("$voucherUri","$recipientAddress", ${jsonEncode(cid)})');
}

void _showEducationalDialog(ParticipantType registrationType, BuildContext context) {
  final l10n = context.l10n;
  final texts = _getEducationalDialogTexts(registrationType, context);
  final languageCode = Localizations.localeOf(context).languageCode;

  showCupertinoDialog<void>(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        key: Key(EWTestKeys.educateDialogRegistrationType(registrationType.name)),
        title: Text('${texts['title']}'),
        content: Text(
          '${texts['content']}',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          if (registrationType == ParticipantType.Newbie) const SizedBox(),
          CupertinoButton(
            key: const Key(EWTestKeys.closeEducateDialog),
            child: Text(l10n.ok),
            onPressed: () => Navigator.of(context).pop(),
          ),
          if (registrationType == ParticipantType.Newbie)
            CupertinoButton(
              child: Text(
                l10n.leuZurichFAQ,
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
  final l10n = context.l10n;
  return switch (type) {
    ParticipantType.Newbie => {'title': l10n.newbieTitle, 'content': l10n.newbieContent},
    ParticipantType.Endorsee => {'title': l10n.endorseeTitle, 'content': l10n.endorseeContent},
    ParticipantType.Reputable => {'title': l10n.reputableTitle, 'content': l10n.reputableContent},
    ParticipantType.Bootstrapper => {'title': l10n.bootstrapperTitle, 'content': l10n.bootstrapperContent},
  };
}

/// Calls `encointerScheduler.nextPhase()` with Alice.
///
/// This will only work on the local dev-setup.
Future<dynamic> submitNextPhase(Api api) async {
  return api.js.evalJavascript('encointer.sendNextPhaseTx()');
}
