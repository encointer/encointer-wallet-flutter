// ignore_for_file: avoid_dynamic_calls

import 'package:collection/collection.dart' show IterableExtension;
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/encointer_types.dart';
import 'package:ew_primitives/ew_primitives.dart';

part 'test_case_data.dart';

final ceremonyTestCases = _ceremonyTestCases.map(CeremonyTestCase.fromJson).toList();

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
