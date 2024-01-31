import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/encointer_types.dart';
import 'package:ew_primitives/ew_primitives.dart';
import 'package:test/test.dart';

void main() {
  group('proof of attendance is valid', () {
    // That this works has been verified with the following dart test in the encointer-primitives crate.
    // 	#[test]
    // 	fn proof_of_attendance_from_dart_is_valid() {
    //    // output from below test
    // 		let proof_encoded = [
    // 			212, 53, 147, 199, 21, 253, 211, 28, 97, 20, 26, 189, 4, 169, 159, 214, 130, 44, 133,
    // 			88, 133, 76, 205, 227, 154, 86, 132, 231, 165, 109, 162, 125, 1, 0, 0, 0, 0, 0, 0, 0,
    // 			0, 0, 0, 0, 0, 212, 53, 147, 199, 21, 253, 211, 28, 97, 20, 26, 189, 4, 169, 159, 214,
    // 			130, 44, 133, 88, 133, 76, 205, 227, 154, 86, 132, 231, 165, 109, 162, 125, 1, 10, 30,
    // 			92, 58, 138, 172, 75, 244, 24, 86, 168, 249, 74, 210, 149, 46, 215, 79, 92, 142, 107,
    // 			144, 63, 163, 111, 52, 103, 140, 116, 226, 103, 105, 92, 71, 109, 134, 195, 221, 247,
    // 			96, 180, 72, 199, 219, 203, 37, 20, 227, 170, 90, 193, 47, 230, 199, 197, 196, 238, 33,
    // 			70, 74, 18, 38, 125, 129,
    // 		];
    // 		let proof =
    // 			ProofOfAttendance::<Signature, _>::decode(&mut proof_encoded.as_slice()).unwrap();
    //
    // 		assert!(proof.verify_signature())
    // 	}
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

      // ignore: avoid_print
      print('${proof.encode()}');
    });
  });
}
