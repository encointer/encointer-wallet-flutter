import 'package:collection/collection.dart' show IterableExtension;

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

Future<DateTime?> getMeetupTimeOverride({
  required String network,
  required CommunityIdentifier cid,
  required CeremonyPhase phase,
  required List<MeetupOverrides> overrides,
}) async {
  final networkOverride = overrides.firstWhereOrNull((o) => o.network == network);

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
