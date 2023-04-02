
abstract class EncointerStorageInterface {
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
