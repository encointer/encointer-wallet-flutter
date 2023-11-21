import 'package:ew_keyring/ew_keyring.dart' show Address, AddressUtils, AddressExtension;
import 'package:test/test.dart';

void main() {
  group('AddressExtension', () {
    test('toPubHex works', () {
      final alice = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(alice.toPubHex(), '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
    });
  });

  group('AddressUtils', () {
    test('decodeToPubKey works', () {
      final alice = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      final pubAlice = AddressUtils.decodeToPubKey('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

      expect(alice.pubkey, pubAlice);
      expect(alice.toPubHex(), '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
    });

    test('decodeToPubKeyHex works', () {
      final pubAlice = AddressUtils.decodeToPubKeyHex('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(pubAlice, '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
    });

    test('encodeToAddress works', () {
      final alice = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

      final aliceAddress = AddressUtils.encodeToAddress(alice.pubkey);
      expect(aliceAddress, '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
    });
  });
}
