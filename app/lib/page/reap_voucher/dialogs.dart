import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/reap_voucher/utils.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/cupertino.dart';

Future<void> showRedeemSuccessDialog(BuildContext context) {
  return showCupertinoDialog(
    context: context,
    builder: redeemSuccessDialog,
  );
}

Widget redeemSuccessDialog(BuildContext context) {
  final dic = context.l10n;

  return CupertinoAlertDialog(
    title: Container(),
    content: Text(dic.redeemSuccess),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.ok),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    ],
  );
}

Future<void> showRedeemFailedDialog(BuildContext context, String? error) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return redeemFailedDialog(context, error);
    },
  );
}

Widget redeemFailedDialog(BuildContext context, String? error) {
  final dic = context.l10n;

  return CupertinoAlertDialog(
    title: Container(),
    content: Text('${dic.redeemFailure} $error'),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.ok),
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
  final dic = context.l10n;

  return CupertinoAlertDialog(
    title: Container(),
    content: Text('${dic.errorOccurred} $errorMsg'),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.ok),
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
      final dic = context.l10n;

      final dialogContent = dic.voucherDifferentNetworkAndCommunity(cid.toFmtString(), network);

      return CupertinoAlertDialog(
        title: Container(),
        content: Text(dialogContent),
        actions: <Widget>[
          CupertinoButton(
            child: Text(dic.cancel),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          CupertinoButton(
            child: Text(dic.ok),
            onPressed: () async {
              final result =
                  await changeWithLoadingDialog(context, () => changeNetworkAndCommunity(store, api, network, cid));
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
  Future<ChangeResult> Function() changeFn,
) async {
  await showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(context.l10n.loading),
        content: const SizedBox(height: 64, child: CupertinoActivityIndicator()),
      );
    },
  );

  final result = await changeFn();

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
      final dic = context.l10n;

      final dialogContent = dic.voucherDifferentCommunity(cid.toFmtString());

      return CupertinoAlertDialog(
        title: Container(),
        content: Text(dialogContent),
        actions: <Widget>[
          CupertinoButton(
            child: Text(dic.cancel),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          CupertinoButton(
            child: Text(dic.ok),
            onPressed: () async {
              final result = await changeWithLoadingDialog(context, () => changeCommunity(store, api, network, cid));
              Navigator.of(context).pop(result);
            },
          ),
        ],
      );
    },
  );
}
