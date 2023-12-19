import 'package:ew_keyring/src/keyring.dart';
import 'package:ew_keyring/src/keyring_data.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  group('Keyring', () {

    Future<EncointerKeyring> testKeyring() async {
      final alice = KeyringAccount.newValidated('Alice', '//Alice');
      final bob = KeyringAccount.newValidated('Bob', '//Bob');
      final charlie = KeyringAccount.newValidated('Charlie', '//Charlie');
      final accounts = [alice, bob, charlie];
      final keyring = await EncointerKeyring.fromAccounts(accounts);

      // ignore: avoid_print
      print('keyring: ${keyring.accounts}');
      return keyring;
    }

    test('Keyring.getPairByAddress works', () async {
      final keyring = await testKeyring();

      final alicePair = keyring.getPairByAddress('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(alicePair.address, '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(alicePair.keyPairType, KeyPairType.sr25519);
    });

    test('Keyring.getByPublicKey works', () async {
      final keyring = await testKeyring();


      // final alicePair = keyring.getPairByPublicKey('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'.codeUnits);
      final aliceAccount =
      keyring.getAccountByPublicKey('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'.codeUnits);

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
}
