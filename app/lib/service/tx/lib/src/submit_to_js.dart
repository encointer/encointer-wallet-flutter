import 'dart:core';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_ceremonies/pallet/error.dart'
    as ceremonies_error;
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_balances/pallet/error.dart'
    as balances_error;
import 'package:ew_polkadart/runtime_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/tx_status.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';

/// Contains most of the logic from the `txConfirmPage.dart`, which was removed.

const insufficientFundsError = '1010';
const lowPriorityTx = '1014';

/// Inner function to submit a tx via the JS interface.
///
/// Should be private but dart lacks intelligent support to manage privacy. `submitTxWrappers/submitTx` should be
/// called from the outside instead of this one.
Future<void> submitToJS(
  BuildContext context,
  AppStore store,
  Api api,
  bool showStatusSnackBar, {
  required Map<String, dynamic> txParams,
  void Function(DispatchError error)? onError,
  required String password,
}) async {
  final l10n = context.l10n;

  store.assets.setSubmitting(true);
  store.account.setTxStatus(TxStatus.Queued);

  final txInfo = txParams['txInfo'] as Map<String, dynamic>;
  txInfo['pubKey'] = store.account.currentAccount.pubKey;
  txInfo['address'] = store.account.currentAddress;
  txInfo['password'] = password;
  Log.d('$txInfo', 'submitToJS');
  Log.d('${txParams['params']}', 'submitToJS');

  final onTxFinishFn = txParams['onFinish'] != null
      ? txParams['onFinish'] as dynamic Function(BuildContext, ExtrinsicReport)
      : (_, __) => null;

  if (await api.isConnected()) {
    if (showStatusSnackBar) {
      _showTxStatusSnackBar(
        getTxStatusTranslation(l10n, store.account.txStatus),
        const CupertinoActivityIndicator(),
      );
    }

    final report = await api.account.sendTxAndShowNotification(
      txParams['txInfo'] as Map<String, dynamic>,
      txParams['params'] as List<dynamic>?,
      rawParam: txParams['rawParam'] as String?,
      cid: store.encointer.community?.cid.toFmtString(),
    );

    if (report.isExtrinsicFailed) {
      _onTxError(context, store, report.dispatchError!, showStatusSnackBar, onError: onError);
    } else {
      _onTxFinish(context, store, report, onTxFinishFn, showStatusSnackBar);
    }
  } else {
    _showTxStatusSnackBar(l10n.txQueuedOffline, null);
    txInfo['notificationTitle'] = l10n.notifySubmittedQueued;
    txInfo['txError'] = l10n.txError;
    store.account.queueTx(txParams);
  }
}

