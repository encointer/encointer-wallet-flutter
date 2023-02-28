import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/validate_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'account_create_store.g.dart';

class AccountCreate extends _AccountCreate with _$AccountCreate {}

abstract class _AccountCreate with Store {
  @observable
  String? name;

  @observable
  String? accountKey;

  @observable
  KeyType keyType = KeyType.mnemonic;

  @observable
  bool loading = false;

  @action
  void setName(String value) => name = value;

  @action
  void setLoading(bool valeu) => loading = valeu;

  @action
  void resetName() => name = null;

  @action
  void setKey(String value) => accountKey = value;

  @action
  void setKeyType(KeyType value) => keyType = value;

  @action
  Future<void> generateAccount({
    required BuildContext context,
    required AppStore appStore,
    required Api webApi,
    required String password,
  }) async {
    setLoading(true);
    appStore.settings.setPin(password);
    final key = await webApi.account.generateAccount();
    final acc = await webApi.account.importAccount(key: key, password: password);
    if (acc['error'] != null) {
      setLoading(false);
      final dic = I18n.of(context)!.translationsForLocale();
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

  @action
  Future<void> genarateAddAccount({
    required BuildContext context,
    required AppStore appStore,
    required Api webApi,
    required String name,
  }) async {
    setLoading(true);
    if (appStore.settings.cachedPin.isEmpty) {
      await AppAlert.showInputPasswordDailog(context: context, account: appStore.account.currentAccount);
    }
    final pin = appStore.settings.cachedPin;
    final key = await webApi.account.generateAccount();
    final acc = await webApi.account.importAccount(
      key: key,
      password: pin,
    );
    if (acc['error'] != null) {
      setLoading(false);
      final dic = I18n.of(context)!.translationsForLocale();
      AppAlert.showErrorDailog(context, errorText: dic.account.createError, buttontext: dic.home.ok);
    } else {
      final addresses = await webApi.account.encodeAddress([acc['pubKey'] as String]);
      await appStore.addAccount(acc, pin, addresses[0], name);
      final pubKey = acc['pubKey'] as String?;
      appStore.setCurrentAccount(pubKey);
      await appStore.loadAccountCache();

      // fetch info for the imported account
      webApi.fetchAccountData();
      setLoading(false);
      Navigator.of(context).pop();
    }
  }

  @action
  String? validateAccount(Translations dic, String key) {
    if (key.isEmpty) return dic.account.importMustNotBeEmpty;
    if (ValidateKeys.isRawSeed(key)) {
      keyType = KeyType.rawSeed;
      return ValidateKeys.validateRawSeed(key) ? null : dic.account.importInvalidRawSeed;
    } else if (ValidateKeys.isPrivateKey(key)) {
      // Todo: #426
      return dic.account.importPrivateKeyUnsupported;
    } else {
      keyType = KeyType.mnemonic;
      return ValidateKeys.validateMnemonic(key) ? null : dic.account.importInvalidMnemonic;
    }
  }

  @action
  Future<void> importAccount({
    required BuildContext context,
    required String name,
    required String key,
    required AppStore appStore,
  }) async {
    if (appStore.account.isFirstAccount) {
      // Navigator.pushNamed(context, CreatePinPage.route, arguments: CreatePinPageParams(_importAccount));
    } else {
      final dic = I18n.of(context)!.translationsForLocale();
      setLoading(true);
      AppAlert.showLoadingDailog(context, dic.home.loading);
      if (appStore.settings.cachedPin.isEmpty) {
        await AppAlert.showInputPasswordDailog(context: context, account: appStore.account.currentAccount);
      }
      final password = appStore.settings.cachedPin;
      final acc = await webApi.account.importAccount(
        key: key,
        password: password,
        keyType: keyType.name,
      );
      if (acc['error'] != null) {
        _importError(context, acc);
      } else {
        final index = appStore.account.accountList.indexWhere((i) => i.pubKey == acc['pubKey']);
        if (index > -1) {
          await _accountDuplicate(context: context, appStore: appStore, acc: acc);
        } else {
          await _saveAccount(acc: acc, webApi: webApi, appStore: appStore, password: password, name: name);
          Navigator.pushAndRemoveUntil<void>(
            context,
            CupertinoPageRoute<void>(builder: (context) => const EncointerHomePage()),
            (route) => false,
          );
        }
      }
    }
  }

  Future<void> _accountDuplicate({
    required BuildContext context,
    required AppStore appStore,
    required Map<String, dynamic> acc,
  }) async {
    final pubKeyMap = appStore.account.pubKeyAddressMap[appStore.settings.endpoint.ss58]!;
    final address = pubKeyMap[acc['pubKey']];
    final dic = I18n.of(context)!.translationsForLocale();
    if (address != null) {
      AppAlert.showDailog<void>(
        context,
        title: Text(Fmt.address(address)!),
        content: Text(dic.account.importDuplicate),
        actions: [
          CupertinoButton(
            child: Text(dic.home.cancel),
            onPressed: () {
              setLoading(false);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
          CupertinoButton(
            child: Text(dic.home.ok),
            onPressed: () async {
              // await _saveAccount(acc);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  Future<void> _saveAccount({
    required Map<String, dynamic> acc,
    required Api webApi,
    required AppStore appStore,
    required String password,
    required String name,
  }) async {
    final addresses = await webApi.account.encodeAddress([acc['pubKey'] as String]);
    await appStore.addAccount(acc, password, addresses[0], name);
    final pubKey = acc['pubKey'] as String?;
    await appStore.setCurrentAccount(pubKey);
    await appStore.loadAccountCache();
    webApi.fetchAccountData();
    setLoading(false);
  }

  void _importError(BuildContext context, Map<String, dynamic> acc) {
    var msg = acc['error'] as String;

    final dic = I18n.of(context)!.translationsForLocale();

    if (acc['error'] == 'unreachable') {
      msg = '${dic.account.importInvalid}: ${keyType.name}';
    }
    AppAlert.showErrorDailog(
      context,
      errorText: msg,
      buttontext: dic.home.ok,
      onPressed: () {
        setLoading(false);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }
}

enum KeyType {
  mnemonic('mnemonic'),
  rawSeed('rawSeed'),
  keystore('keystore');

  const KeyType(this.key);

  final String key;
}
