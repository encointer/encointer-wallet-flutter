import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/cupertino.dart';

/// Notification messages for used extrinsics

@immutable
class TxNotification {
  const TxNotification({required this.title, required this.body});

  factory TxNotification.attestAttendees(AppLocalizations l10n) => TxNotification(
        title: l10n.attestNotificationTitle,
        body: l10n.attestNotificationBody,
      );

  factory TxNotification.claimRewards(AppLocalizations l10n) => TxNotification(
        title: l10n.claimRewardsNotificationTitle,
        body: l10n.claimRewardsNotificationBody,
      );

  factory TxNotification.encointerBalanceTransfer(AppLocalizations l10n) => TxNotification(
        title: l10n.balanceTransferNotificationTitle,
        body: l10n.balanceTransferNotificationBody,
      );

  factory TxNotification.endorseNewcomer(AppLocalizations l10n) => TxNotification(
        title: l10n.endorseNewcomerNotificationTitle,
        body: l10n.endorseNewcomerNotificationBody,
      );

  factory TxNotification.faucetDrip(AppLocalizations l10n) => TxNotification(
        title: l10n.submittedFaucetDripTitle,
        body: l10n.submittedFaucetDripBody,
      );

  factory TxNotification.registerParticipant(AppLocalizations l10n) => TxNotification(
        title: l10n.registerParticipantNotificationTitle,
        body: l10n.registerParticipantNotificationBody,
      );

  factory TxNotification.unregisterParticipant(AppLocalizations l10n) => TxNotification(
        title: l10n.unregisterParticipantNotificationTitle,
        body: l10n.unregisterParticipantNotificationBody,
      );

  final String title;
  final String body;
}
