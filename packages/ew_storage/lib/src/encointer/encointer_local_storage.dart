import 'package:ew_storage/src/encointer/interfaces/encointer_storage_interface.dart';
import 'package:ew_storage/src/storages/sync_storage.dart';

class EncointerLocalStorage extends SyncStorage implements EncointerStorageInterface {
  const EncointerLocalStorage(super.storage);

  // local keys
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
    return removeItemFromList(key: accountsKey, itemKey: 'pubKey', itemValue: pubKey);
  }

  @override
  List<Map<String, dynamic>> getAccountList() {
    return getValueJsonDecode<List<Map<String, dynamic>>>(accountsKey) ?? [];
  }

  @override
  Future<void> addAccount(Map<String, dynamic> acc) {
    return addItemToList(key: accountsKey, newItem: acc);
  }

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

  @override
  Map<String, dynamic>? getSeeds(String seedType) {
    return getValueJsonDecode<Map<String, dynamic>>('${seedKey}_$seedType');
  }

  // ----------- contact methods --------------
  @override
  List<Map<String, dynamic>> getContactList() {
    return getValueJsonDecode<List<Map<String, dynamic>>>(accountsKey) ?? [];
  }

  @override
  Future<void> addContact(Map<String, dynamic> contact) {
    return addItemToList(key: contactsKey, newItem: contact);
  }

  @override
  Future<void> removeContact(String address) {
    return removeItemFromList(key: contactsKey, itemKey: 'address', itemValue: address);
  }

  @override
  Future<void> updateContact(Map<String, dynamic> con) {
    return updateItemInList(
      key: contactsKey,
      itemKey: 'address',
      itemValue: con['address'] as String?,
      itemNew: con,
    );
  }

  // ----------- other methods --------------
  @override
  Future<void> setLocale([String languageCode = 'en']) {
    return storage.setString(key: localKey, value: languageCode);
  }
}
