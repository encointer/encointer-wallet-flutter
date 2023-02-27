import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'account_create_store.g.dart';

class AccountCreate extends _AccountCreate with _$AccountCreate {}

abstract class _AccountCreate with Store {
  @observable
  String? name;

  @observable
  bool loading = false;

  @action
  void setName(String value) => name = value;

  @action
  void setLoading(bool valeu) => loading = valeu;

  @action
  void resetName() => name = null;

  @action
  Future<void> generateAccount({
    required BuildContext context,
    required AppStore appStore,
    required Api webApi,
    required String password,
  }) async {
    final dic = I18n.of(context)!.translationsForLocale();
    setLoading(true);
    appStore.settings.setPin(password);
    final key = await webApi.account.generateAccount();
    final acc = await webApi.account.importAccount(key: key, password: password);
    if (acc['error'] != null) {
      setLoading(false);
      AppAlert.showErrorDailog(context, errorText: dic.account.createError, buttontext: dic.home.ok);
    } else {
      final addresses = await webApi.account.encodeAddress([acc['pubKey'] as String]);
      await appStore.addAccount(acc, password, addresses[0], name);
      final pubKey = acc['pubKey'] as String?;
      appStore.setCurrentAccount(pubKey);
      await appStore.loadAccountCache();

      // fetch info for the imported account
      webApi.fetchAccountData();
      setLoading(false);
      if (appStore.encointer.communityIdentifiers.length == 1) {
        await appStore.encointer.setChosenCid(appStore.encointer.communityIdentifiers[0]);
      } else {
        await Navigator.pushNamed(context, CommunityChooserOnMap.route);
      }
      await Navigator.pushNamedAndRemoveUntil<void>(context, EncointerHomePage.route, (route) => false);
    }
  }
}
