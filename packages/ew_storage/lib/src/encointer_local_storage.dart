import 'package:ew_storage/src/interface/encointer.dart';
import 'package:ew_storage/src/storages/sync_storage.dart';

class EncointerLocalStorage extends SyncStorage implements EncointerStorageInterface {
  const EncointerLocalStorage(super.storage);


  /// local keys
  static const localKey = 'locale';
  static const accountsKey = 'wallet_account_list';
  static const currentAccountKey = 'wallet_current_account';
  static const contactsKey = 'wallet_contact_list';
  static const seedKey = 'wallet_seed';
  static const customKVKey = 'wallet_kv';

  // ----------- account methods --------------
  @override
  String? getCurrentAccount() => storage.getString(currentAccountKey);

  @override
  Future<void> setCurrentAccount(String pubKey) {
    return storage.setString(key: currentAccountKey, value: pubKey);
  }

  @override
  Future<void> removeAccount(String pubKey) {
    return removeItemFromList(accountsKey, 'pubKey', pubKey);
  }

  @override
  List<Map<String, dynamic>> getAccountList() {
    return getValueJsonDecode<List<Map<String, dynamic>>>(accountsKey) ?? [];
  }

  @override
  Future<void> addAccount(Map<String, dynamic> acc) => addItemToList(accountsKey, acc);

  @override
  Object? getAccountCache(String? accPubKey, String key) {
    final data = getValueJsonDecode<Map<String, dynamic>>(key);
    return data?[accPubKey];
  }

  @override
  Future<void> setAccountCache(String accPubKey, String key, Object? value) {
    final data = getValueJsonDecode<Map<String, dynamic>>(key) ?? {};
    data[accPubKey] = value;
    return setValueJsonEncode<Map<String, dynamic>>(key, data);
  }

  // ----------- contact methods --------------
  @override
  List<Map<String, dynamic>> getContactList() {
    return getValueJsonDecode<List<Map<String, dynamic>>>(accountsKey) ?? [];
  }

  @override
  Future<void> addContact(Map<String, dynamic> contact) => addItemToList(contactsKey, contact);

  @override
  Future<void> removeContact(String address) {
    return removeItemFromList(contactsKey, 'address', address);
  }

  @override
  Future<void> updateContact(Map<String, dynamic> con) {
    return updateItemInList(contactsKey, 'address', con['address'] as String?, con);
  }

  // ----------- community methods --------------
  @override
  Map<String, dynamic>? getSeeds(String seedType) {
    return getValueJsonDecode<Map<String, dynamic>>('${seedKey}_$seedType');
  }

  @override
  Future<void> setLocale([String languageCode = 'en']) {
    return storage.setString(key: localKey, value: languageCode);
  }
}
