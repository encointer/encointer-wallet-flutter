import 'package:ew_keyring/src/keyring_account.dart';
import 'package:test/test.dart';

void main() {
  group('KeyringAccount', () {
    test('fromUri works with raw seed', () async {
      final alice = await KeyringAccount.fromUri('Alice', '//Alice');
      expect(alice.pubKeyHex, '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
    });

    test('fromUri works with secret seed', () async {
      final bob =
          await KeyringAccount.fromUri('Bob', '0x398f0c28f98885e046333d4a41c19cee4c37368a9832c6502f6cfd182e2aef89');
      expect(bob.pubKeyHex, '0x8eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a48');
    });

    test('fromUri works with mnemonic', () async {
      final testAccount = await KeyringAccount.fromUri(
        'TestAccount',
        'spray trust gown toast route merge awful sight ghost all degree exit',
      );
      expect(testAccount.pubKeyHex, '0xb660d62fac33c2502dac4d65efbb31ae16454aa8d62e7f6c78ad9245054cc46b');
    });

    test('newValidated throws exception for invalid seeds', () {
      expect(() => KeyringAccount.fromUri('Alice', 'Alice'), throwsA(isException));
      expect(
        () => KeyringAccount.fromUri('Alice', 'trust gown toast route merge awful sight ghost all degree exit'),
        throwsA(isException),
      );
    });
  });
}
