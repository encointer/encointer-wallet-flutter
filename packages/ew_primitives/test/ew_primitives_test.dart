import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/encointer_types.dart';
import 'package:ew_primitives/ew_primitives.dart';
import 'package:test/test.dart';

void main() {
  group('proof of attendance is valid', () {
    test('signed factory works', () async {
      final keyring = await testKeyring();
      final alice = keyring.accountsIter.first;

      final proof = ProofOfAttendanceFactory.signed(
        proverPublic: alice.pubKey,
        ceremonyIndex: 1,
        communityIdentifier: const CommunityIdentifier(
          geohash: [0, 0, 0, 0, 0],
          digest: [0, 0, 0, 0],
        ),
        attendee: alice.pair,
      );

      print('${proof.encode()}');

      expect(true, true);
    });
  });
}
