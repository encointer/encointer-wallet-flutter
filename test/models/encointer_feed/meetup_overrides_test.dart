import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/models/encointer_feed/meetup_overrides.dart';

void main() {
  group('meetupOverrides', () {
    test('Parses Response', () async {
      const response = '''
      [
        {
          "override-name": "Polkadot Decoded Demo 2022",
          "network": "nctr-gsl",
          "communities": [
            "u33e0719fDB",
            "69y7j4ZEXmy"
          ],
          "meetup-times": [
            "2022-06-29T11:30:00.00+00:00",
            "2022-06-29T16:30:00.00+00:00",
            "2022-06-29T21:00:00.00+00:00",
            "2022-06-30T11:30:00.00+00:00",
            "2022-06-30T16:30:00.00+00:00",
            "2022-06-30T20:00:00.00+00:00"
          ]
        }
      ]''';

      final list = jsonDecode(response) as List;

      final meetupOverrides = list.map((e) => MeetupOverrides.fromJson(e as Map<String, dynamic>)).toList();
      final override = meetupOverrides[0];

      expect(override.overrideName, 'Polkadot Decoded Demo 2022');
      expect(override.communities, ['u33e0719fDB', '69y7j4ZEXmy']);
      expect(override.meetupTimes![0].isAtSameMomentAs(DateTime.parse('2022-06-29T11:30:00.00+00:00')), true);
    });

    test('getNextMeetupTimeWorks', () async {
      // meetup times from decoded demos.

      final beforeAll = DateTime.parse('2022-06-29T11:20:00.00+00:00');
      final meetup1 = DateTime.parse('2022-06-29T11:30:00.00+00:00');
      final between1And2 = DateTime.parse('2022-06-29T12:20:00.00+00:00');
      final meetup2 = DateTime.parse('2022-06-29T16:30:00.00+00:00');
      final between2And3 = DateTime.parse('2022-06-29T17:20:00.00+00:00');
      final meetup3 = DateTime.parse('2022-06-29T21:00:00.00+00:00');
      final between3And4 = DateTime.parse('2022-06-30T10:20:00.00+00:00');
      final meetup4 = DateTime.parse('2022-06-30T11:30:00.00+00:00');
      final between4And5 = DateTime.parse('2022-06-30T11:31:00.00+00:00');
      final meetup5 = DateTime.parse('2022-06-30T16:30:00.00+00:00');
      final between5And6 = DateTime.parse('2022-06-30T17:10:00.00+00:00');
      final meetup6 = DateTime.parse('2022-06-30T20:00:00.00+00:00');
      final afterAll = DateTime.parse('2022-06-31T17:10:00.00+00:00');

      // shuffle to test the internal sorting
      final testMeetups = [
        meetup6,
        meetup1,
        meetup4,
        meetup3,
        meetup2,
        meetup5,
      ];

      final meetupOverrides = MeetupOverrides('hello', 'world', [], testMeetups);

      // get next meetup time if we are in registering or assigning phase
      expect(meetupOverrides.getNextMeetupTime(beforeAll, CeremonyPhase.Assigning)!.isAtSameMomentAs(meetup1), true);
      expect(
          meetupOverrides.getNextMeetupTime(between1And2, CeremonyPhase.Registering)!.isAtSameMomentAs(meetup2), true);
      expect(meetupOverrides.getNextMeetupTime(between2And3, CeremonyPhase.Assigning)!.isAtSameMomentAs(meetup3), true);
      expect(
          meetupOverrides.getNextMeetupTime(between3And4, CeremonyPhase.Registering)!.isAtSameMomentAs(meetup4), true);
      expect(meetupOverrides.getNextMeetupTime(between4And5, CeremonyPhase.Assigning)!.isAtSameMomentAs(meetup5), true);
      expect(
          meetupOverrides.getNextMeetupTime(between5And6, CeremonyPhase.Registering)!.isAtSameMomentAs(meetup6), true);
      expect(meetupOverrides.getNextMeetupTime(afterAll, CeremonyPhase.Registering), null);

      // get meetup time of the current meetup if we are in attesting phase
      expect(meetupOverrides.getNextMeetupTime(beforeAll, CeremonyPhase.Attesting), null);
      expect(meetupOverrides.getNextMeetupTime(between1And2, CeremonyPhase.Attesting)!.isAtSameMomentAs(meetup1), true);
      expect(meetupOverrides.getNextMeetupTime(between2And3, CeremonyPhase.Attesting)!.isAtSameMomentAs(meetup2), true);
      expect(meetupOverrides.getNextMeetupTime(between3And4, CeremonyPhase.Attesting)!.isAtSameMomentAs(meetup3), true);
      expect(meetupOverrides.getNextMeetupTime(between4And5, CeremonyPhase.Attesting)!.isAtSameMomentAs(meetup4), true);
      expect(meetupOverrides.getNextMeetupTime(between5And6, CeremonyPhase.Attesting)!.isAtSameMomentAs(meetup5), true);
      expect(meetupOverrides.getNextMeetupTime(afterAll, CeremonyPhase.Attesting)!.isAtSameMomentAs(meetup6), true);
    });
  });
}
