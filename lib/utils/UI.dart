import 'dart:async';
import 'dart:io';

import 'package:encointer_wallet/common/regInputFormatter.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/udpateJSCodeApi.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class UI {
  static void copyAndNotify(BuildContext context, String? text) {
    Clipboard.setData(ClipboardData(text: text ?? ''));

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        final Translations dic = I18n.of(context)!.translationsForLocale();
        return CupertinoAlertDialog(
          title: Container(),
          content: Text('${dic.assets.copy} ${dic.assets.success}'),
        );
      },
    );

    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  static Future<void> launchURL(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (err) {
      print("Could not launch URL: ${err.toString()}");
    }
  }

  static Future<bool?> checkJSCodeUpdate(
    BuildContext context,
    int jsVersion,
    String network,
  ) async {
    final currentVersion = UpdateJSCodeApi.getPolkadotJSVersion(
      webApi!.jsStorage,
      network,
    )!;
    if (jsVersion > currentVersion) {
      final Translations dic = I18n.of(context)!.translationsForLocale();
      final bool? isOk = await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('metadata v$jsVersion'),
            content: Text(dic.home.updateJsUp),
            actions: <Widget>[
              CupertinoButton(
                child: Text(dic.home.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  exit(0);
                },
              ),
              CupertinoButton(
                child: Text(dic.home.ok),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
      return isOk;
    }
    return false;
  }

  static Future<void> updateJSCode(
    BuildContext context,
    GetStorage jsStorage,
    String network,
    int version,
  ) async {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.home.updateDownload),
          content: CupertinoActivityIndicator(),
        );
      },
    );
    final code = await UpdateJSCodeApi.fetchPolkadotJSCode(network);
    Navigator.of(context).pop();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(),
          content: code == null ? Text(dic.home.updateError) : Text(dic.home.success),
          actions: <Widget>[
            CupertinoButton(
              child: Text(dic.home.ok),
              onPressed: () {
                if (code == null) {
                  exit(0);
                }
                UpdateJSCodeApi.setPolkadotJSCode(jsStorage, network, code, version);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> alertWASM(BuildContext context, Function onCancel) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(),
          content: Text(I18n.of(context)!.translationsForLocale().account.backupError),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
              onPressed: () {
                Navigator.of(context).pop();
                onCancel();
              },
            ),
          ],
        );
      },
    );
  }

  static bool checkBalanceAndAlert(BuildContext context, AppStore store, BigInt amountNeeded) {
    String? symbol = store.settings!.networkState!.tokenSymbol;
    if (store.assets!.balances[symbol]!.transferable <= amountNeeded) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(I18n.of(context)!.translationsForLocale().assets.insufficientBalance),
            content: Container(),
            actions: <Widget>[
              CupertinoButton(
                child: Text(I18n.of(context)!.translationsForLocale().home.ok),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }

  static TextInputFormatter decimalInputFormatter({int decimals = encointer_currencies_decimals}) {
    return RegExInputFormatter.withRegex('^[0-9]{0,$decimals}(\\.[0-9]{0,$decimals})?\$');
  }
}
