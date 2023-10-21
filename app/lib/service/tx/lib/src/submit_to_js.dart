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

const insufficientFundsError = 1010;
const lowPriorityTx = 1014;

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

    try {
      final report = await api.account.sendTxAndShowNotification(
        txParams['txInfo'] as Map<String, dynamic>,
        txParams['params'] as List<dynamic>?,
        rawParam: txParams['rawParam'] as String?,
        cid: store.encointer.community?.cid.toFmtString(),
      );

      if (report.isExtrinsicFailed) {
        _onTxError(store, showStatusSnackBar);
        onError?.call(report.dispatchError!);
        final message = getLocalizedTxErrorMessage(l10n, report.dispatchError!);
        _showErrorDialog(context, message);
      } else {
        _onTxFinish(context, store, report, onTxFinishFn, showStatusSnackBar);
      }
    } catch (e) {
      _onTxError(store, showStatusSnackBar);
      final rpcError = RpcError.fromJson(e as Map<String, dynamic>);
      var msg = ErrorNotificationMsg(title: l10n.transactionError, body: e.toString());
      if (rpcError.code == lowPriorityTx) {
        msg = ErrorNotificationMsg(title: l10n.txTooLowPriorityErrorTitle, body: l10n.txTooLowPriorityErrorBody);
      } else if (rpcError.code == insufficientFundsError) {
        msg = ErrorNotificationMsg(title: l10n.insufficientFundsErrorTitle, body: l10n.insufficientFundsErrorBody);
      }
      _showErrorDialog(context, msg);
    }
  } else {
    _showTxStatusSnackBar(l10n.txQueuedOffline, null);
    txInfo['notificationTitle'] = l10n.notifySubmittedQueued;
    txInfo['txError'] = l10n.txError;
    store.account.queueTx(txParams);
  }
}

void _onTxError(AppStore store, bool mounted) {
  store.assets.setSubmitting(false);
  if (mounted) RootSnackBar.removeCurrent();
}

void _showErrorDialog(BuildContext context, ErrorNotificationMsg message) {
  final l10n = context.l10n;
  final languageCode = Localizations.localeOf(context).languageCode;

  AppAlert.showDialog<void>(
    context,
    title: Text(message.title),
    content: Text(message.body),
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
      return ErrorNotificationMsg(title: l10n.transactionError, body: error.toString());
    default:
      Log.d('unidentified dispatch error $error');
      return ErrorNotificationMsg(title: l10n.transactionError, body: error.toString());
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
      _ => ErrorNotificationMsg(title: l10n.transactionError, body: toString())
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
      _ => ErrorNotificationMsg(title: l10n.transactionError, body: toString())
    };
  }
}

class ErrorNotificationMsg {
  ErrorNotificationMsg({required this.title, required this.body});

  final String title;
  final String body;
}

class RpcError {
  RpcError({required this.code, required this.message, required this.data});

  factory RpcError.fromJson(Map<String, dynamic> map) {
    return RpcError(code: map['code'] as int, message: map['message'] as String, data: map['data'] as String);
  }

  final int code;
  final String message;
  final String data;
}
