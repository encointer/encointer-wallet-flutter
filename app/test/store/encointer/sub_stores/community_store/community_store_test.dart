import 'dart:async';

import 'package:encointer_wallet/config.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/mocks/data/mock_encointer_data.dart';
import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_api.dart';
import 'package:encointer_wallet/mocks/test_utils.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_store.dart';

void main() {
  group('communityStore', () {
    test('json serialization and caching works', () async {
      final localStorage = MockLocalStorage();
      const communityStoreCacheKey = 'communityStore-test-cache';

      // Only to not get null errors in tests
      webApi = getMockApi(
        AppStore(MockLocalStorage(), config: const AppConfig()),
        withUI: false,
      );
      await webApi.init();

      final communityStore = CommunityStore(
        'My Test Network',
        mediterraneanTestCommunity,
      );

      communityStore.initStore(
        () => localStorage.setObject(communityStoreCacheKey, communityStore.toJson()),
        null,
      );

      final testMetadata = CommunityMetadata(
        'Test-Community',
        'TCM',
        'AssetsCid',
        'Community-Url',
        'Theme-String',
      );

      final bootstrappers = [aliceAddress, bobAddress, charlieAddress];
      final testLocations = [testLocation1, testLocation2, testLocation3];

      communityStore
        ..setDemurrage(1.1)
        ..setMeetupTime(10)
        ..setMeetupLocations(testLocations);

      unawaited(Future.wait<void>([
        communityStore.setCommunityMetadata(testMetadata),
        communityStore.setBootstrappers(bootstrappers),
        communityStore.initCommunityAccountStore(aliceAddress),
        communityStore.initCommunityAccountStore(bobAddress)
      ]));

      final aliceCommunityAccountStore = communityStore.communityAccountStores![aliceAddress]!;
      final bobCommunityAccountStore = communityStore.communityAccountStores![bobAddress]!;

      final targetJson = <String, dynamic>{
        'network': 'My Test Network',
        'cid': mediterraneanTestCommunity.toJson(),
        'metadata': testMetadata.toJson(),
        'demurrage': 1.1,
        'meetupTime': 10,
        'meetupTimeOverride': null,
        'bootstrappers': bootstrappers,
        'meetupLocations': testLocations.map((l) => l.toJson()).toList(),
        'communityAccountStores': Map<String, dynamic>.of({
          aliceAddress: aliceCommunityAccountStore.toJson(),
          bobAddress: bobCommunityAccountStore.toJson(),
        }),
        'communityIcon': null,
      };

      expect(communityStore.toJson(), targetJson);

      final communityStoreDeserialized = CommunityStore.fromJson(targetJson);
      expect(communityStoreDeserialized.toJson(), targetJson);

      final cachedValue = await localStorage.getObject(communityStoreCacheKey);
      expect(cachedValue, targetJson);
    });
  });
}
