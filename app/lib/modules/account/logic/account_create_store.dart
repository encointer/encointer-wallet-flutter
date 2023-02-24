import 'package:mobx/mobx.dart';

part 'account_create_store.g.dart';

class AccountCreate extends _AccountCreate with _$AccountCreate {}

abstract class _AccountCreate with Store {
  @observable
  String? name;

  @observable
  String? password;

  @observable
  String? key;

  @observable
  bool loading = false;

  @action
  void setName(String value) => name = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setKey(String? valeu) => key = valeu;

  @action
  void setLoading(bool valeu) => loading = valeu;

  @action
  void resetNewAccount() {
    name = null;
    password = null;
    key = null;
  }
}
