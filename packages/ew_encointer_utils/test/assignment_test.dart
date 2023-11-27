// ignore_for_file: avoid_dynamic_calls

import 'package:ew_encointer_utils/ew_encointer_utils.dart';
import 'package:ew_polkadart/encointer_types.dart';
import 'package:test/test.dart';

import 'ceremony_test_case/ceremony_test_case.dart';

class MeetupTimeTestCase {
  MeetupTimeTestCase({
    required this.description,
    required this.longitude,
    required this.offset,
    required this.expected,
  });

  /// Semantics the test case wants to ensure.
  final String description;

  /// Longitude of the meetup location.
  final double longitude;

  /// Global `MeetupTimeOffset` of the encointer chain.
  final int offset;

  /// Expected result in ms units.
  final int expected;
}

void main() {
  group('meetupTime', () {
    final meetupTimeTestCases = [
      MeetupTimeTestCase(description: 'is correct without offset', longitude: 20, offset: 0, expected: 160),
      MeetupTimeTestCase(description: 'is correct for non-integer results', longitude: 19.5, offset: 0, expected: 161),
      MeetupTimeTestCase(description: 'is correct for positive offset', longitude: 20, offset: 1, expected: 161),
      MeetupTimeTestCase(
        description: 'is correct result for negative offset',
        longitude: 20,
        offset: -1,
        expected: 159,
      ),
    ];

    for (final testCase in meetupTimeTestCases) {
      test(testCase.description, () {
        expect(meetupTime(testCase.longitude, 0, testCase.offset, 360), testCase.expected);
      });
    }
  });

  group('assignmentFn', () {
    test('assignmentFn works', () {
      const pIndex = 6;
      final params = AssignmentParams(m: BigInt.from(4), s1: BigInt.from(5), s2: BigInt.from(3));
      const assignmentCount = 5;

      expect(assignmentFn(pIndex, params, assignmentCount), 1);
    });
  });

  group('meetupIndex', () {
    test('meetupIndex works', () {
      const pIndex = 6;
      final params = AssignmentParams(m: BigInt.from(4), s1: BigInt.from(5), s2: BigInt.from(3));
      const assignmentCount = 5;

      expect(meetupIndex(pIndex, params, assignmentCount), 2);
    });
  });

  group('computeMeetupIndex', () {
    for (final (i, testCase) in ceremonyTestCases.indexed) {
      for (final (j, meetup) in testCase.meetups.indexed) {
        test('testcase $i, meetup: $j', () {
          expect(
            computeMeetupIndex(
              meetup.registrations[1].participantIndex,
              meetup.registrations[1].participantType,
              testCase.assignment,
              testCase.assignmentCount,
              testCase.meetupCount,
            ),
            meetup.meetupIndex,
          );
        });
      }
    }
  });
}
