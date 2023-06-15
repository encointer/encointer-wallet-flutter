import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/l10n/l10.dart';

/// Params for known extrinsics.

Map<String, dynamic> endorseNewcomerParams(CommunityIdentifier chosenCid, String newbie, AppLocalizations l10n) {
  return {
    'title': 'endorse_newcomer',
    'txInfo': {
      'module': 'encointerCeremonies',
      'call': 'endorseNewcomer',
      'cid': chosenCid,
      'notificationTitle': l10n.endorseNewcomerNotificationTitle,
      'notificationBody': l10n.endorseNewcomerNotificationBody,
    },
    'params': [chosenCid, newbie],
  };
}

Map<String, dynamic> registerParticipantParams(CommunityIdentifier chosenCid, AppLocalizations l10n,
    {ProofOfAttendance? proof}) {
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
    CommunityIdentifier cid, ProofOfAttendance? proof, AppLocalizations l10n) {
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
