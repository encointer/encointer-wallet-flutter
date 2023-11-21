@Skip('These tests fail until we have sr25519 support')

import 'package:ew_keyring/src/keyring.dart';
import 'package:ew_keyring/src/keyring_data.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  group('Well known accounts', () {
    test('inferring key type works', () async {
      final alice = KeyringAccount('Alice', '//Alice');
      final bob = KeyringAccount('Bob', '//Bob');
      final charlie = KeyringAccount('Charlie', '//Charlie');
      final accounts = [alice, bob, charlie];
      final keyring = await EncointerKeyring.fromAccounts(accounts);

      // print("keyring: ${keyring.accounts.toString()}");
      // print("keyring: ${keyring.keyring.toString()}");

      final alicePair = keyring.keyring.getByAddress('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      // final alicePair = keyring.getPairByPublicKey('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'.codeUnits);
      final aliceAccount =
          keyring.getAccountByPublicKey('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'.codeUnits);

      expect(aliceAccount.name, 'Alice');
      expect(alicePair.address, '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
    });

    test('test alice works', () async {
      final pair = await KeyPair.fromMnemonic('//Alice');
      expect(
        pair.address,
        '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
      );
    });
  });
}
