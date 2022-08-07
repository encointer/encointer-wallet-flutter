import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/mocks/test_utils.dart';
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
      communityAccountStore.setMeetup(
          Meetup(2, 3, 10, [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]));

      Map<String, dynamic> targetJson = {
        "network": "My Test Network",
        "cid": mediterraneanTestCommunity.toJson(),
        "address": ALICE_ADDRESS,
        "participantType": 'Bootstrapper',
        "meetup": {
          "index": 2,
          "locationIndex": 3,
          "time": 10,
          "registry": [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]
        },
        "participantsClaims": {},
        'meetupCompleted': false
      };

      expect(communityAccountStore.toJson(), targetJson);
    });

    test('json deserialization works', () {
      Map<String, dynamic> sourceJson = {
        "network": "My Test Network",
        "cid": mediterraneanTestCommunity.toJson(),
        "address": ALICE_ADDRESS,
        "participantType": 'Bootstrapper',
        "meetup": {
          "index": 2,
          "locationIndex": 3,
          "time": 10,
          "registry": [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]
        },
        "participantsClaims": Map<String, dynamic>.of({})
      };

      var store = CommunityAccountStore.fromJson(sourceJson);

      expect(store.network, "My Test Network");
      expect(store.cid, mediterraneanTestCommunity);
      expect(store.address, ALICE_ADDRESS);
      expect(store.participantType, ParticipantType.Bootstrapper);
      expect(store.meetup!.index, 2);
      expect(store.meetup!.locationIndex, 3);
      expect(store.meetup!.time, 10);
      expect(store.meetup!.registry,
          [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]);
    });

    test('cacheFn injection works', () async {
      var localStorage = MockLocalStorage();

      var communityAccountStore = CommunityAccountStore(
        "My Test Network",
        mediterraneanTestCommunity,
        ALICE_ADDRESS,
      );
      communityAccountStore.participantType = ParticipantType.Bootstrapper;

      communityAccountStore.initStore(() =>
          localStorage.setObject("hello", communityAccountStore.toJson()));

      communityAccountStore.setMeetup(
          Meetup(2, 3, 10, [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]));

      Map<String, dynamic> targetCachedJson = {
        "network": "My Test Network",
        "cid": mediterraneanTestCommunity.toJson(),
        "address": ALICE_ADDRESS,
        "participantType": 'Bootstrapper',
        "meetup": {
          "index": 2,
          "locationIndex": 3,
          "time": 10,
          "registry": [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]
        },
        "participantsClaims": Map<String, dynamic>.of({}),
        "meetupCompleted": false
      };

      var cachedValue = await localStorage.getObject("hello");
      expect(cachedValue, targetCachedJson);
    });
  });
}
