import 'dart:core';

import 'package:ew_l10n/l10n.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_polkadart/runtime_error.dart';
import 'package:ew_log/ew_log.dart';

// named imports to disambiguate error types
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_bazaar/pallet/error.dart'
    as bazaar_error;
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_ceremonies/pallet/error.dart'
    as ceremonies_error;
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_balances/pallet/error.dart'
    as balances_error;
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_reputation_commitments/pallet/error.dart'
    as reputation_commitments_error;
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_proxy/pallet/error.dart' as proxy_error;

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
    case Proxy:
      return (error as Proxy).value0.errorMsg(l10n);
    case EncointerBazaar:
      return (error as EncointerBazaar).value0.errorMsg(l10n);
    case EncointerReputationCommitments:
      return (error as EncointerReputationCommitments).value0.errorMsg(l10n);
    // Unhandled pallets — log and show raw JSON
    case System:
    case Balances:
    case Utility:
    case Treasury:
    case Scheduler:
    case EncointerScheduler:
    case EncointerCommunities:
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

extension LocalizedBazaarError on bazaar_error.Error {
  ErrorNotificationMsg errorMsg(AppLocalizations l10n) {
    return switch (this) {
      bazaar_error.Error.nonexistentCommunity => ErrorNotificationMsg(
          title: l10n.bazaarNonexistentCommunityTitle,
          body: l10n.bazaarNonexistentCommunityBody,
        ),
      bazaar_error.Error.existingBusiness => ErrorNotificationMsg(
          title: l10n.bazaarExistingBusinessTitle,
          body: l10n.bazaarExistingBusinessBody,
        ),
      bazaar_error.Error.nonexistentBusiness => ErrorNotificationMsg(
          title: l10n.bazaarNonexistentBusinessTitle,
          body: l10n.bazaarNonexistentBusinessBody,
        ),
      bazaar_error.Error.nonexistentOffering => ErrorNotificationMsg(
          title: l10n.bazaarNonexistentOfferingTitle,
          body: l10n.bazaarNonexistentOfferingBody,
        ),
    };
  }
}

extension LocalizedProxyError on proxy_error.Error {
  ErrorNotificationMsg errorMsg(AppLocalizations l10n) {
    return switch (this) {
      proxy_error.Error.tooMany => ErrorNotificationMsg(
          title: l10n.proxyTooManyTitle,
          body: l10n.proxyTooManyBody,
        ),
      proxy_error.Error.notFound => ErrorNotificationMsg(
          title: l10n.proxyNotFoundTitle,
          body: l10n.proxyNotFoundBody,
        ),
      proxy_error.Error.notProxy => ErrorNotificationMsg(
          title: l10n.proxyNotProxyTitle,
          body: l10n.proxyNotProxyBody,
        ),
      proxy_error.Error.unproxyable => ErrorNotificationMsg(
          title: l10n.proxyUnproxyableTitle,
          body: l10n.proxyUnproxyableBody,
        ),
      proxy_error.Error.duplicate => ErrorNotificationMsg(
          title: l10n.proxyDuplicateTitle,
          body: l10n.proxyDuplicateBody,
        ),
      proxy_error.Error.noPermission => ErrorNotificationMsg(
          title: l10n.proxyNoPermissionTitle,
          body: l10n.proxyNoPermissionBody,
        ),
      proxy_error.Error.unannounced => ErrorNotificationMsg(
          title: l10n.proxyUnannouncedTitle,
          body: l10n.proxyUnannouncedBody,
        ),
      proxy_error.Error.noSelfProxy => ErrorNotificationMsg(
          title: l10n.proxyNoSelfProxyTitle,
          body: l10n.proxyNoSelfProxyBody,
        ),
    };
  }
}
