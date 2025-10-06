import 'dart:async';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/location_to_account_api.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/asset_hub_types.dart' show XcmAssetHubLocation;
import 'package:ew_polkadart/ew_polkadart.dart' show BlockHash, Provider, XcmLocation, Input;
import 'package:ew_polkadart/generated/asset_hub_kusama/asset_hub_kusama.dart';
import 'package:ew_polkadart/generated/asset_hub_kusama/types/pallet_balances/types/account_data.dart' show AccountData;
import 'package:ew_polkadart/generated/asset_hub_kusama/types/sp_core/crypto/account_id32.dart';

const logTarget = 'AssetHubApi';

class AssetHubApi {
  AssetHubApi(this.provider) : assetHubKusama = AssetHubKusama(provider);

  final Provider provider;
  final AssetHubKusama assetHubKusama;

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

  /// Get the balance of the Asset Hub's representation of an Encointer account on Asset Hub Kusama.
  Future<AccountData> getBalanceOfEncointerAccountOnKusama(String address, {BlockHash? at}) async {
    final accountId = await encointerAccountOnAHK(address);
    return assetHubKusama.query.system.account(accountId, at: at).then((info) => info.data);
  }

  /// Get the balance of an address on Asset Hub Kusama.
  Future<AccountData> getBalanceOf(String address, {BlockHash? at}) async {
    return assetHubKusama.query.system.account(AddressUtils.addressToPubKey(address), at: at).then((info) => info.data);
  }

  /// Get balance of a foreign asset of the Asset Hub's representation of an Encointer account on Asset Hub Kusama.
  Future<BigInt> getForeignAssetBalanceOfEncointerAccount(String address, XcmLocation assetId, {BlockHash? at}) async {
    final accountId = await encointerAccountOnAHK(address);
    final addressOnAssetHub = AddressUtils.pubKeyToAddress(accountId, prefix: 2);
    Log.d('Encointer address $address corresponds to Asset Hub accountId: $accountId', logTarget);
    return getForeignAssetBalanceOf(addressOnAssetHub, assetId);
  }

  /// Get the foreign asset balance of an address on Asset Hub Kusama.
  Future<BigInt> getForeignAssetBalanceOf(String address, XcmLocation assetId, {BlockHash? at}) async {
    final encoded = assetId.encode();
    final assetHubId = XcmAssetHubLocation.decode(Input.fromBytes(encoded));

    Log.d('Getting foreign asset balance for: $address and assetId: ${assetHubId.toJson()}', logTarget);

    return assetHubKusama.query.foreignAssets
        .account(assetHubId, AddressUtils.addressToPubKey(address), at: at)
        .then((info) => info?.balance ?? BigInt.zero);
  }
}
