import 'package:encointer_wallet/mocks/testUtils.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/communityStore/communityAccountStore/communityAccountStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CommunityAccountStore', () {
    test('json serialization works', () {
      var communityAccountStore = CommunityAccountStore();
      communityAccountStore
          .setMeetup(Meetup(ParticipantType.Bootstrapper, 2, 3, 10, [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]));

      const Map<String, dynamic> targetJson = {
        "meetup": {
          "participantType": 'Bootstrapper',
          "meetupIndex": 2,
          "meetupLocationIndex": 3,
          "meetupTime": 10,
          "meetupRegistry": [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]
        }
      };

      expect(communityAccountStore.toJson(), targetJson);
    });

    test('json deserialization works', () {
      const Map<String, dynamic> sourceJson = {
        "meetup": {
          "participantType": 'Bootstrapper',
          "meetupIndex": 2,
          "meetupLocationIndex": 3,
          "meetupTime": 10,
          "meetupRegistry": [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]
        }
      };

      var store = CommunityAccountStore.fromJson(sourceJson);

      expect(store.meetup.participantType, ParticipantType.Bootstrapper);
      expect(store.meetup.meetupIndex, 2);
      expect(store.meetup.meetupLocationIndex, 3);
      expect(store.meetup.meetupTime, 10);
      expect(store.meetup.meetupRegistry, [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS]);
    });
  });
}
