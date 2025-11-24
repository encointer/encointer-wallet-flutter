import 'dart:async';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/reap_voucher/utils.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';

class VoucherDialogs {
  static Future<void> showRedeemSuccessDialog({
    required BuildContext context,
    required VoidCallback onOK,
  }) {
    final l10n = context.l10n;
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(
            l10n.redeemSuccess,
          ),
          actions: <Widget>[
            CupertinoButton(
              onPressed: onOK,
              child: Text(
                l10n.ok,
                key: const Key(EWTestKeys.voucherDialogOk),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<void> showRedeemFailedDialog(BuildContext context, String? error) {
  return showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return redeemFailedDialog(context, error);
    },
  );
}

Widget redeemFailedDialog(BuildContext context, String? error) {
  final l10n = context.l10n;
  return CupertinoAlertDialog(
    title: Container(),
    content: Text('${l10n.redeemFailure} $error'),
    actions: <Widget>[
      CupertinoButton(
        key: Key('voucher_dialog_error_${VoucherTestKeys.error.name}'),
        child: Text(
          l10n.ok,
          key: Key('voucher_dialog_${VoucherTestKeys.error.name}'),
        ),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    ],
  );
}

Future<void> showErrorDialog(BuildContext context, String error) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return errorDialog(context, error);
    },
  );
}

Widget errorDialog(BuildContext context, String errorMsg) {
  final l10n = context.l10n;
  return CupertinoAlertDialog(
    title: Container(),
    content: Text('${l10n.errorOccurred} $errorMsg'),
    actions: <Widget>[
      CupertinoButton(
        child: Text(l10n.ok),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    ],
  );
}

Future<ChangeResult?> showChangeNetworkAndCommunityDialog(
  BuildContext context,
  AppStore store,
  Api api,
  String network,
  CommunityIdentifier cid,
) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = context.l10n;
      final dialogContent = l10n.voucherDifferentNetworkAndCommunity(cid.toFmtString(), network);
      return CupertinoAlertDialog(
        title: Container(),
        content: Text(dialogContent),
        actions: <Widget>[
          CupertinoButton(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          CupertinoButton(
            child: Text(l10n.ok),
            onPressed: () async {
              final result =
                  await changeWithLoadingDialog(context, changeNetworkAndCommunity(store, api, network, cid));
              Navigator.of(context).pop(result);
            },
          ),
        ],
      );
    },
  );
}

Future<ChangeResult> changeWithLoadingDialog(
  BuildContext context,
  Future<ChangeResult> changeFnFuture,
) async {
  unawaited(
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(context.l10n.loading),
          content: const SizedBox(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    ),
  );

  final result = await changeFnFuture;

  // pop loading dialog
  Navigator.of(context).pop();

  return result;
}

Future<ChangeResult?> showChangeCommunityDialog(
  BuildContext context,
  AppStore store,
  Api api,
  String network,
  CommunityIdentifier cid,
) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = context.l10n;

      final dialogContent = l10n.voucherDifferentCommunity(cid.toFmtString());

      return CupertinoAlertDialog(
        title: Container(),
        content: Text(dialogContent),
        actions: <Widget>[
          CupertinoButton(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          CupertinoButton(
            child: Text(l10n.ok),
            onPressed: () async {
              final result = await changeWithLoadingDialog(context, changeCommunity(store, api, network, cid));
              Navigator.of(context).pop(result);
            },
          ),
        ],
      );
    },
  );
}

enum VoucherTestKeys { success, error }
