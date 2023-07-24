import 'package:encointer_wallet/modules/account/logic/new_account_store.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:mobx/mobx.dart';
part 'keep_your_phrase_safe_view_store.g.dart';

// ignore: library_private_types_in_public_api
class KeppYourPhraseSaveViewStore = _KeppYourPhraseSaveViewStoreBase with _$KeppYourPhraseSaveViewStore;

abstract class _KeppYourPhraseSaveViewStoreBase with Store {
  _KeppYourPhraseSaveViewStoreBase(this._appStore, this._newAccountStore) {
    _init();
  }

  late final AppStore _appStore;

  late final NewAccountStore _newAccountStore;

  @observable
  bool loading = true;

  @observable
  String? seed;

  @observable
  String? error;

  @observable
  bool isChecked = false;

  Future<void> _init() async {
    await _getSeed();

    if (seed.isNotNullOrEmpty) {
      loading = false;
    } else {
      error = 'something went wrong';
    }
  }

  Future<void> _getSeed() async {
    seed = await _appStore.account.decryptSeed(
      _appStore.account.currentAccount.pubKey,
      AccountStore.seedTypeMnemonic,
      _newAccountStore.password!,
    );
  }

  void setIsChecked() {
    isChecked = !isChecked;
  }
}
