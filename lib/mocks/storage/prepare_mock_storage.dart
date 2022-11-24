import 'package:encointer_wallet/mocks/data/mock_chain_data.dart';
import 'package:encointer_wallet/mocks/data/mock_encointer_data.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';

abstract class PrepareMockStorage {
  static String wait(AppStore store) {
    return store.appIsReady.toString();
  }

  static Future<void> init(AppStore store) async {
    store.encointer.setCurrentPhase(initialPhase);
    await store.encointer.setCommunityIdentifiers(testCommunityIdentifiers);
    store.encointer.setCommunities(testCommunities);
    store.chain.setLatestHeader(Header.fromJson(header));
  }

  static void homePage(AppStore store) {
    final now = DateTime.now().millisecondsSinceEpoch;
    store.encointer.setCurrentPhase(CeremonyPhase.Assigning);
    store.encointer.setPhaseDurations(testPhaseDurations);
    store.encointer.setNextPhaseTimestamp(now + const Duration(hours: 8).inMilliseconds);
    store.encointer.community!.setCommunityMetadata(CommunityMetadata.fromJson(communityMetadata));
    store.encointer.community!.setDemurrage(demurrage);
    store.encointer.account!.addBalanceEntry(cid, BalanceEntry.fromJson(testBalanceEntry));
    store.encointer.community!.setMeetupTime(now + const Duration(hours: 8).inMilliseconds);
  }

  static void readyForMeetup(AppStore store) {
    final now = DateTime.now().millisecondsSinceEpoch;

    store.encointer.setCurrentPhase(CeremonyPhase.Attesting);
    store.encointer.community!.setMeetupLocations([testLocation1, testLocation2, testLocation3]);
    store.encointer.communityAccount!.setMeetup(
      Meetup(
        1,
        1,
        // needs to be the same as above, otherwise the `StartMeetup` button is missing
        now + const Duration(hours: 8).inMilliseconds,
        testMeetupRegistry,
      ),
    );
  }
}
