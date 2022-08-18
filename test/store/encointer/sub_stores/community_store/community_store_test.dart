import 'package:encointer_wallet/mocks/data/mock_encointer_data.dart';
import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_api.dart';
import 'package:encointer_wallet/mocks/test_utils.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('communityStore', () {
    test('json serialization and caching works', () async {
      var localStorage = MockLocalStorage();
      var communityStoreCacheKey = "communityStore-test-cache";

      // Only to not get null errors in tests
      webApi = getMockApi(globalAppStore, withUI: false);
      webApi.init();

      var communityStore = CommunityStore(
        "My Test Network",
        mediterraneanTestCommunity,
      );

      communityStore.initStore(
        () => localStorage.setObject(communityStoreCacheKey, communityStore.toJson()),
        null,
      );

      var testMetadata = CommunityMetadata(
        "Test-Community",
        "TCM",
        "AssetsCid",
        "Community-Url",
        "Theme-String",
      );

      var bootstrappers = [ALICE_ADDRESS, BOB_ADDRESS, CHARLIE_ADDRESS];
      var testLocations = [testLocation1, testLocation2, testLocation3];

      communityStore.setCommunityMetadata(testMetadata);
      communityStore.setDemurrage(1.1);
      communityStore.setMeetupTime(10);
      communityStore.setBootstrappers(bootstrappers);
      communityStore.setMeetupLocations(testLocations);
      communityStore.initCommunityAccountStore(ALICE_ADDRESS);
      communityStore.initCommunityAccountStore(BOB_ADDRESS);
      var aliceCommunityAccountStore = communityStore.communityAccountStores![ALICE_ADDRESS]!;
      var bobCommunityAccountStore = communityStore.communityAccountStores![BOB_ADDRESS]!;

      Map<String, dynamic> targetJson = {
        "network": "My Test Network",
        "cid": mediterraneanTestCommunity.toJson(),
        "metadata": testMetadata.toJson(),
        "demurrage": 1.1,
        "meetupTime": 10,
        "meetupTimeOverride": null,
        "bootstrappers": bootstrappers,
        "meetupLocations": testLocations.map((l) => l.toJson()).toList(),
        'communityAccountStores': Map<String, dynamic>.of({
          ALICE_ADDRESS: aliceCommunityAccountStore.toJson(),
          BOB_ADDRESS: bobCommunityAccountStore.toJson(),
        })
      };

      expect(communityStore.toJson(), targetJson);

      var communityStoreDeserialized = CommunityStore.fromJson(targetJson);
      expect(communityStoreDeserialized.toJson(), targetJson);

      var cachedValue = await localStorage.getObject(communityStoreCacheKey);
      expect(cachedValue, targetJson);
    });
  });
}
