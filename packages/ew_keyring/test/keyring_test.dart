import 'package:convert/convert.dart';
import 'package:ew_keyring/src/keyring.dart';
import 'package:ew_keyring/src/keyring_account.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  Future<EncointerKeyring> testKeyring() async {
    final alice = await KeyringAccount.fromUri('Alice', '//Alice');
    final bob = await KeyringAccount.fromUri('Bob', '//Bob');
    final charlie = await KeyringAccount.fromUri('Charlie', '//Charlie');
    final accounts = [alice, bob, charlie];
    final keyring = EncointerKeyring.fromAccounts(accounts);

    // ignore: avoid_print
    print('keyring: ${keyring.accounts}');
    return keyring;
  }

  group('Keyring', () {
    test('Keyring.getPairByAddress works', () async {
      final keyring = await testKeyring();

      final alicePair = keyring.getPairByAddress('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(alicePair.address, '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(alicePair.keyPairType, KeyPairType.sr25519);
    });

    test('Keyring.getAccountByAddress works', () async {
      final keyring = await testKeyring();
      final aliceAccount = keyring.getAccountByAddress('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(aliceAccount.name, 'Alice');
    });

    test('Keyring.getPairByPublicKey works', () async {
      final keyring = await testKeyring();

      final alicePair =
          keyring.getPairByPublicKey(hex.decode('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'));

      expect(alicePair.address, '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(alicePair.keyPairType, KeyPairType.sr25519);
    });

    test('Keyring.getAccountByPublicKey works', () async {
      final keyring = await testKeyring();

      final aliceAccount =
          keyring.getAccountByPublicKey(hex.decode('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'));

      expect(aliceAccount.name, 'Alice');
    });

    test('test alice works', () async {
      final pair = await KeyPair.sr25519.fromMnemonic('//Alice');
      expect(
        pair.address,
        '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
      );
    });
  });

  group('De-/Serialization', () {
    test('round trip works', () async {
      final keyring = await testKeyring();

      final serialized = keyring.serializeAccounts();
      final newKeyring = await EncointerKeyring.fromDeserialized(serialized);

      expect(serialized, newKeyring.serializeAccounts());
    });
  });
}
