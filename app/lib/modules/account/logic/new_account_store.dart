import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/modules/account/logic/key_type.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_keyring/ew_keyring.dart';

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
  String? accountKey;

  @observable
  KeyType keyType = KeyType.mnemonic;

  @readonly
  bool _loading = false;

  @action
  void setName(String? value) => name = value;

  @action
  void setKey(String? value) => accountKey = value;

  @action
  void setKeyType(KeyType value) => keyType = value;

  @action
  Future<NewAccountResult> generateAccount() async {
    return _generateAccount();
  }

  @action
  Future<NewAccountResult> importAccount() async {
    return _importAccount();
  }

  @action
  Future<NewAccountResult> _generateAccount() async {
    try {
      _loading = true;
      final keyringAccount = await KeyringAccount.generate(name!);
      // pin is ignored on JS-side
      final result = await webApi.account.importAccount(key: keyringAccount.uri, password: '');
      if (result['error'] != null) {
        _loading = false;
        return const NewAccountResult(NewAccountResultType.error);
      }

      return saveAccount(keyringAccount);
    } catch (e, s) {
      _loading = false;
      Log.e('generate account', '$e', s);
      return const NewAccountResult(NewAccountResultType.error);
    }
  }

  @action
  Future<NewAccountResult> _importAccount() async {
    try {
      _loading = true;
      assert(accountKey != null && accountKey!.isNotEmpty, 'accountKey can not be null or empty');
      final keyringAccount = await KeyringAccount.fromUri(name!, accountKey!);
      final result = await webApi.account.importAccount(
        key: accountKey!,
        password: '', // this is ignored on JS-side
        keyType: keyType.name,
      );
      if (result['error'] != null) {
        _loading = false;
        return const NewAccountResult(NewAccountResultType.error);
      } else {
        final index = appStore.account.accountList.indexWhere((i) => i.pubKey == keyringAccount.pubKeyHex);
        if (index > -1) {
          _loading = false;
          return NewAccountResult(NewAccountResultType.duplicateAccount, newAccount: keyringAccount);
        }
        return saveAccount(keyringAccount);
      }
    } catch (e, s) {
      _loading = false;
      Log.e('import account', '$e', s);
      return const NewAccountResult(NewAccountResultType.error);
    }
  }

  @action
  Future<NewAccountResult> saveAccount(KeyringAccount account) async {
    await appStore.addAccount(account);
    await appStore.setCurrentAccount(account.pubKeyHex);
    await appStore.loadAccountCache();
    webApi.fetchAccountData();
    _loading = false;
    return NewAccountResult(NewAccountResultType.ok, newAccount: account);
  }
}
