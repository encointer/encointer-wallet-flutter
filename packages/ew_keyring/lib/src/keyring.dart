import 'package:ew_keyring/ew_keyring.dart' show KeyringUtils, KeyringAccount;
import 'package:ew_keyring/src/address_utils.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

/// The public key (as a list of integers).
typedef Pubkey = String;

/// Keyring to handle the accounts and their metadata.
class EncointerKeyring {
  EncointerKeyring() : accounts = {};

  factory EncointerKeyring.fromAccounts(List<KeyringAccount> accounts) {
    return EncointerKeyring()..addAccounts(accounts);
  }

  final Map<Pubkey, KeyringAccount> accounts;

  String serializeAccounts() {
    return KeyringUtils.serializeAccountData(accounts.values.map((a) => a.toAccountData()).toList(growable: false));
  }

  static Future<EncointerKeyring> fromDeserialized(String accounts) async {
    final keyringAccounts = await Future.wait([
      ...KeyringUtils.deserializeAccountData(accounts).map((acc) => KeyringAccount.fromUri(acc.name, acc.uri)),
    ]);
    return EncointerKeyring.fromAccounts(keyringAccounts);
  }

  void addAccounts(List<KeyringAccount> keyringAccounts) {
    // Need to call to list here to evaluate the iterator.
    keyringAccounts.map(addAccount).toList();
  }

  void addAccount(KeyringAccount keyringAccount) {
    accounts[keyringAccount.pubKey.toString()] = keyringAccount;
  }

  KeyPair getPairByPublicKey(List<int> publicKey) {
    return getAccountByPublicKey(publicKey).pair;
  }

  KeyPair getPairByAddress(String address) {
    return getAccountByAddress(address).pair;
  }

  KeyringAccount getAccountByPublicKey(List<int> publicKey) {
    if (accounts[publicKey.toString()] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return accounts[publicKey.toString()]!;
  }

  KeyringAccount getAccountByAddress(String address) {
    final publicKey = AddressUtils.addressToPubKey(address).toString();
    if (accounts[publicKey] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return accounts[publicKey]!;
  }

  void remove(List<int> publicKey) {
    accounts.remove(publicKey.toString());
  }

  /// Remove all key pairs from the keyring.
  void clear() {
    accounts.clear();
  }
}
