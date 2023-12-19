import 'package:ew_keyring/src/keyring_data.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

/// The public key (as a list of integers).
typedef Pubkey = String;

/// Keyring that is stored on the devices encrypted storage.
///
/// Note: This can't yet be used by encointer. It uses ed25519,
/// which is unfortunately not compatible with encointer. We have
/// to wait for sr25519 support from polkadart.
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

  /// Get a List<int> as string, this is the same as the keyring internally uses
  /// to add a pair.
  List<int> _publicKey(KeyPair pair) {
    return keyring.decodeAddress(pair.address);
  }
}
