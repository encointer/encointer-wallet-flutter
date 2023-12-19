import 'package:ew_keyring/src/keyring_account.dart';
import 'package:ew_keyring/src/validate_keys.dart';
import 'package:test/test.dart';

void main() {
  group('KeyringAccount', () {
    test('newValidated constructor works', () {
      final alice = KeyringAccount.newValidated('Alice', '//Alice');
      final bob = KeyringAccount.newValidated('Bob', '0x398f0c28f98885e046333d4a41c19cee4c37368a9832c6502f6cfd182e2aef89');
      final bob2 = KeyringAccount.newValidated('Bob', '398f0c28f98885e046333d4a41c19cee4c37368a9832c6502f6cfd182e2aef89');
      final testAccount = KeyringAccount('TestAccount', 'spray trust gown toast route merge awful sight ghost all degree exit');

      expect(alice.seedType, SeedType.raw);
      expect(bob.seedType, SeedType.privateKey);
      expect(bob2.seedType, SeedType.privateKey);
      expect(testAccount.seedType, SeedType.mnemonic);
    });

    test('newValidated throws exception for invalid seeds', () {
      expect(() => KeyringAccount.newValidated('Alice', 'Alice'), throwsA(isException));
      expect(() => KeyringAccount.newValidated('Alice', 'trust gown toast route merge awful sight ghost all degree exit'), throwsA(isException));
    });
  });
}
