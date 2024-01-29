import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/cupertino.dart';

/// Params for known extrinsics.

@immutable
class TxNotificationData {
  const TxNotificationData({required this.title, required this.body});

  factory TxNotificationData.endorseNewcomer(AppLocalizations l10n) => TxNotificationData(title: l10n.endorseNewcomerNotificationTitle, body: l10n.endorseNewcomerNotificationBody);

  final String title;
  final String body;
}

Map<String, dynamic> registerParticipantParams(
  CommunityIdentifier chosenCid,
  AppLocalizations l10n, {
  ProofOfAttendance? proof,
}) {
  return {
    'title': 'register_participant',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'registerParticipant',
      'cid': chosenCid,
      'notificationTitle': l10n.registerParticipantNotificationTitle,
      'notificationBody': l10n.registerParticipantNotificationBody,
    },
    'params': [
      chosenCid,
      proof,
    ],
  };
}

Map<String, dynamic> attestAttendeesParams(
  CommunityIdentifier chosenCid,
  int numberOfParticipantsVote,
  List<String> attendees,
  AppLocalizations l10n,
) {
  return {
    'title': 'attest_claims',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'attestAttendees',
      'cid': chosenCid,
      'notificationTitle': l10n.attestNotificationTitle,
      'notificationBody': l10n.attestNotificationBody,
    },
    'params': [chosenCid, numberOfParticipantsVote, attendees],
  };
}

Map<String, dynamic> claimRewardsParams(CommunityIdentifier chosenCid, AppLocalizations l10n) {
  return {
    'title': 'claim_rewards',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'claimRewards',
      'cid': chosenCid,
      'notificationTitle': l10n.claimRewardsNotificationTitle,
      'notificationBody': l10n.claimRewardsNotificationBody,
    },
    // meetupIndex == null. The chain will figure out our index.
    'params': [chosenCid, null],
  };
}

Map<String, dynamic> encointerBalanceTransferParams(
  CommunityIdentifier cid,
  String recipientAddress,
  double? amount,
  AppLocalizations l10n,
) {
  return {
    'title': 'encointerBalancesTransfer',
    'txInfo': {
      'module': 'encointerBalances',
      'call': 'transfer',
      'cid': cid,
      'notificationTitle': l10n.balanceTransferNotificationTitle,
      'notificationBody': l10n.balanceTransferNotificationBody,
    },
    'params': [
      recipientAddress,
      cid,
      amount.toString(),
    ],
  };
}

Map<String, dynamic> unregisterParticipantParams(
  CommunityIdentifier cid,
  ProofOfAttendance? proof,
  AppLocalizations l10n,
) {
  final communityCeremony = [proof?.communityIdentifier, proof?.ceremonyIndex];

  return {
    'title': 'encointerUnregisterParticipant',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'unregisterParticipant',
      'cid': cid,
      'notificationTitle': l10n.unregisterParticipantNotificationTitle,
      'notificationBody': l10n.unregisterParticipantNotificationBody,
    },
    'params': [cid, communityCeremony],
  };
}

Map<String, dynamic> faucetDripParams(
  String faucetAccount,
  CommunityIdentifier cid,
  int cIndex,
  AppLocalizations l10n,
) {
  return {
    'title': 'encointerUnregisterParticipant',
    'txInfo': {
      'module': 'encointerFaucet',
      'call': 'drip',
      'cid': cid,
      'notificationTitle': l10n.submittedFaucetDripTitle,
      'notificationBody': l10n.submittedFaucetDripBody,
    },
    'params': [faucetAccount, cid, cIndex],
  };
}
