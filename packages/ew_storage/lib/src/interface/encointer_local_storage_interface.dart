import 'package:ew_storage/src/interface/storage_interface_sync_read.dart';

abstract class EncointerLocalStorageInterface {
  const EncointerLocalStorageInterface(this.storage);

  final StorageInterfaceSyncRead storage;

  // ----------- base methods --------------
  String? getString(String key);
  Future<void> setString({required String key, required String value});

  bool? getBool(String key);
  Future<void> setBool({required String key, required bool value});

  int? getInt(String key);
  Future<void> setInt({required String key, required int value});

  double? getDouble(String key);
  Future<void> setDouble({required String key, required double value});

  List<String>? getListString(String key);
  Future<void> setListString({required String key, required List<String> value});

  Future<void> addItemToList(String key, Map<String, dynamic> acc);
  Future<void> removeItemFromList(String key, String itemKey, String itemValue);
  Future<void> updateItemInList(String key, String itemKey, String? itemValue, Map<String, dynamic> itemNew);

  T? getValueJsonDecode<T>(String key);
  Future<void> setValueJsonEncode<T>(String key, T value);

  Future<T?> getValueJsonDecodeCompute<T>(String key);
  Future<void> setValueJsonEncodeCompute<T>(String key, T value);

  Future<void> removeKey(String key);
  Future<void> clear();

  // ----------- account methods --------------
  String? getCurrentAccount();
  Future<void> setCurrentAccount(String pubKey);
  Future<void> removeAccount(String pubKey);

  List<Map<String, dynamic>> getAccountList();
  Future<void> addAccount(Map<String, dynamic> acc);

  Object? getAccountCache(String? accPubKey, String key);
  Future<void> setAccountCache(String accPubKey, String key, Object? value);

  // ----------- contact methods --------------
  List<Map<String, dynamic>> getContactList();

  Future<void> addContact(Map<String, dynamic> contact);
  Future<void> removeContact(String address);
  Future<void> updateContact(Map<String, dynamic> con);

  // ----------- community methods --------------
  Map<String, dynamic>? getSeeds(String seedType);

  // Check can we delete this method
  Future<void> setLocale([String languageCode = 'en']);
}
