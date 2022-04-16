import 'package:encointer_wallet/mocks/storage/mockLocalStorage.dart';
import 'package:encointer_wallet/mocks/testUtils.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_account_store/communityAccountStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CommunityAccountStore', () {
    test('json serialization works', () {
      var communityAccountStore = CommunityAccountStore(
        "My Test Network",
        mediterraneanTestCommunity,
        ALICE_ADDRESS,
      );
      communityAccountStore.participantType = ParticipantType.Bootstrapper;
      communityAccountStore.setMeetup(Meetup(2, 3, 10, [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]));

      Map<String, dynamic> targetJson = {
        "network": "My Test Network",
        "cid": mediterraneanTestCommunity.toJson(),
        "account": ALICE_ADDRESS,
        "participantType": 'Bootstrapper',
        "meetup": {
          "meetupIndex": 2,
          "meetupLocationIndex": 3,
          "meetupTime": 10,
          "meetupRegistry": [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]
        }
      };

      expect(communityAccountStore.toJson(), targetJson);
    });

    test('json deserialization works', () {
      Map<String, dynamic> sourceJson = {
        "network": "My Test Network",
        "cid": mediterraneanTestCommunity.toJson(),
        "account": ALICE_ADDRESS,
        "participantType": 'Bootstrapper',
        "meetup": {
          "meetupIndex": 2,
          "meetupLocationIndex": 3,
          "meetupTime": 10,
          "meetupRegistry": [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]
        }
      };

      var store = CommunityAccountStore.fromJson(sourceJson);

      expect(store.network, "My Test Network");
      expect(store.cid, mediterraneanTestCommunity);
      expect(store.address, ALICE_ADDRESS);
      expect(store.participantType, ParticipantType.Bootstrapper);
      expect(store.meetup.index, 2);
      expect(store.meetup.locationIndex, 3);
      expect(store.meetup.time, 10);
      expect(store.meetup.registry, [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]);
    });

    test('cacheFn injection works', () async {
      var localStorage = getMockLocalStorage();

      var communityAccountStore = CommunityAccountStore(
        "My Test Network",
        mediterraneanTestCommunity,
        ALICE_ADDRESS,
      );
      communityAccountStore.participantType = ParticipantType.Bootstrapper;

      communityAccountStore.cacheFn = () => localStorage.setObject("hello", communityAccountStore.toJson());

      communityAccountStore.setMeetup(Meetup(2, 3, 10, [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]));

      Map<String, dynamic> targetCachedJson = {
        "network": "My Test Network",
        "cid": mediterraneanTestCommunity.toJson(),
        "account": ALICE_ADDRESS,
        "participantType": 'Bootstrapper',
        "meetup": {
          "meetupIndex": 2,
          "meetupLocationIndex": 3,
          "meetupTime": 10,
          "meetupRegistry": [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]
        }
      };

      var cachedValue = await localStorage.getObject("hello");
      expect(cachedValue, targetCachedJson);
    });
  });
}
