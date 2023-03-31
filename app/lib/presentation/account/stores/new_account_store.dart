// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/presentation/account/types/new_account_result.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:encointer_wallet/extras/utils/translations/translations.dart';
import 'package:encointer_wallet/extras/utils/validate_keys.dart';

part 'new_account_store.g.dart';

const _tag = 'new_account_store';

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

  @readonly
  bool _loading = false;

  @action
  void setName(String? value) => name = value;

  @action
  void setPassword(String? value) => password = value;

  @action
  void setKey(String? value) => accountKey = value;

  @action
  void setKeyType(KeyType value) => keyType = value;

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
  Future<NewAccountResult> generateAccount(AppStore appStore, Api webApi) async {
    Log.d('generateAccount', _tag);
    final pin = password ?? appStore.settings.cachedPin;
    if (pin.isEmpty) return const NewAccountResult(NewAccountResultType.emptyPassword);
    return _generateAccount(appStore, webApi, pin);
  }

  @action
  Future<NewAccountResult> importAccount(AppStore appStore, Api webApi) async {
    Log.d('importAccount', _tag);
    final pin = password ?? appStore.settings.cachedPin;
    if (pin.isEmpty) return const NewAccountResult(NewAccountResultType.emptyPassword);
    return _importAccount(appStore, webApi, pin);
  }

  @action
  Future<NewAccountResult> _generateAccount(AppStore appStore, Api webApi, String pin) async {
    Log.d('_generateAccount: pin = $pin', _tag);
    try {
      _loading = true;
      appStore.settings.setPin(pin);
      final key = await webApi.account.generateAccount();
      final acc = await webApi.account.importAccount(key: key, password: pin);
      if (acc['error'] != null) {
        _loading = false;
        return const NewAccountResult(NewAccountResultType.error);
      }
      final addresses = await webApi.account.encodeAddress([acc['pubKey'] as String]);
      acc['address'] = addresses[0];
      return saveAccount(webApi, appStore, acc, pin);
    } catch (e, s) {
      _loading = false;
      Log.e('generate account', '$e', s);
      return const NewAccountResult(NewAccountResultType.error);
    }
  }

  @action
  Future<NewAccountResult> _importAccount(AppStore appStore, Api webApi, String pin) async {
    Log.d('_importAccount: pin = $pin', _tag);
    try {
      _loading = true;
      appStore.settings.setPin(pin);
      assert(accountKey != null && accountKey!.isNotEmpty, 'accountKey can not be null or empty');
      final acc = await webApi.account.importAccount(
        key: accountKey!,
        password: pin,
        keyType: keyType.name,
      );
      if (acc['error'] != null) {
        _loading = false;
        return const NewAccountResult(NewAccountResultType.error);
      } else {
        final addresses = await webApi.account.encodeAddress([acc['pubKey'] as String]);
        acc['address'] = addresses[0];
        final index = appStore.account.accountList.indexWhere((i) => i.pubKey == acc['pubKey']);
        if (index > -1) {
          _loading = false;
          return NewAccountResult(NewAccountResultType.duplicateAccount, newAccountData: acc);
        }
        return saveAccount(webApi, appStore, acc, pin);
      }
    } catch (e, s) {
      _loading = false;
      Log.e('import account', '$e', s);
      return const NewAccountResult(NewAccountResultType.error);
    }
  }

  @action
  Future<NewAccountResult> saveAccount(Api webApi, AppStore appStore, Map<String, dynamic> acc, String pin) async {
    Log.d('saveAccount: acc = $acc, pin = $pin', _tag);
    await appStore.addAccount(acc, pin, acc['address'] as String, name: name);
    await appStore.setCurrentAccount(acc['pubKey'] as String?);
    await appStore.loadAccountCache();
    webApi.fetchAccountData();
    _loading = false;
    return NewAccountResult(NewAccountResultType.ok, newAccountData: acc);
  }
}

enum KeyType {
  mnemonic('mnemonic'),
  rawSeed('rawSeed'),
  keystore('keystore');

  const KeyType(this.key);

  final String key;
}
