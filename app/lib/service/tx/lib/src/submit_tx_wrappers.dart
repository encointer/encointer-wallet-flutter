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
import 'package:ew_polkadart/generated/encointer_kusama/types/tuples.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/substrate_fixed/fixed_u128.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';

import 'package:ew_polkadart/ew_polkadart.dart' show Vote;
import 'package:ew_polkadart/ew_polkadart.dart' as pd;

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
  TxNotification? notification, {
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
      store.encointer.getEncointerBalance();
      webApi.encointer.getReputations();
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
  Address newbie, {
  required CommunityIdentifier? txPaymentAsset,
}) async {
  final call = api.encointer.encointerKusama.tx.encointerCeremonies.endorseNewcomer(
    cid: chosenCid.toPolkadart(),
    newbie: newbie.pubkey.toList(),
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
  final maybeReputationCommunityCeremony = (lastProofOfAttendance != null)
      ? Tuple2(
          lastProofOfAttendance.communityIdentifier.toPolkadart(),
          lastProofOfAttendance.ceremonyIndex,
        )
      : null;

  final call = api.encointer.encointerKusama.tx.encointerCeremonies.unregisterParticipant(
    cid: chosenCid.toPolkadart(),
    maybeReputationCommunityCeremony: maybeReputationCommunityCeremony,
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
    numberOfParticipantsVote: store.encointer.communityAccount!.participantCountVote!,
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

Future<void> submitEncointerTransfer(
  BuildContext context,
  AppStore store,
  Api api,
  KeyringAccount signer,
  CommunityIdentifier cid,
  Address recipientAddress,
  double amount, {
  required CommunityIdentifier? txPaymentAsset,
  dynamic Function(BuildContext txPageContext, ExtrinsicReport report)? onFinish,
  void Function(DispatchError report)? onError,
}) async {
  final call = api.encointer.encointerKusama.tx.encointerBalances.transfer(
    dest: recipientAddress.pubkey,
    communityId: cid.toPolkadart(),
    amount: FixedU128(bits: u64F64Util.toFixed(amount)),
  );
  final xt = await TxBuilder(api.provider).createSignedExtrinsic(
    signer.pair,
    call,
    paymentAsset: txPaymentAsset?.toPolkadart(),
  );

  await submitTx(
    context,
    context.read<AppStore>(),
    api,
    OpaqueExtrinsic(xt),
    TxNotification.encointerBalanceTransfer(context.l10n),
    onFinish: (BuildContext txPageContext, ExtrinsicReport report) {
      if (onFinish != null) onFinish(txPageContext, report);
      store.encointer.getEncointerBalance();
      return report;
    },
    onError: onError,
  );
}

/// Calls `encointerScheduler.nextPhase()` with Alice.
///
/// This will only work on the local dev-setup.
Future<dynamic> submitNextPhaseWithAlice(BuildContext context, AppStore store, Api api) async {
  // This is valid for the encointer-node dev chain config.
  // We currently don't have access to the dev nodes metadata
  // so we hardcode the call.
  const sudoNextPhaseCall = '0x05003c00';
  final alice = await KeyringAccount.fromUri('Alice', '//Alice');

  final xt = await TxBuilder(api.provider).createSignedExtrinsicWithEncodedCall(
    alice.pair,
    sudoNextPhaseCall,
  );

  try {
    await EWAuthorApi(api.provider).submitAndWatchExtrinsicWithReport(OpaqueExtrinsic(xt));
    // this is actually unexpected, see exception case below.
    return 'successfully called next phase';
  } catch (e) {
    // this will always throw an exception with the current implementation
    // because we use the kusama metadata, which does not know the sudo
    // pallet.
    Log.p('sudo.nextPhase() threw an exception, decoding error is expected though: $e');
    return "called next phase, but can't evaluate result";
  }
}

Future<void> submitEncointerTransferAll(
  BuildContext context,
  AppStore store,
  Api api,
  KeyringAccount signer,
  Address recipientAddress,
  CommunityIdentifier cid, {
  required CommunityIdentifier? txPaymentAsset,
  TxNotification? notification,
  dynamic Function(BuildContext txPageContext, ExtrinsicReport report)? onFinish,
  void Function(DispatchError report)? onError,
}) async {
  final call = api.encointer.encointerKusama.tx.encointerBalances.transferAll(
    dest: recipientAddress.pubkey,
    cid: cid.toPolkadart(),
  );
  final xt = await TxBuilder(api.provider).createSignedExtrinsic(
    signer.pair,
    call,
    paymentAsset: txPaymentAsset?.toPolkadart(),
  );

  return submitTx(
    context,
    context.read<AppStore>(),
    api,
    OpaqueExtrinsic(xt),
    notification,
    onFinish: onFinish,
    onError: onError,
  );
}

typedef ReputationTuple = Tuple2<pd.CommunityIdentifier, int>;
typedef Reputations = List<ReputationTuple>;

Future<void> submitDemocracyVote(
    BuildContext context,
    AppStore store,
    Api api,
    KeyringAccount signer,
    BigInt proposalId,
    Vote vote,
    Reputations reputations, {
      required CommunityIdentifier? txPaymentAsset,
    }) async {
  final call = api.encointer.encointerKusama.tx.encointerDemocracy.vote(
    proposalId: proposalId,
    vote: vote,
    reputations: reputations,
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
