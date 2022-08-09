import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/index.dart';
// import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:http/http.dart' as http;

import '../../models/communities/community_identifier.dart';

Future<List<MeetupOverrides>> getMeetupOverrides() async {
  final response = await http.get(Uri.parse(encointer_feed_overrides));

  if (response.statusCode == 200) {
    List<dynamic> list = jsonDecode(response.body);
    return list.map((e) => MeetupOverrides.fromJson(e)).toList();
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
    _log("No network specific override found");
    return Future.value(null);
  }

  if (networkOverride.communities!.contains(cid.toFmtString())) {
    final meetupTimeOverride = networkOverride.getNextMeetupTime(DateTime.now(), phase);
    _log("Found meetupTimeOverride: $meetupTimeOverride");
    return meetupTimeOverride;
  } else {
    _log("No community specific override found");
    return Future.value(null);
  }
}

void _log(String msg) {
  print("[EncointerFeed] $msg");
}
