import 'dart:typed_data';

import 'package:ew_keyring/src/keyring_data.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

/// The public key (as a list of integers).
typedef Pubkey = String;

/// Keyring that is stored on the devices encrypted storage.
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

  Future<void> addAccounts(List<KeyringAccount> keyringAccounts) async {
    keyringAccounts.forEach(addAccount);
  }

  Future<void> addAccount(KeyringAccount keyringAccount) async {
    final pair = switch (keyringAccount.type) {
      SeedType.raw => KeyPair.fromSeed(Uint8List.fromList(keyringAccount.seed.codeUnits)),
      SeedType.privateKey => KeyPair.fromSeed(Uint8List.fromList(keyringAccount.seed.codeUnits)),
      SeedType.mnemonic => await KeyPair.fromMnemonic(keyringAccount.seed),
    };

    keyring.add(pair);
    // same as what keyring does internally.
    accounts[_publicKey(pair).toString()] = keyringAccount;
  }

  KeyPair getPairByPublicKey(List<int> publicKey) {
    return keyring.getByPublicKey(publicKey);
  }

  KeyringAccount getAccountByPublicKey(List<int> publicKey) {
    if (accounts[publicKey.toString()] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return accounts[publicKey.toString()]!;
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

  /// Get a List<int> as string, this is the same as the keyring internally uses
  /// to add a pair.
  List<int> _publicKey(KeyPair pair) {
    return keyring.decodeAddress(pair.address);
  }
}
