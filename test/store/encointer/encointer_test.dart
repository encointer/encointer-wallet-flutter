import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/config.dart';
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

Future<AppStore> setupAppStore() async {
  final store = AppStore(
    MockLocalStorage(),
    config: const AppConfig(isTest: true, mockSubstrateApi: true),
  );
  await store.init('_en');

  // Todo: double-check if this is still necessary.
  // re-initialize with cacheKey that does not mess with real cache
  store.settings.setEndpoint(unitTestEndpoint);
  await store.init('_en');

  accList = [testAcc];
  currentAccountPubKey = accList[0]['pubKey'] as String;

  webApi = getMockApi(store, withUI: false);
  await webApi.init();

  return store;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EncointerStore test', () {
    test('encointer store initialization, serialization and cache works', () async {
      final appStore = await setupAppStore();
      final encointerStore = appStore.encointer;

      final testCid = testCommunityIdentifiers[0];
      final testCidFmt = testCid.toFmtString();
      final testNetwork = unitTestEndpoint.info!;

      encointerStore
        ..setCurrentPhase(CeremonyPhase.Registering)
        ..setCurrentCeremonyIndex(2)
        ..setNextPhaseTimestamp(3);
      await encointerStore.setCommunityIdentifiers(testCommunityIdentifiers);
      encointerStore.setCommunities(testCommunities);

      // this should initialize the following sub-stores:
      //
      // - BazaarStore(network, testCid)
      // - CommunityStore(network, testCid)
      // - CommunityAccountStore(network, testCid, store.account.currentAddress)
      await encointerStore.setChosenCid(testCid);

      final testCommunityStore = CommunityStore(testNetwork, testCid);
      await testCommunityStore.initCommunityAccountStore(appStore.account.currentAddress);

      final targetJson = <String, dynamic>{
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

      final deserializedEncointerStore = EncointerStore.fromJson(targetJson);
      expect(deserializedEncointerStore.toJson(), targetJson);

      final cachedEncointerStore =
          await appStore.loadEncointerCache(appStore.encointerCacheKey(unitTestEndpoint.info!));
      expect(cachedEncointerStore!.toJson(), targetJson);
    });

    test('purging encointer-store works and initializing new works', () async {
      final appStore = await setupAppStore();

      appStore.purgeEncointerCache(unitTestEndpoint.info!);
      expect(
        await appStore.localStorage.getObject(appStore.encointerCacheKey(unitTestEndpoint.info!)),
        null,
      );

      // should initialize a new encointer store
      await appStore.init('_en');

      final expectedStore = EncointerStore(unitTestEndpoint.info!)
        // This is due to side-effects of parallel executed tests and the global appStore...
        ..chosenCid = testCommunityIdentifiers[0];

      expect(
        await appStore.localStorage.getObject(appStore.encointerCacheKey(unitTestEndpoint.info!)),
        expectedStore.toJson(),
      );
    });

    test('purging encointer-store works and initializing new works', () async {
      final appStore = await setupAppStore();

      appStore.purgeEncointerCache(unitTestEndpoint.info!);
      expect(
        await appStore.localStorage.getObject(appStore.encointerCacheKey(unitTestEndpoint.info!)),
        null,
      );

      // should initialize a new encointer store
      await appStore.init('_en');

      final expectedStore = EncointerStore(unitTestEndpoint.info!)
        // This is due to side-effects of parallel executed tests and the global appStore...
        ..chosenCid = testCommunityIdentifiers[0];

      expect(
        await appStore.localStorage.getObject(appStore.encointerCacheKey(unitTestEndpoint.info!)),
        expectedStore.toJson(),
      );
    });
  });
}
