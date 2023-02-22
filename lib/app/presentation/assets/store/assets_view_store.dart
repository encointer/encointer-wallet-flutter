import 'package:encointer_wallet/common/components/password_input_dialog.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/extras/utils/translations/translations_services.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/src/notification_plugin.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'assets_view_store.g.dart';

const _tag = 'assets_view_store';

class AssetsViewStore = _AssetsViewStoreBase with _$AssetsViewStore;

abstract class _AssetsViewStoreBase with Store {
  @action
  void dispose() {
    Log.d('dispose', _tag);
  }

  @action
  Future<void> refreshEncointerState() async {
    Log.d('refreshEncointerState', _tag);
    // getCurrentPhase is the root of all state updates.
    await webApi.encointer.getCurrentPhase();
  }

  // if network connected failed, reconnect
  @action
  Future<void> reconnect({
    required BuildContext context,
    required AppStore appStore,
  }) async {
    Log.d('reconnect', _tag);
    if (!appStore.settings.loading && appStore.settings.networkName == null) {
      appStore.settings.setNetworkLoading(true);
      await webApi.connectNodeAll();
    }
  }

  @action
  Future<void> switchAccount(AccountData account, AppStore appStore) async {
    if (account.pubKey != appStore.account.currentAccountPubKey) {
      appStore.setCurrentAccount(account.pubKey);
      await appStore.loadAccountCache();

      webApi.fetchAccountData();
    }
  }

  @action
  void refreshBalanceAndNotify(BuildContext context) {
    Log.d('refreshBalanceAndNotify', _tag);
    final dic = I18n.of(context)!.translationsForLocale();
    final appStore = context.read<AppStore>();
    webApi.encointer.getAllBalances(appStore.account.currentAddress).then((balances) {
      Log.d('[home:refreshBalanceAndNotify] get all balances', _tag);
      if (appStore.encointer.chosenCid == null) {
        Log.d('[home:refreshBalanceAndNotify] no community selected', _tag);
        return;
      }
      var activeAccountHasBalance = false;
      balances.forEach((cid, balanceEntry) {
        final cidStr = cid.toFmtString();
        if (appStore.encointer.communityStores!.containsKey(cidStr)) {
          final community = appStore.encointer.communityStores![cidStr]!;
          final oldBalanceEntry =
              appStore.encointer.accountStores?[appStore.account.currentAddress]?.balanceEntries[cidStr];
          final demurrageRate = community.demurrage!;
          final newBalance = community.applyDemurrage != null ? community.applyDemurrage!(balanceEntry) ?? 0 : 0;
          final oldBalance = (community.applyDemurrage != null && oldBalanceEntry != null)
              ? community.applyDemurrage!(oldBalanceEntry) ?? 0
              : 0;

          final delta = newBalance - oldBalance;
          Log.d('[home:refreshBalanceAndNotify] balance for $cidStr was $oldBalance, changed by $delta', _tag);
          if (delta.abs() > demurrageRate) {
            appStore.encointer.accountStores![appStore.account.currentAddress]?.addBalanceEntry(cid, balances[cid]!);
            if (delta > demurrageRate) {
              final msg = dic.assets.incomingConfirmed
                  .replaceAll('AMOUNT', delta.toStringAsPrecision(5))
                  .replaceAll('CID_SYMBOL', community.metadata!.symbol)
                  .replaceAll('ACCOUNT_NAME', appStore.account.currentAccount.name);
              Log.d('[home:balanceWatchdog] $msg', _tag);
              NotificationPlugin.showNotification(45, dic.assets.fundsReceived, msg, cid: cidStr);
            }
          }
          if (cid == appStore.encointer.chosenCid) {
            activeAccountHasBalance = true;
          }
        }
      });
      if (!activeAccountHasBalance) {
        Log.d(
          "[home:refreshBalanceAndNotify] didn't get any balance for active account. initialize store balance to zero",
          _tag,
        );
        appStore.encointer.accountStores![appStore.account.currentAddress]
            ?.addBalanceEntry(appStore.encointer.chosenCid!, BalanceEntry(0, 0));
      }
    }).catchError((Object? e, StackTrace? s) {
      Log.e('[home:refreshBalanceAndNotify] WARNING: could not update balance: $e', _tag, s);
    });
  }

  @action
  Future<void> showPasswordDialog(BuildContext context) async {
    Log.d('showPasswordDialog', _tag);
    final appStore = context.read<AppStore>();
    await showCupertinoDialog<void>(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: showPasswordInputDialog(
            context: context,
            account: appStore.account.currentAccount,
            title: Text(I18n.of(context)!.translationsForLocale().home.unlock),
            onOk: (String password) {
              appStore.settings.setPin(password);
            },
          ),
          // handles back button press
          onWillPop: () async {
            await _showPasswordNotEnteredDialog(context);
            return false;
          },
        );
      },
    );
  }

  @action
  Future<void> _showPasswordNotEnteredDialog(BuildContext context) async {
    Log.d('_showPasswordNotEnteredDialog', _tag);
    await showCupertinoDialog<void>(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context)!.translationsForLocale().home.pinNeeded),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.cancel),
              onPressed: () {
                Log.d('_showPasswordNotEnteredDialog: [Navigator.of(context).pop()]', _tag);
                Navigator.of(context).pop();
              },
            ),
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.closeApp),
              onPressed: () {
                Log.d(
                  "_showPasswordNotEnteredDialog: [ SystemChannels.platform.invokeMethod('SystemNavigator.pop') ]",
                  _tag,
                );
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        );
      },
    );
  }
}
