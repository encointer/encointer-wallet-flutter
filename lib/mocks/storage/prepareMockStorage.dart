import 'package:encointer_wallet/mocks/data/mockChainData.dart';
import 'package:encointer_wallet/mocks/data/mockEncointerData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';

import '../../models/index.dart';

abstract class PrepareMockStorage {
  static void init(AppStore store) {
    store.encointer.setCurrentPhase(initialPhase);
    store.encointer.setCommunityIdentifiers(testCommunityIdentifiers);
    store.encointer.setCommunities(testCommunities);
    store.chain.setLatestHeader(Header.fromJson(header));
  }

  static void getMetadata(AppStore store) {
    final now = DateTime.now().millisecondsSinceEpoch;
    store.encointer.setCurrentPhase(CeremonyPhase.Assigning);
    store.encointer.setPhaseDurations(testPhaseDurations);
    store.encointer.setNextPhaseTimestamp(now + Duration(hours: 8).inMilliseconds);
    store.encointer.community.setCommunityMetadata(CommunityMetadata.fromJson(communityMetadata));
    store.encointer.community.setDemurrage(demurrage);
    store.encointer.account.addBalanceEntry(cid, BalanceEntry.fromJson(testBalanceEntry));
    store.encointer.community.setMeetupTime(now + Duration(hours: 8).inMilliseconds);
  }

  static void readyForMeetup(AppStore store) {
    final now = DateTime.now().millisecondsSinceEpoch;

    store.encointer.setCurrentPhase(CeremonyPhase.Attesting);
    store.encointer.community.setMeetupLocations([testLocation1, testLocation2, testLocation3]);
    store.encointer.communityAccount.setMeetup(
      Meetup(
        1,
        1,
        now + Duration(hours: 8).inMilliseconds,
        testMeetupRegistry,
      ),
    );
  }
}
