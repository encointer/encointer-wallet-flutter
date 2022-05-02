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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:update_app/update_app.dart';
import 'package:url_launcher/url_launcher.dart';

class UI {
  static void copyAndNotify(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text ?? ''));

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        final Translations dic = I18n.of(context).translationsForLocale();
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
      await launch(url);
    } catch (err) {
      print("Could not launch URL: ${err.toString()}");
    }
  }

  // Todo: Decide if we keep this https://github.com/encointer/encointer-wallet-flutter/issues/517
  static Future<void> checkUpdate(BuildContext context, Map versions, {bool autoCheck = false}) async {
    if (versions == null || !Platform.isAndroid && !Platform.isIOS) return;
    String platform = Platform.isAndroid ? 'android' : 'ios';
    final Translations dic = I18n.of(context).translationsForLocale();

    int latestCode = versions[platform]['version-code'];
    String latestBeta = versions[platform]['version-beta'];
    int latestCodeBeta = versions[platform]['version-code-beta'];

    bool needUpdate = false;
    if (autoCheck) {
      if (latestCode > app_beta_version_code) {
        // new version found
        needUpdate = true;
      } else {
        return;
      }
    } else {
      if (latestCodeBeta > app_beta_version_code) {
        // new version found
        needUpdate = true;
      }
    }

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        List versionInfo = versions[platform]['info'][I18n.of(context).locale.toString().contains('zh') ? 'zh' : 'en'];
        return CupertinoAlertDialog(
          title: Text('v$latestBeta'),
          content: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12, bottom: 8),
                child: Text(needUpdate ? dic.home.updateToNewerVersionQ : dic.home.updateLatest),
              ),
              needUpdate
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: versionInfo
                          .map((e) => Text(
                                '- $e',
                                textAlign: TextAlign.left,
                              ))
                          .toList(),
                    )
                  : Container()
            ],
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text(dic.home.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoButton(
              child: Text(dic.home.ok),
              onPressed: () async {
                Navigator.of(context).pop();
                if (!needUpdate) {
                  return;
                }
                if (Platform.isIOS) {
                  // go to ios download page
                  launchURL('https://polkawallet.io/#download');
                } else if (Platform.isAndroid) {
                  // download apk
                  // START LISTENING FOR DOWNLOAD PROGRESS REPORTING EVENTS
                  try {
                    String url = versions['android']['url'];
                    UpdateApp.updateApp(url: url, appleId: "1520301768");
                  } catch (e) {
                    print('Failed to make OTA update. Details: $e');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> checkJSCodeUpdate(
    BuildContext context,
    int jsVersion,
    String network,
  ) async {
    if (jsVersion != null) {
      final currentVersion = UpdateJSCodeApi.getPolkadotJSVersion(
        webApi.jsStorage,
        network,
      );
      if (jsVersion > currentVersion) {
        final Translations dic = I18n.of(context).translationsForLocale();
        final bool isOk = await showCupertinoDialog(
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
    }
    return false;
  }

  static Future<void> updateJSCode(
    BuildContext context,
    GetStorage jsStorage,
    String network,
    int version,
  ) async {
    final Translations dic = I18n.of(context).translationsForLocale();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.home.updateDownload),
          content: CupertinoActivityIndicator(),
        );
      },
    );
    final String code = await UpdateJSCodeApi.fetchPolkadotJSCode(network);
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
                UpdateJSCodeApi.setPolkadotJSCode(jsStorage, network, code, version);
                Navigator.of(context).pop();
                if (code == null) {
                  exit(0);
                }
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
          content: Text(I18n.of(context).translationsForLocale().account.backupError),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.ok),
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
    String symbol = store.settings.networkState.tokenSymbol;
    if (store.assets.balances[symbol].transferable <= amountNeeded) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(I18n.of(context).translationsForLocale().assets.insufficientBalance),
            content: Container(),
            actions: <Widget>[
              CupertinoButton(
                child: Text(I18n.of(context).translationsForLocale().home.ok),
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

// access the refreshIndicator globally
// assets index page:
final GlobalKey<RefreshIndicatorState> globalBalanceRefreshKey = new GlobalKey<RefreshIndicatorState>();
// asset page:
final GlobalKey<RefreshIndicatorState> globalAssetRefreshKey = new GlobalKey<RefreshIndicatorState>();
// staking bond page:
final GlobalKey<RefreshIndicatorState> globalBondingRefreshKey = new GlobalKey<RefreshIndicatorState>();
// staking nominate page:
final GlobalKey<RefreshIndicatorState> globalNominatingRefreshKey = new GlobalKey<RefreshIndicatorState>();
// council & motions page:
final GlobalKey<RefreshIndicatorState> globalCouncilRefreshKey = new GlobalKey<RefreshIndicatorState>();
final GlobalKey<RefreshIndicatorState> globalMotionsRefreshKey = new GlobalKey<RefreshIndicatorState>();
// democracy page:
final GlobalKey<RefreshIndicatorState> globalDemocracyRefreshKey = new GlobalKey<RefreshIndicatorState>();
// treasury proposals&tips page:
final GlobalKey<RefreshIndicatorState> globalProposalsRefreshKey = new GlobalKey<RefreshIndicatorState>();
final GlobalKey<RefreshIndicatorState> globalTipsRefreshKey = new GlobalKey<RefreshIndicatorState>();
// recovery settings page:
final GlobalKey<RefreshIndicatorState> globalRecoverySettingsRefreshKey = new GlobalKey<RefreshIndicatorState>();
// recovery state page:
final GlobalKey<RefreshIndicatorState> globalRecoveryStateRefreshKey = new GlobalKey<RefreshIndicatorState>();
// recovery vouch page:
final GlobalKey<RefreshIndicatorState> globalRecoveryProofRefreshKey = new GlobalKey<RefreshIndicatorState>();

// acala loan page:
final GlobalKey<RefreshIndicatorState> globalLoanRefreshKey = new GlobalKey<RefreshIndicatorState>();
// acala dexLiquidity page:
final GlobalKey<RefreshIndicatorState> globalDexLiquidityRefreshKey = new GlobalKey<RefreshIndicatorState>();
// acala homa page:
final GlobalKey<RefreshIndicatorState> globalHomaRefreshKey = new GlobalKey<RefreshIndicatorState>();

// encointerCeremoniesPage
final GlobalKey<RefreshIndicatorState> globalCeremonyPhaseChangeKey = new GlobalKey<RefreshIndicatorState>();
final GlobalKey<RefreshIndicatorState> globalCeremonyRegistrationRefreshKey = new GlobalKey<RefreshIndicatorState>();
