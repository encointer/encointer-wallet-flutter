import 'package:ew_keyring/ew_keyring.dart' show KeyringUtils, KeyringAccount;
import 'package:polkadart_keyring/polkadart_keyring.dart';

/// The public key (as a list of integers).
typedef Pubkey = String;

/// Keyring to handle the accounts and their metadata.
class EncointerKeyring {
  EncointerKeyring()
      : keyring = Keyring(),
        accounts = {};

  static Future<EncointerKeyring> fromAccounts(List<KeyringAccount> accounts) async {
    final k = EncointerKeyring();
    await k.addAccounts(accounts);
    return k;
  }

  final Keyring keyring;
  final Map<Pubkey, KeyringAccount> accounts;

  String serializeAccounts() {
    return KeyringUtils.serializeAccounts(accounts.values.toList(growable: false));
  }

  static Future<EncointerKeyring> fromDeserialized(String accounts) {
    return EncointerKeyring.fromAccounts(KeyringUtils.deserializeAccounts(accounts));
  }

  Future<void> addAccounts(List<KeyringAccount> keyringAccounts) async {
    await Future.wait(keyringAccounts.map(addAccount));
  }

  Future<void> addAccount(KeyringAccount keyringAccount) async {
    final pair = await KeyPair.sr25519.fromMnemonic(keyringAccount.seed);
    keyring.add(pair);
    // same as what keyring does internally.
    accounts[_publicKey(pair).toString()] = keyringAccount;
  }

  KeyPair getPairByPublicKey(List<int> publicKey) {
    return keyring.getByPublicKey(publicKey);
  }

  KeyPair getPairByAddress(String address) {
    return keyring.pairs.getByAddress(address);
  }

  KeyringAccount getAccountByPublicKey(List<int> publicKey) {
    if (accounts[publicKey.toString()] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return accounts[publicKey.toString()]!;
  }

  KeyringAccount getAccountByAddress(String address) {
    final publicKey = keyring.decodeAddress(address).toList().toString();
    if (accounts[publicKey] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return accounts[publicKey]!;
  }

  void remove(List<int> publicKey) {
    keyring.pairs.removeByPublicKey(publicKey);
    accounts.remove(publicKey.toString());
  }

  /// Remove all key pairs from the keyring.
  void clear() {
    keyring.clear();
    accounts.clear();
  }

  /// Get a public key as a List<int> of [pair],
  List<int> _publicKey(KeyPair pair) {
    return keyring.decodeAddress(pair.address);
  }
}
