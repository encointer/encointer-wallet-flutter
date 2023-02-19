import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/mocks/test_utils.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_account_store/community_account_store.dart';

void main() {
  group('CommunityAccountStore', () {
    test('json serialization works', () {
      final communityAccountStore = CommunityAccountStore(
        'My Test Network',
        mediterraneanTestCommunity,
        aliceAddress,
      )
        ..participantType = ParticipantType.Bootstrapper
        ..setMeetup(Meetup(2, 3, 10, [aliceAddress, bobAddress, charlieAddress]));

      final Map targetJson = <String, dynamic>{
        'network': 'My Test Network',
        'cid': mediterraneanTestCommunity.toJson(),
        'address': aliceAddress,
        'participantType': 'Bootstrapper',
        'meetup': {
          'index': 2,
          'locationIndex': 3,
          'time': 10,
          'registry': [aliceAddress, bobAddress, charlieAddress]
        },
        'attendees': <String>[],
        'participantCountVote': null,
        'meetupCompleted': false,
        'numberOfNewbieTicketsForBootstrapper': 0,
      };

      expect(communityAccountStore.toJson(), targetJson);
    });

    test('json deserialization works', () {
      final sourceJson = <String, dynamic>{
        'network': 'My Test Network',
        'cid': mediterraneanTestCommunity.toJson(),
        'address': aliceAddress,
        'participantType': 'Bootstrapper',
        'meetup': {
          'index': 2,
          'locationIndex': 3,
          'time': 10,
          'registry': [aliceAddress, bobAddress, charlieAddress]
        },
        'attendees': <String>[],
        'numberOfNewbieTicketsForBootstrapper': 0,
      };

      final store = CommunityAccountStore.fromJson(sourceJson);

      expect(store.network, 'My Test Network');
      expect(store.cid, mediterraneanTestCommunity);
      expect(store.address, aliceAddress);
      expect(store.participantType, ParticipantType.Bootstrapper);
      expect(store.meetup!.index, 2);
      expect(store.meetup!.locationIndex, 3);
      expect(store.meetup!.time, 10);
      expect(store.meetup!.registry, [aliceAddress, bobAddress, charlieAddress]);
      expect(store.numberOfNewbieTicketsForBootstrapper, 0);
    });

    test('cacheFn injection works', () async {
      final localStorage = MockLocalStorage();

      final communityAccountStore = CommunityAccountStore(
        'My Test Network',
        mediterraneanTestCommunity,
        aliceAddress,
      )..participantType = ParticipantType.Bootstrapper;

      communityAccountStore
        ..initStore(() => localStorage.setObject('hello', communityAccountStore.toJson()))
        ..setMeetup(Meetup(2, 3, 10, [aliceAddress, bobAddress, charlieAddress]));

      final targetCachedJson = <String, dynamic>{
        'network': 'My Test Network',
        'cid': mediterraneanTestCommunity.toJson(),
        'address': aliceAddress,
        'participantType': 'Bootstrapper',
        'meetup': {
          'index': 2,
          'locationIndex': 3,
          'time': 10,
          'registry': [aliceAddress, bobAddress, charlieAddress]
        },
        'attendees': <String>[],
        'participantCountVote': null,
        'meetupCompleted': false,
        'numberOfNewbieTicketsForBootstrapper': 0,
      };

      final cachedValue = await localStorage.getObject('hello');
      expect(cachedValue, targetCachedJson);
    });
  });
}
