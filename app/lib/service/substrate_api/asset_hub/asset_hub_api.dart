import 'dart:async';
import 'package:encointer_wallet/service/substrate_api/core/location_to_account_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/ew_polkadart.dart'
    show BlockHash, Provider, XcmLocation;
import 'package:ew_polkadart/generated/asset_hub_kusama/asset_hub_kusama.dart';
import 'package:ew_polkadart/generated/asset_hub_kusama/types/pallet_balances/types/account_data.dart' show AccountData;
import 'package:ew_polkadart/generated/asset_hub_kusama/types/sp_core/crypto/account_id32.dart';


class AssetHubApi {
  AssetHubApi(this.store, this.provider)
      : assetHubKusama = AssetHubKusama(provider);

  final Provider provider;
  final AssetHubKusama assetHubKusama;

  final AppStore store;

  /// Converts an Encointer address to its remote representation on Asset Hub Kusama.
  Future<AccountId32> encointerAccountOnAHK(String address) async {
    final location = encointerAddressOnAHK(address);
    return locationToAccount(location);
  }

  /// Converts a given XcmLocation to its AccountId32 representation via the
  /// `locationToAccount` runtime API.
  Future<AccountId32> locationToAccount(XcmLocation location) async {
    final api = LocationToAccountApi(provider);
    return api.locationToAccountId(location);
  }

  Future<AccountData> getBalanceOf(String address, {BlockHash? at}) async {
    return assetHubKusama.query.system
        .account(
        AddressUtils.addressToPubKey(address), at: at ?? store.chain.latestHash)
        .then((info) => info.data);
  }
}
