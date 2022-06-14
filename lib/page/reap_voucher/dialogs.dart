
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<void> showRedeemSuccessDialog(BuildContext context) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return redeemSuccessDialog(context);
    },
  );
}

Widget redeemSuccessDialog(BuildContext context) {
  final dic = I18n.of(context).translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text(dic.assets.redeemSuccess),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      ),
    ],
  );
}

Future<void> showRedeemFailedDialog(BuildContext context, String error) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return redeemFailedDialog(context, error);
    },
  );
}

Widget redeemFailedDialog(BuildContext context, String error) {
  final dic = I18n.of(context).translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text("${dic.assets.redeemFailure} $error"),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      ),
    ],
  );
}

Future<void> showChangeNetworkAndCommunityDialog(
    BuildContext context,
    String network,
    CommunityIdentifier cid,
    Future<void> Function() onChangeConfirm,
    ) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      final dic = I18n.of(context).translationsForLocale();

      final dialogContent = dic.assets.voucherDifferentNetworkAndCommunity
          .replaceAll("NETWORK_PLACEHOLDER", network)
          .replaceAll("COMMUNITY_PLACEHOLDER", cid.toFmtString());

      return CupertinoAlertDialog(
        title: Container(),
        content: Text(dialogContent),
        actions: <Widget>[
          CupertinoButton(
            child: Text(dic.home.cancel),
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          ),
          CupertinoButton(
              child: Text(dic.home.ok),
              onPressed: () async {
                await onChangeConfirm();
              }),
        ],
      );
    },
  );
}

Future<void> showChangeCommunityDialog(
    BuildContext context,
    String network,
    CommunityIdentifier cid,
    Future<void> Function() onChangeConfirm,
    ) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      final dic = I18n.of(context).translationsForLocale();

      final dialogContent = dic.assets.voucherDifferentCommunity.replaceAll("COMMUNITY_PLACEHOLDER", cid.toFmtString());

      return CupertinoAlertDialog(
        title: Container(),
        content: Text(dialogContent),
        actions: <Widget>[
          CupertinoButton(
            child: Text(dic.home.cancel),
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          ),
          CupertinoButton(
              child: Text(dic.home.ok),
              onPressed: () async {
                await onChangeConfirm();
                Navigator.of(context).pop();
              }),
        ],
      );
    },
  );
}

Future<void> showInvalidCommunityDialog(BuildContext context, CommunityIdentifier cid) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return invalidCommunityDialog(context, cid);
    },
  );
}

Widget invalidCommunityDialog(BuildContext context, CommunityIdentifier cid) {
  final dic = I18n.of(context).translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text("${dic.assets.voucherContainsInexistentCommunity} ${cid.toFmtString()}"),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      ),
    ],
  );
}