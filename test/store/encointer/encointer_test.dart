import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:encointer_wallet/mocks/data/mock_encointer_data.dart';
import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_api.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/encointer.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/bazaar_store/bazaar_store.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EncointerStore test', () {
    test('encointer store initialization, serialization and cache works', () async {
      globalAppStore = AppStore(MockLocalStorage(), config: StoreConfig.Test);
      final AppStore root = globalAppStore;
      await root.init('_en');

      accList = [testAcc];
      currentAccountPubKey = accList[0]['pubKey'];

      webApi = getMockApi(root, withUI: false);

      // re-initialize with cacheKey that does not mess with real cache
      root.settings.setEndpoint(unitTestEndpoint);
      await root.init('_en');
      await webApi.init();

      final encointerStore = root.encointer;

      var testCid = testCommunityIdentifiers[0];
      var testCidFmt = testCid.toFmtString();
      var testNetwork = unitTestEndpoint.info!;

      encointerStore.setCurrentPhase(CeremonyPhase.Registering);
      encointerStore.setCurrentCeremonyIndex(2);
      encointerStore.setNextPhaseTimestamp(3);
      encointerStore.setCommunityIdentifiers(testCommunityIdentifiers);
      encointerStore.setCommunities(testCommunities);

      // this should initialize the following sub-stores:
      //
      // - BazaarStore(network, testCid)
      // - CommunityStore(network, testCid)
      // - CommunityAccountStore(network, testCid, store.account.currentAddress)
      encointerStore.setChosenCid(testCid);

      var testCommunityStore = CommunityStore(testNetwork, testCid);
      await testCommunityStore.initCommunityAccountStore(root.account.currentAddress);

      Map<String, dynamic> targetJson = {
        'network': testNetwork,
        'currentPhase': 'Registering',
        'nextPhaseTimestamp': 3,
        'phaseDurations': Map<String, dynamic>.of({}),
        'currentCeremonyIndex': 2,
        'communityIdentifiers': testCommunityIdentifiers.map((c) => c.toJson()).toList(),
        'communities': testCommunities.map((cn) => cn.toJson()).toList(),
        'chosenCid': testCid.toJson(),
        'accountStores': Map<String, dynamic>.of({}),
        'bazaarStores': Map<String, dynamic>.of({
          testCidFmt: BazaarStore(testNetwork, testCid).toJson(),
        }),
        'communityStores': Map<String, dynamic>.of({
          testCidFmt: testCommunityStore.toJson(),
        }),
      };

      expect(encointerStore.toJson(), targetJson);

      var deserializedEncointerStore = EncointerStore.fromJson(targetJson);
      expect(deserializedEncointerStore.toJson(), targetJson);

      var cachedEncointerStore = await root.loadEncointerCache(root.encointerCacheKey(unitTestEndpoint.info!));
      expect(cachedEncointerStore!.toJson(), targetJson);
    });

    test('purging encointer-store works and initializing new works', () async {
      globalAppStore = AppStore(MockLocalStorage());
      final AppStore root = globalAppStore;
      accList = [testAcc];
      currentAccountPubKey = accList[0]['pubKey'];

      webApi = getMockApi(root, withUI: false);
      await root.init('_en');

      // re-initialize with cacheKey that does not mess with real cache
      root.settings.setEndpoint(unitTestEndpoint);

      root.purgeEncointerCache(unitTestEndpoint.info!);
      expect(
        await root.localStorage.getObject(root.encointerCacheKey(unitTestEndpoint.info!)),
        null,
      );

      // should initialize a new encointer store
      await root.init('_en');

      var expectedStore = EncointerStore(unitTestEndpoint.info!);

      // This is due to side-effects of parallel executed tests and the global appStore...
      expectedStore.chosenCid = testCommunityIdentifiers[0];

      expect(
        await root.localStorage.getObject(root.encointerCacheKey(unitTestEndpoint.info!)),
        expectedStore.toJson(),
      );
    });
  });
}
