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
    store.encointer.community.setCommunityMetadata(CommunityMetadata.fromJson(communityMetadata));
    store.encointer.community.setDemurrage(demurrage);
    store.encointer.communityAccount.addBalanceEntry(cid, BalanceEntry.fromJson(balanceEntry));
  }

  static void unregisteredParticipant(AppStore store) {
    store.encointer.communityAccount.setMeetupTime(claim['timestamp']);
  }

  static void readyForMeetup(AppStore store) {
    store.encointer.setCurrentPhase(CeremonyPhase.ATTESTING);
    store.encointer.community.setMeetupLocations([testLocation1, testLocation2, testLocation3]);
    store.encointer.communityAccount.setMeetup(Meetup(1, 1, claim['timestamp'], testMeetupRegistry));
  }
}