void _onTxError(
  BuildContext context,
  AppStore store,
  DispatchError error,
  bool mounted, {
  void Function(DispatchError error)? onError,
}) {
  store.assets.setSubmitting(false);
  if (mounted) RootSnackBar.removeCurrent();
  final l10n = context.l10n;
  final languageCode = Localizations.localeOf(context).languageCode;
  final message = getLocalizedTxErrorMessage(l10n, error);

  onError?.call(error);

  AppAlert.showDialog<void>(
    context,
    title: Text('${message['title']}'),
    content: Text('${message['body']}'),
    actions: [
      const SizedBox.shrink(),
      CupertinoButton(
        child: const Text('FAQ'),
        onPressed: () {
          final cid = context.read<AppStore>().encointer.community?.cid.toFmtString();
          AppLaunch.launchURL(ceremonyInfoLink(languageCode, cid));
        },
      ),
      CupertinoButton(
        child: Text(l10n.ok),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}

void _showTxStatusSnackBar(String status, Widget? leading) {
  RootSnackBar.show(
    ListTile(
      leading: leading,
      title: Text(
        status,
        style: const TextStyle(color: Colors.black54),
      ),
    ),
    durationMillis: const Duration(seconds: 12).inMilliseconds,
  );
}

void _onTxFinish(
  BuildContext context,
  AppStore store,
  ExtrinsicReport report,
  void Function(BuildContext, ExtrinsicReport) onTxFinish,
  bool mounted,
) {
  Log.d('callback triggered, blockHash: ${report.blockHash}', '_onTxFinish');
  store.assets.setSubmitting(false);

  onTxFinish(context, report);

  if (mounted) {
    RootSnackBar.show(
      ListTile(
        leading: SizedBox(
          width: 24,
          child: Assets.images.assets.success.image(),
        ),
        title: Text(
          context.l10n.success,
          style: const TextStyle(color: Colors.black54),
        ),
      ),
      durationMillis: 2000,
    );
  }
}

String getTxStatusTranslation(AppLocalizations l10n, TxStatus? status) {
  if (status == null) return '';
  return switch (status) {
    TxStatus.Queued => l10n.txQueued,
    TxStatus.QueuedOffline => l10n.txQueuedOffline,
    TxStatus.Ready => l10n.txReady,
    TxStatus.Broadcast => l10n.txBroadcast,
    TxStatus.InBlock => l10n.txInBlock,
    TxStatus.Error => l10n.txError,
  };
}

Map<String, String> getLocalizedTxErrorMessage(AppLocalizations l10n, DispatchError error) {
  // Todo: this needs to be handled, but it is not part of the dispatch error.
  // if (txError.startsWith(lowPriorityTx)) {
  //   return {'title': l10n.txTooLowPriorityErrorTitle, 'body': l10n.txTooLowPriorityErrorBody};
  // } else if (txError.startsWith(insufficientFundsError)) {
  //   return {'title': l10n.insufficientFundsErrorTitle, 'body': l10n.insufficientFundsErrorBody};
  // }

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
      return {'title': l10n.transactionError, 'body': error.toString()};
    default:
      Log.d('unidentified dispatch error: $error');
      return {'title': l10n.transactionError, 'body': error.toString()};
  }
}

Map<String, String> getLocalizedModuleErrorMsg(AppLocalizations l10n, RuntimeError error) {
  switch (error.runtimeType) {
    case EncointerCeremonies:
      return (error as EncointerCeremonies).value0.errorMsg(l10n);
    case EncointerBalances:
      return (error as EncointerBalances).value0.errorMsg(l10n);
    // List the pallets we have available for an overview
    case System:
    case ParachainSystem:
    case Balances:
    case XcmpQueue:
    case PolkadotXcm:
    case DmpQueue:
    case Utility:
    case Treasury:
    case Proxy:
    case Scheduler:
    case Collective:
    case Membership:
    case EncointerScheduler:
    case EncointerCommunities:
    case EncointerBazaar:
    case EncointerReputationCommitments:
    case EncointerFaucet:
      Log.d('unhandled dispatch error: $error');
      return {'title': l10n.transactionError, 'body': error.toString()};
    default:
      Log.d('unidentified dispatch error $error');
      return {'title': l10n.transactionError, 'body': error.toString()};
  }
}

extension LocalizedCeremoniesError on ceremonies_error.Error {
  Map<String, String> errorMsg(AppLocalizations l10n) {
    return switch (this) {
      ceremonies_error.Error.votesNotDependable => {
          'title': l10n.votesNotDependableErrorTitle,
          'body': l10n.votesNotDependableErrorBody
        },
      ceremonies_error.Error.alreadyEndorsed => {
          'title': l10n.alreadyEndorsedErrorTitle,
          'body': l10n.alreadyEndorsedErrorBody
        },
      ceremonies_error.Error.noValidAttestations => {
          'title': l10n.noValidClaimsErrorTitle,
          'body': l10n.noValidClaimsErrorBody,
        },
      ceremonies_error.Error.rewardsAlreadyIssued => {
          'title': l10n.rewardsAlreadyIssuedErrorTitle,
          'body': l10n.rewardsAlreadyIssuedErrorBody
        },
      _ => {'title': l10n.transactionError, 'body': toString()}
    };
  }
}

extension LocalizedBalancesError on balances_error.Error {
  Map<String, String> errorMsg(AppLocalizations l10n) {
    return switch (this) {
      balances_error.Error.balanceTooLow => {
          'title': l10n.balanceTooLowTitle,
          'body': l10n.balanceTooLowBody,
        },
      _ => {'title': l10n.transactionError, 'body': toString()}
    };
  }
}
