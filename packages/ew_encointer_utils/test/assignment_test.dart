import 'package:ew_encointer_utils/ew_encointer_utils.dart';
import 'package:test/test.dart';

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
      const params = AssignmentParams(m: 4, s1: 5, s2: 3);
      const assignmentCount = 5;

      expect(assignmentFn(pIndex, params, assignmentCount), 1);
    });
  });
}
