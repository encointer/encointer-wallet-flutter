// ignore_for_file: library_private_types_in_public_api
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/validate_keys.dart';

part 'new_account_store.g.dart';

class NewAccountStore = _NewAccountStoreBase with _$NewAccountStore;

abstract class _NewAccountStoreBase with Store {
  @observable
  String? name;

  @observable
  String? password;

  @observable
  String? accountKey;

  @observable
  KeyType keyType = KeyType.mnemonic;

  @observable
  bool loading = false;

  @observable
  Map<String, dynamic>? cacheAcc;

  @action
  void setName(String? value) => name = value;

  @action
  void setPassword(String? value) => password = value;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setKey(String? value) => accountKey = value;

  @action
  void setKeyType(KeyType value) => keyType = value;

  @action
  void setCacheAcc(Map<String, dynamic> value) => cacheAcc = value;

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
  Future<AddAccountResponse> generateAccount(AppStore appStore, Api webApi) async {
    if (appStore.settings.cachedPin.isNotEmpty || password != null) {
      setLoading(true);
      final pin = password ?? appStore.settings.cachedPin;
      return _generateAccount(appStore, webApi, pin);
    } else {
      Log.d('add account', 'empty password');
      return AddAccountResponse.passwordEmpty;
    }
  }

  @action
  Future<AddAccountResponse> importAccount(AppStore appStore, Api webApi) async {
    if (appStore.settings.cachedPin.isNotEmpty || password != null) {
      setLoading(true);
      final pin = password ?? appStore.settings.cachedPin;
      return _importAccount(appStore, webApi, pin);
    } else {
      Log.d('add account', 'empty password');
      return AddAccountResponse.passwordEmpty;
    }
  }

  @action
  Future<AddAccountResponse> _generateAccount(AppStore appStore, Api webApi, String pin) async {
    try {
      appStore.settings.setPin(pin);
      final key = await webApi.account.generateAccount();
      final acc = await webApi.account.importAccount(key: key, password: pin);
      if (acc['error'] != null) {
        setLoading(false);
        return AddAccountResponse.fail;
      } else {
        return saveAccount(webApi, appStore, acc, pin);
      }
    } catch (e, s) {
      Log.e('generate account', '$e', s);
      return AddAccountResponse.fail;
    }
  }

  @action
  Future<AddAccountResponse> _importAccount(AppStore appStore, Api webApi, String pin) async {
    try {
      appStore.settings.setPin(pin);
      final acc = await webApi.account.importAccount(
        key: accountKey ?? '',
        password: pin,
        keyType: keyType.name,
      );
      if (acc['error'] != null) {
        setLoading(false);
        return AddAccountResponse.fail;
      } else {
        final index = appStore.account.accountList.indexWhere((i) => i.pubKey == acc['pubKey']);
        if (index > -1) {
          cacheAcc = acc;
          setLoading(false);
          return AddAccountResponse.duplicate;
        } else {
          return saveAccount(webApi, appStore, acc, pin);
        }
      }
    } catch (e, s) {
      Log.e('import account', '$e', s);
      return AddAccountResponse.fail;
    }
  }

  @action
  Future<AddAccountResponse> saveAccount(Api webApi, AppStore appStore, Map<String, dynamic> acc, String pin) async {
    final addresses = await webApi.account.encodeAddress([acc['pubKey'] as String]);
    await appStore.addAccount(acc, pin, addresses[0], name);
    final pubKey = acc['pubKey'] as String?;
    await appStore.setCurrentAccount(pubKey);
    await appStore.loadAccountCache();
    webApi.fetchAccountData();
    setLoading(false);
    return AddAccountResponse.success;
  }
}

enum KeyType {
  mnemonic('mnemonic'),
  rawSeed('rawSeed'),
  keystore('keystore');

  const KeyType(this.key);

  final String key;
}

enum AddAccountResponse { success, fail, duplicate, passwordEmpty }
