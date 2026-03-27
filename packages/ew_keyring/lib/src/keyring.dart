import 'package:convert/convert.dart';
import 'package:ew_keyring/ew_keyring.dart' show AddressUtils, KeyringAccount, KeyringAccountData, KeyringUtils;
import 'package:polkadart_keyring/polkadart_keyring.dart';

/// The public key (as a list of integers).
typedef Pubkey = String;

/// Keyring to handle the accounts and their metadata.
class EncointerKeyring {
  EncointerKeyring() : _accounts = {};

  factory EncointerKeyring.fromAccounts(List<KeyringAccount> accounts) {
    return EncointerKeyring()..addAccounts(accounts);
  }

  final Map<Pubkey, KeyringAccount> _accounts;

  static Future<EncointerKeyring> fromAccountData(List<KeyringAccountData> accounts) async {
    // Derive keys one at a time, yielding to the event loop between each
    // derivation to prevent ANR. Each BIP39+Sr25519 derivation takes
    // ~200-500ms on ARMv7a; without yielding, N accounts block the main
    // thread for N×500ms continuously (exceeds 5s ANR threshold at ~10 accounts).
    final keyring = EncointerKeyring();
    for (final acc in accounts) {
      final keyringAccount = await KeyringAccount.fromUri(acc.name, acc.uri);
      keyring.addAccount(keyringAccount);
      // Allow the event loop to process input events and render frames.
      await Future<void>.delayed(Duration.zero);
    }
    return keyring;
  }

  String serializeAccounts() {
    return KeyringUtils.serializeAccountData(_accounts.values.map((a) => a.toAccountData()).toList(growable: false));
  }

  static Future<EncointerKeyring> fromSerialized(String accounts) async {
    final data = KeyringUtils.deserializeAccountData(accounts);
    return EncointerKeyring.fromAccountData(data);
  }

  void addAccounts(List<KeyringAccount> keyringAccounts) {
    // Need to call to list here to evaluate the iterator.
    keyringAccounts.map(addAccount).toList();
  }

  void addAccount(KeyringAccount keyringAccount) {
    _accounts[keyringAccount.pubKey.toString()] = keyringAccount;
  }

  List<KeyringAccount> get accounts => _accounts.values.toList();

  Iterable<KeyringAccount> get accountsIter => _accounts.values;

  List<KeyringAccountData> get accountDatas => accountsIter.map((a) => a.toAccountData()).toList();

  KeyPair getPairByPublicKey(List<int> publicKey) {
    return getAccountByPublicKey(publicKey).pair;
  }

  KeyPair getPairByAddress(String address) {
    return getAccountByAddress(address).pair;
  }

  KeyringAccount getAccountByPublicKey(List<int> publicKey) {
    if (_accounts[publicKey.toString()] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return _accounts[publicKey.toString()]!;
  }

  KeyringAccount getAccountByPubKeyHex(String pubKeyHex) {
    final publicKey = hex.decode(pubKeyHex.replaceFirst('0x', ''));
    if (_accounts[publicKey.toString()] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return _accounts[publicKey.toString()]!;
  }

  KeyringAccount getAccountByAddress(String address) {
    final publicKey = AddressUtils.addressToPubKey(address).toString();
    if (_accounts[publicKey] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return _accounts[publicKey]!;
  }

  void remove(List<int> publicKey) {
    _accounts.remove(publicKey.toString());
  }

  /// Remove all key pairs from the keyring.
  void clear() {
    _accounts.clear();
  }
}

Future<EncointerKeyring> testKeyring() async {
  final alice = await KeyringAccount.fromUri('Alice', '//Alice');
  final bob = await KeyringAccount.fromUri('Bob', '//Bob');
  final charlie = await KeyringAccount.fromUri('Charlie', '//Charlie');
  final accounts = [alice, bob, charlie];
  final keyring = EncointerKeyring.fromAccounts(accounts);

  return keyring;
}
