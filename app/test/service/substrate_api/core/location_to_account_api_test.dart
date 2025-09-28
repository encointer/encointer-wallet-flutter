import 'package:encointer_wallet/service/substrate_api/core/location_to_account_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/test_tags.dart';

const leuTreasuryOnEncointer = "HNJDzJEGaBgWRXz7bjERsRidJFQBnj1AZ2Tn3Q9uRGynhwq";
const payNuqTreasuryOnEncointer = "E2mZ1u2xepTF8nuEQVkrimPVwqtqq1joC56cUwYPftXAEQL";
const nyotaTreasuryOnEncointer = "E9KVuDLEtBBWSqhCiKn31VPBBLe33CbYJTrnWAbjszwskWH";

const leuTreasuryOnAHK = "HNJDzJEGaBgWRXz7bjERsRidJFQBnj1AZ2Tn3Q9uRGynhwq";
const payNuqTreasuryOnAHK = "E2mZ1u2xepTF8nuEQVkrimPVwqtqq1joC56cUwYPftXAEQL";
const nyotaTreasuryOnAHK = "E9KVuDLEtBBWSqhCiKn31VPBBLe33CbYJTrnWAbjszwskWH";

void main() {
  group('locationToAccountApi', () {
    test('leu converts correctly', () async {
      final provider = ReconnectingWsProvider(Uri.parse('wss://sys.ibp.network/asset-hub-kusama'));

      final leuLocationOnAHK = encointerAccountOnAHK(leuTreasuryOnEncointer);

      final encointerApi = LocationToAccountApi(provider);
      final accountId = await encointerApi.locationToAccountId(leuLocationOnAHK);

      await provider.disconnect();

      expect(accountId, AddressUtils.addressToPubKey(leuTreasuryOnAHK));
    }, tags: productionE2E);
  });
}
