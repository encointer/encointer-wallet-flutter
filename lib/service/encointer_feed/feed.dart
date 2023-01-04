import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:http/http.dart' as http;

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

Future<List<MeetupOverrides>> getMeetupOverrides() async {
  final response = await http.get(Uri.parse(encointerFeedOverrides));

  if (response.statusCode == 200) {
    final list = jsonDecode(response.body);
    return (list as List).map((e) => MeetupOverrides.fromJson(e as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to get meetup overrides.');
  }
}

Future<DateTime?> getMeetupTimeOverride(String network, CommunityIdentifier cid, CeremonyPhase phase) async {
  // For testing that it works.
  // final overrides = testMeetupOverrides;
  final overrides = await getMeetupOverrides();

  final networkOverride = overrides.firstWhereOrNull(
    (o) => o.network == network,
  );

  if (networkOverride == null) {
    Log.d('No network specific override found', 'getMeetupTimeOverride');
    return Future.value();
  }

  if (networkOverride.communities!.contains(cid.toFmtString())) {
    final meetupTimeOverride = networkOverride.getNextMeetupTime(DateTime.now(), phase);
    Log.d('Found meetupTimeOverride: $meetupTimeOverride', 'getMeetupTimeOverride');
    return meetupTimeOverride;
  } else {
    Log.d('No community specific override found', 'getMeetupTimeOverride');
    return Future.value();
  }
}
