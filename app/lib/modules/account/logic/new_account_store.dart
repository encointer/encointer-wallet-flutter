import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/modules/account/logic/key_type.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:provider/provider.dart';

part 'new_account_store.g.dart';

class NewAccountStore extends _NewAccountStoreBase with _$NewAccountStore {
  NewAccountStore(super.appStore);
}

abstract class _NewAccountStoreBase with Store {
  _NewAccountStoreBase(this.appStore);

  final AppStore appStore;

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
  Future<NewAccountResult> generateAccount(BuildContext context) async {
    final pin = password ?? context.read<LoginStore>().cachedPin;
    if (pin == null) return const NewAccountResult(NewAccountResultType.emptyPassword);
    return _generateAccount(context, pin);
  }

  @action
  Future<NewAccountResult> importAccount(BuildContext context) async {
    final pin = password ?? context.read<LoginStore>().cachedPin;
    if (pin == null) return const NewAccountResult(NewAccountResultType.emptyPassword);
    return _importAccount(context, pin);
  }

  @action
  Future<NewAccountResult> _generateAccount(BuildContext context, String pin) async {
    try {
      _loading = true;
      final keyringAccount = await KeyringAccount.generate(name!);
      final result = await webApi.account.importAccount(key: keyringAccount.uri, password: pin);
      if (result['error'] != null) {
        _loading = false;
        return const NewAccountResult(NewAccountResultType.error);
      }

      await context.read<LoginStore>().setPin(pin);

      return saveAccount(keyringAccount, pin);
    } catch (e, s) {
      _loading = false;
      Log.e('generate account', '$e', s);
      return const NewAccountResult(NewAccountResultType.error);
    }
  }

  @action
  Future<NewAccountResult> _importAccount(BuildContext context, String pin) async {
    try {
      _loading = true;
      assert(accountKey != null && accountKey!.isNotEmpty, 'accountKey can not be null or empty');
      final keyringAccount = await KeyringAccount.fromUri(name!, accountKey!);
      final result = await webApi.account.importAccount(
        key: accountKey!,
        password: pin,
        keyType: keyType.name,
      );
      if (result['error'] != null) {
        _loading = false;
        return const NewAccountResult(NewAccountResultType.error);
      } else {
        await context.read<LoginStore>().setPin(pin);

        final index = appStore.account.accountList.indexWhere((i) => i.pubKey == keyringAccount.pubKeyHex);
        if (index > -1) {
          _loading = false;
          return NewAccountResult(NewAccountResultType.duplicateAccount, newAccount: keyringAccount);
        }
        return saveAccount(keyringAccount, pin);
      }
    } catch (e, s) {
      _loading = false;
      Log.e('import account', '$e', s);
      return const NewAccountResult(NewAccountResultType.error);
    }
  }

  @action
  Future<NewAccountResult> saveAccount(KeyringAccount account, String pin) async {
    await appStore.addAccount(account);
    await appStore.setCurrentAccount(account.pubKeyHex);
    await appStore.loadAccountCache();
    webApi.fetchAccountData();
    _loading = false;
    return NewAccountResult(NewAccountResultType.ok, newAccount: account);
  }
}
