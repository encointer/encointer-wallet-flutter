import 'package:ew_polkadart/ew_polkadart.dart';

/// Asset to be spent on asset hub.
enum AssetToSpend {
  usdc,
}

extension AssetToSpendExt on AssetToSpend {
  String get symbol {
    return switch (this) {
      AssetToSpend.usdc => 'USDC',
    };
  }

  int get decimals {
    return switch (this) {
      AssetToSpend.usdc => 6,
    };
  }

  VersionedLocatableAsset get assetId {
    return switch (this) {
      AssetToSpend.usdc => usdcForeignAsset,
    };
  }
}

/// USDC Foreign Asset on Kusama Asset Hub
/// From runtime integration tests:
//  https://github.com/encointer/runtimes/blob/fe847b9b4c9ec2411ac4db5b876937b0581ead3c/integration-tests/emulated/tests/encointer/encointer-kusama/src/tests/remote_treasury_payout.rs#L142C1-L145C4
//
//  let asset_kind = VersionedLocatableAsset::V5 {
//    location: (Parent, Parachain(1000)).into(),
//	  asset_id: AssetId((PalletInstance(50), GeneralIndex(USDT_ID.into())).into()),
// 	};
VersionedLocatableAsset usdcForeignAsset = V5(
  location: XcmLocation(parents: 1, interior: X1([Parachain(assetHubParaId)])),
  assetId: XcmLocation(parents: 0, interior: polkadotForeignAsset(foreignAssetPalletInstance, usdcAssetId)),
);


BigInt assetHubParaId = BigInt.from(1000);

/// Asset Pallet Instance on Asset Hub Polkadot
const PalletInstance foreignAssetPalletInstance = PalletInstance(50);

/// USD Coin on Polkadot Asset Hub Polkadot
GeneralIndex usdcAssetId = GeneralIndex(BigInt.from(1337));

X4 polkadotForeignAsset(PalletInstance palletInstance, GeneralIndex assetId) {
  return X4([
    const GlobalConsensus(Polkadot()),
    Parachain(assetHubParaId),
    palletInstance,
    assetId,
  ]);
}
