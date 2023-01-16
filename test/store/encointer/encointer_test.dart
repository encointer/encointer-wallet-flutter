import 'package:encointer_wallet/store/settings.dart';
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

/// Returns an initialized `AppStore`.
///
/// The `endpoint` should be different for every test if it involves serialization, so that the caching
/// does not interfere with other tests.
Future<AppStore> setupAppStore(String networkInfo) async {
  final store = AppStore(
    MockLocalStorage(),
    config: const AppConfig(isTest: true, mockSubstrateApi: true),
  );
  await store.init('_en');

  final endpoint = EndpointData()..info = networkInfo;
  store.settings.setEndpoint(endpoint);
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
      final testNetwork = '${unitTestEndpoint.info!}-0';
      final appStore = await setupAppStore(testNetwork);
      final encointerStore = appStore.encointer;

      final testCid = testCommunityIdentifiers[0];
      final testCidFmt = testCid.toFmtString();

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

      final cachedEncointerStore = await appStore.loadEncointerCache(appStore.encointerCacheKey(testNetwork));
      expect(cachedEncointerStore!.toJson(), targetJson);
    });

    test('purging encointer-store works and initializing new works', () async {
      final testNetwork = '${unitTestEndpoint.info!}-1';
      final appStore = await setupAppStore(testNetwork);

      appStore.purgeEncointerCache(testNetwork);
      expect(
        await appStore.localStorage.getObject(appStore.encointerCacheKey(testNetwork)),
        null,
      );

      // should initialize a new encointer store
      await appStore.init('_en');
      final expectedStore = EncointerStore(testNetwork);

      expect(
        await appStore.localStorage.getObject(appStore.encointerCacheKey(testNetwork)),
        expectedStore.toJson(),
      );
    });
  });
}
