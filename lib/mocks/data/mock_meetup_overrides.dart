import 'package:encointer_wallet/models/index.dart';

final testMeetup1 = DateTime.parse('2022-06-26T11:30:00.00+00:00');
final testMeetup2 = DateTime.parse('2022-06-26T16:30:00.00+00:00');

// meetup override for `bootstrap_demo_community
final testMeetupOverrides = [
  MeetupOverrides('Test', 'nctr-gsl-dev', ['sqm1v79dF6b'], [testMeetup1, testMeetup2]),
];
