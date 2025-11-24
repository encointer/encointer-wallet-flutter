import 'dart:core';

import 'package:ew_l10n/l10n.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_polkadart/runtime_error.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

// named imports to disambiguate error types
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_ceremonies/pallet/error.dart'
    as ceremonies_error;
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_balances/pallet/error.dart'
    as balances_error;
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_reputation_commitments/pallet/error.dart'
    as reputation_commitments_error;

/// Message content of the notifications shown when a tx error occurs.
class ErrorNotificationMsg {
  ErrorNotificationMsg({required this.title, required this.body});

  final String title;
  final String body;
}

/// Returns a customized localised notification message if handled specifically, or just formats the
/// error otherwise.
///
/// Note: We want to have custom error messages for all errors that may occur in the regular user-flow.
ErrorNotificationMsg getLocalizedTxErrorMessage(AppLocalizations l10n, DispatchError error) {
  switch (error.runtimeType) {
    case Module:
      final moduleError = (error as Module).value0;
      final runtimeError = RuntimeError.decodeWithIndex(moduleError.index, moduleError.error);
      return getLocalizedModuleErrorMsg(l10n, runtimeError);
    case BadOrigin:
    case Other:
    case CannotLookup:
    case ConsumerRemaining:
    case NoProviders:
    case TooManyConsumers:
    case Token:
    case Arithmetic:
    case Transactional:
    case Exhausted:
    case Corruption:
    case Unavailable:
    case RootNotAllowed:
      Log.d('unhandled dispatch error: $error');
      return ErrorNotificationMsg(title: l10n.transactionError, body: error.toString());
    default:
      Log.d('unidentified dispatch error: $error');
      return ErrorNotificationMsg(title: l10n.transactionError, body: error.toString());
  }
}

ErrorNotificationMsg getLocalizedModuleErrorMsg(AppLocalizations l10n, RuntimeError error) {
  switch (error.runtimeType) {
    case EncointerCeremonies:
      return (error as EncointerCeremonies).value0.errorMsg(l10n);
    case EncointerBalances:
      return (error as EncointerBalances).value0.errorMsg(l10n);
    // List the pallets we have available for an overview
    case System:
    // case ParachainSystem:
    case Balances:
    // case XcmpQueue:
    // case PolkadotXcm:
    // case DmpQueue:
    case Utility:
    case Treasury:
    case Proxy:
    case Scheduler:
    // case Collective:
    // case Membership:
    case EncointerScheduler:
    case EncointerCommunities:
    case EncointerBazaar:
    case EncointerReputationCommitments:
      return (error as EncointerReputationCommitments).value0.errorMsg(l10n);
    case EncointerFaucet:
      Log.d('unhandled dispatch error: $error');
      return ErrorNotificationMsg(title: l10n.transactionError, body: '${error.toJson()}');
    default:
      Log.d('unidentified dispatch error $error');
      return ErrorNotificationMsg(title: l10n.transactionError, body: '${error.toJson()}');
  }
}

extension LocalizedCeremoniesError on ceremonies_error.Error {
  ErrorNotificationMsg errorMsg(AppLocalizations l10n) {
    return switch (this) {
      ceremonies_error.Error.votesNotDependable => ErrorNotificationMsg(
          title: l10n.votesNotDependableErrorTitle,
          body: l10n.votesNotDependableErrorBody,
        ),
      ceremonies_error.Error.alreadyEndorsed => ErrorNotificationMsg(
          title: l10n.alreadyEndorsedErrorTitle,
          body: l10n.alreadyEndorsedErrorBody,
        ),
      ceremonies_error.Error.noValidAttestations => ErrorNotificationMsg(
          title: l10n.noValidClaimsErrorTitle,
          body: l10n.noValidClaimsErrorBody,
        ),
      ceremonies_error.Error.rewardsAlreadyIssued => ErrorNotificationMsg(
          title: l10n.rewardsAlreadyIssuedErrorTitle,
          body: l10n.rewardsAlreadyIssuedErrorBody,
        ),
      _ => ErrorNotificationMsg(title: l10n.transactionError, body: toJson())
    };
  }
}

extension LocalizedBalancesError on balances_error.Error {
  ErrorNotificationMsg errorMsg(AppLocalizations l10n) {
    return switch (this) {
      balances_error.Error.balanceTooLow => ErrorNotificationMsg(
          title: l10n.balanceTooLowTitle,
          body: l10n.balanceTooLowBody,
        ),
      _ => ErrorNotificationMsg(title: l10n.transactionError, body: toJson())
    };
  }
}

extension LocalizedReputationCommitmentsError on reputation_commitments_error.Error {
  ErrorNotificationMsg errorMsg(AppLocalizations l10n) {
    return switch (this) {
      reputation_commitments_error.Error.alreadyCommited => ErrorNotificationMsg(
          title: l10n.reputationAlreadyCommittedTitle,
          body: l10n.reputationAlreadyCommittedContent,
        ),
      _ => ErrorNotificationMsg(title: l10n.transactionError, body: toJson())
    };
  }
}
