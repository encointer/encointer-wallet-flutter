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
    test('addressToPubKey with default prefix works works', () {
      final alice = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      final pubAlice = AddressUtils.addressToPubKey('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

      expect(alice.pubkey, pubAlice);
      expect(alice.toPubHex(), '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
    });

    test('addressToPubKey with prefix 2 works works', () {
      final alice = Address.decode('HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F');
      final pubAlice = AddressUtils.addressToPubKey('HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F');

      expect(alice.pubkey, pubAlice);
      expect(alice.toPubHex(), '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
    });

    test('addressToPubKeyHex with default prefix works works', () {
      final pubAlice = AddressUtils.addressToPubKeyHex('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(pubAlice, '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
    });

    test('addressToPubKeyHex with prefix 2 works works', () {
      final pubAlice = AddressUtils.addressToPubKeyHex('HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F');
      expect(pubAlice, '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
    });

    test('pubKeyToAddress with default prefix works', () {
      final alice = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

      final aliceAddress = AddressUtils.pubKeyToAddress(alice.pubkey);
      expect(aliceAddress, '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
    });

    test('pubKeyToAddress with prefix 2 works', () {
      final alice = Address.decode('HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F');

      final aliceAddress = AddressUtils.pubKeyToAddress(alice.pubkey, prefix: 2);
      expect(aliceAddress, 'HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F');
    });

    test('pubKeyHexToAddress with default prefix works', () {
      final aliceAddress =
          AddressUtils.pubKeyHexToAddress('0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
      expect(aliceAddress, '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
    });

    test('pubKeyHexToAddress with prefix 2 works', () {
      final aliceAddress = AddressUtils.pubKeyHexToAddress(
        '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d',
        prefix: 2,
      );
      expect(aliceAddress, 'HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F');
    });

    test('areEqual works with different prefixes', () {
      const alicePrefix2 = 'HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F';
      const alicePrefix42 = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
      expect(AddressUtils.areEqual(alicePrefix2, alicePrefix42), true);
    });

    test('areEqual works with same prefixes', () {
      const alicePrefix2 = 'HNZata7iMYWmk5RvZRTiAsSDhV8366zq2YGb3tLH5Upf74F';
      expect(AddressUtils.areEqual(alicePrefix2, alicePrefix2), true);
    });

    test('areEqual returns false for different addresses', () {
      const alicePrefix42 = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
      const bobPrefix42 = '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty';
      expect(AddressUtils.areEqual(alicePrefix42, bobPrefix42), false);
    });
  });
}
