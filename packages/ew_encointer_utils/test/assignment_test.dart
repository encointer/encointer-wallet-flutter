// ignore_for_file: avoid_dynamic_calls

import 'package:collection/collection.dart' show IterableExtension;
import 'package:ew_encointer_utils/ew_encointer_utils.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/encointer_types.dart';
import 'package:ew_primitives/ew_primitives.dart';
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
    final testCase = CeremonyTestCase.fromJson(testCaseJson);

    for (final (i, meetup) in testCase.meetups.indexed) {
      test('meetup testcase $i', () {
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
  });
}

class CeremonyTestCase {
  const CeremonyTestCase({
    required this.cid,
    required this.cIndex,
    required this.assignment,
    required this.assignmentCount,
    required this.meetupCount,
    required this.meetups,
  });

  factory CeremonyTestCase.fromJson(Map<String, dynamic> json) {
    return CeremonyTestCase(
      cid: CommunityIdentifier(
        geohash: (json['communityCeremony'][0]['geohash'] as String).codeUnits,
        digest: (json['communityCeremony'][0]['digest'] as String).codeUnits,
      ),
      cIndex: json['communityCeremony'][1] as int,
      assignment: Assignment(
        bootstrappersReputables: AssignmentParams(
          m: BigInt.from(json['assignment']['bootstrappersReputables']['m'] as int),
          s1: BigInt.from(json['assignment']['bootstrappersReputables']['s1'] as int),
          s2: BigInt.from(json['assignment']['bootstrappersReputables']['s2'] as int),
        ),
        endorsees: AssignmentParams(
          m: BigInt.from(json['assignment']['endorsees']['m'] as int),
          s1: BigInt.from(json['assignment']['endorsees']['s1'] as int),
          s2: BigInt.from(json['assignment']['endorsees']['s2'] as int),
        ),
        newbies: AssignmentParams(
          m: BigInt.from(json['assignment']['newbies']['m'] as int),
          s1: BigInt.from(json['assignment']['newbies']['s1'] as int),
          s2: BigInt.from(json['assignment']['newbies']['s2'] as int),
        ),
        locations: AssignmentParams(
          m: BigInt.from(json['assignment']['locations']['m'] as int),
          s1: BigInt.from(json['assignment']['locations']['s1'] as int),
          s2: BigInt.from(json['assignment']['locations']['s2'] as int),
        ),
      ),
      assignmentCount: AssignmentCount(
        bootstrappers: BigInt.from(json['assignmentCount']['bootstrappers'] as int),
        reputables: BigInt.from(json['assignmentCount']['reputables'] as int),
        endorsees: BigInt.from(json['assignmentCount']['endorsees'] as int),
        newbies: BigInt.from(json['assignmentCount']['newbies'] as int),
      ),
      meetupCount: json['meetupCount'] as int,
      meetups: (json['meetups'] as List<dynamic>).map((e) => Meetup.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  final CommunityIdentifier cid;
  final int cIndex;

  final Assignment assignment;
  final AssignmentCount assignmentCount;

  final int meetupCount;

  final List<Meetup> meetups;
}

class Meetup {
  const Meetup({
    required this.meetupIndex,
    required this.location,
    required this.time,
    required this.registrations,
  });

  factory Meetup.fromJson(Map<String, dynamic> json) {
    return Meetup(
      meetupIndex: json['index'] as int,
      location: LocationFactory.fromDouble(lat: double.parse(json['location']['lat'] as String), lon: double.parse(json['location']['lon'] as String)),
      time: json['time'] as int,
      registrations:
          (json['registrations'] as List<dynamic>).map((e) => Registration.fromJson(e as List<dynamic>)).toList(),
    );
  }

  final int meetupIndex;
  final Location location;
  final int time;

  final List<Registration> registrations;
}

class Registration {
  const Registration({
    required this.address,
    required this.participantIndex,
    required this.participantType,
  });

  factory Registration.fromJson(List<dynamic> json) {
    return Registration(
      address: Address.decode(json[0] as String),
      participantIndex: json[1]['index'] as int,
      participantType: participantTypeFromString(json[1]['registrationType'] as String)!,
    );
  }

  final Address address;
  final int participantIndex;
  final ParticipantType participantType;
}

ParticipantType? participantTypeFromString(String value) {
  return getEnumFromString(ParticipantType.values, value);
}

T? getEnumFromString<T>(Iterable<T> values, String? value) {
  return values.firstWhereOrNull(
    (type) => type.toString().split('.').last.toUpperCase() == value.toString().split('.').last.toUpperCase(),
  );
}

const Map<String, dynamic> testCaseJson = {
  'communityCeremony': [
    {'geohash': '0x6476393434', 'digest': '0x2c175151'},
    3,
  ],
  'assignment': {
    'bootstrappersReputables': {'m': 17, 's1': 12, 's2': 4},
    'endorsees': {'m': 7, 's1': 1, 's2': 3},
    'newbies': {'m': 7, 's1': 6, 's2': 4},
    'locations': {'m': 9, 's1': 2, 's2': 7},
  },
  'assignmentCount': {'bootstrappers': 10, 'reputables': 8, 'endorsees': 10, 'newbies': 7},
  'meetupCount': 4,
  'meetups': [
    {
      'index': 1,
      'location': {'lat': '31.2962880000000005509', 'lon': '-54.74528200000000310865'},
      'time': 1647358560000,
      'registrations': [
        [
          '5DMJBbEgLXcmxUDS1EqaqmES4QADMwqRPP4F1rfAktrdt2c9',
          {'index': 2, 'registrationType': 'Reputable'},
        ],
        [
          '5D7YHgBUVxQKZAUQHd9DUp7Q7dm9EbR4zWBCjiqu2efGDuzN',
          {'index': 1, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5HbiGQg1mFwg8YCUdYYS3JSpooqdTNF28VBFmPdXhqFKh4tz',
          {'index': 8, 'registrationType': 'Reputable'},
        ],
        [
          '5EtPA6ALAWQJw2MEMcMCPaUZVsa1a34xivMHsbFAx4jpQ1x4',
          {'index': 7, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5DDEUCeVv7jp2qFm47FgUXx18r98tzGA7nRcN9EB2g1PSGbA',
          {'index': 3, 'registrationType': 'Reputable'},
        ],
        [
          '5Fjas4GZUJ9Q6ePTftfLfsBLe79D89ujrr8MPsfVcojms4xD',
          {'index': 2, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5HBdsQW2doe38dHyh3n2hVVCxG3RbAXqtrmg6ePDAMxa4uXi',
          {'index': 5, 'registrationType': 'Endorsee'},
        ],
        [
          '5DiCgaczypwmFVNEFawWLqyUCTn5i42NQRbaQWnMeN8d5q9V',
          {'index': 2, 'registrationType': 'Endorsee'},
        ],
        [
          '5ECgUyyhbjpzw2XzXyMz3owTG7GGBmHsNRp4o753baebpwWh',
          {'index': 9, 'registrationType': 'Endorsee'},
        ],
        [
          '5GH95V5433abDV2TL61XqBMyM7JE7VDkYcrNWyJP5pPjJNHz',
          {'index': 5, 'registrationType': 'Newbie'},
        ],
        [
          '5CFNV4qYF22DLEffn1tnyHtHohrEXQmBsVJtWcMSzH7fS2C1',
          {'index': 1, 'registrationType': 'Newbie'},
        ]
      ],
    },
    {
      'index': 2,
      'location': {'lat': '31.2962880000000005509', 'lon': '-54.7242719999999991387'},
      'time': 1647358560000,
      'registrations': [
        [
          '5FLgx9bNsX4ZoJQ4hg1QV98y8LwSd48p8nQusWT8u97eFyFW',
          {'index': 5, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5GYMEKk6mtEExCVwEzu4GPFCvb3tDePNryv4d1bHg6UJnwdS',
          {'index': 1, 'registrationType': 'Reputable'},
        ],
        [
          '5Cz3h58y9k92YKPfSL84LmMzvhgS2eVysjgKznZ1qEhAgMN7',
          {'index': 7, 'registrationType': 'Reputable'},
        ],
        [
          '5HEAUd6wMDDmK5sVvG9BWVj2Ej2XSZgEpCr7LGBLGRpo3wti',
          {'index': 6, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5EhvAkh6TYvGqNxEFULzZYo9unwFrka4GhPby83PuS3xxUhg',
          {'index': 6, 'registrationType': 'Endorsee'},
        ],
        [
          '5EsoqMe9ZZhGKeTugAVJL3oVXyY5daFAVaczLRUGVZ1munFs',
          {'index': 3, 'registrationType': 'Endorsee'},
        ],
        [
          '5HbsbWfYWuMaoytYXrfVNsHXavr5wAev8HqC4yBEfmzxeapC',
          {'index': 10, 'registrationType': 'Endorsee'},
        ],
        [
          '5GumUzWFr7wx9btS3UYHJQTkUNTZfgKEbxBipKSbkZ23Nsak',
          {'index': 4, 'registrationType': 'Newbie'},
        ],
        [
          '5ECnkPCrFEvrkfcPZ7qw3Srrh7XYkKQXLKk97zJLBrJYH9rS',
          {'index': 7, 'registrationType': 'Newbie'},
        ]
      ],
    },
    {
      'index': 3,
      'location': {'lat': '31.3053069999999991069', 'lon': '-54.7347770000000011237'},
      'time': 1647358560000,
      'registrations': [
        [
          '5Hbpnh7BmpgD5fEWvhXKus9ZNDsHNFKkwuThn7ZJHuXHUbuj',
          {'index': 5, 'registrationType': 'Reputable'},
        ],
        [
          '5CmEECZepMv2CDiXT44jmQuDxfv9GcjKJuBd6EwCEhBY7hUk',
          {'index': 4, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5He82NUxbEkzwoiqvmPGCrbSWDVtJXtg9VcF6GRs4yJFM7R1',
          {'index': 10, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5EngbYkE7dLJrp1a3wTpdMJXCZr1pKWUY4pNfCVT4PkMC8u5',
          {'index': 6, 'registrationType': 'Reputable'},
        ],
        [
          '5H3m7voDdXMbCxfgETYvhcy4N15upcZ7YEvQi9w4QmNvFifh',
          {'index': 7, 'registrationType': 'Endorsee'},
        ],
        [
          '5E2fnjYfPrtcH6DqExDGTcsMzZ4ogpLvsJ9q8raoQic1WC3K',
          {'index': 4, 'registrationType': 'Endorsee'},
        ],
        [
          '5HpQ6hNCx4RUWTYsnh4hG4QLqQeADHqHVFxEtrmMyr3ykrvy',
          {'index': 3, 'registrationType': 'Newbie'},
        ],
        [
          '5CM2xmTJcwU4ebTbzjGZYAaW1btqH83C8m2sE7irKmcV8jH2',
          {'index': 6, 'registrationType': 'Newbie'},
        ]
      ],
    },
    {
      'index': 4,
      'location': {'lat': '31.31432600000000121554', 'lon': '-54.74528200000000310865'},
      'time': 1647358560000,
      'registrations': [
        [
          '5DCLyStXJFxAaUCdaWLCEUgGmnRY3mY9RgHNiwYyvxpQyVdn',
          {'index': 8, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5HRFE7m8pqozZ39xSSWGtq9qcnn6qYqEFLV5AN7tURzbckDG',
          {'index': 4, 'registrationType': 'Reputable'},
        ],
        [
          '5FCQhQAbnzGnnDpqhgZP1XUmymQnsb5Xw6sJXHFjeyihB4u8',
          {'index': 3, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5FX4dWmZ4xNPiV1i7AsmjXZzEdP2dCPxT88wt3A1gjyo3Tpv',
          {'index': 9, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5HQPCokWX9PhV6NmSv54TwwF4wGe1qi7qwoV9j592eWVmzbZ',
          {'index': 1, 'registrationType': 'Endorsee'},
        ],
        [
          '5D87QaJWQKdo2FReKWRK9GTaPwt3JH48ZLhrQqKP61iMSf6G',
          {'index': 8, 'registrationType': 'Endorsee'},
        ],
        [
          '5GYquk1ZS8ZhydK7XGsnzyQcGaoSFVQKZ53wNCwySc4hPLwT',
          {'index': 2, 'registrationType': 'Newbie'},
        ]
      ],
    }
  ],
};
