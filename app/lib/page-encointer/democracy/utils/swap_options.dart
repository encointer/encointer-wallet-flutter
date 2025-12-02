import 'dart:math';

import 'package:encointer_wallet/config/consts.dart' show ertDecimals;
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page-encointer/democracy/utils/asset_id.dart';
import 'package:encointer_wallet/utils/format.dart' show Fmt;
import 'package:ew_polkadart/ew_polkadart.dart' show SwapNativeOption, SwapAssetOption, XcmLocation;
import 'package:ew_primitives/ew_primitives.dart' show fixedU128FromDouble;
import 'package:ew_substrate_fixed/substrate_fixed.dart' show i64F64Parser;

/// Helper sealed class with the intention to:
///
/// * Some helper methods for common computations
/// * Allow stuff to be generic over `SwapOption` as the behaviour is almost
///   the same for native and asset swap options.
sealed class SwapOption {
  const SwapOption();

  CommunityIdentifier get cid;

  /// [CC per asset] exchange rate.
  double get rate;

  double get allowance;

  /// Maximum community currency be used to trade for up to `allowance`.
  double get ccLimit;

  /// Either `KSM` for native options, or the asset's symbol e.g. USDC.
  String get symbol;

  int get decimals;
}

final class NativeSwap extends SwapOption {
  const NativeSwap(this.value);

  final SwapNativeOption value;

  @override
  CommunityIdentifier get cid => CommunityIdentifier.fromPolkadart(value.cid);

  @override
  double get allowance => Fmt.bigIntToDouble(value.nativeAllowance, ertDecimals);

  @override
  double get rate => i64F64Parser.toDouble(value.rate!.bits) * pow(10, ertDecimals);

  @override
  double get ccLimit => allowance * rate;

  @override
  String get symbol => 'KSM';

  @override
  int get decimals => ertDecimals;
}

final class AssetSwap extends SwapOption {
  const AssetSwap(this.value);

  final SwapAssetOption value;

  @override
  CommunityIdentifier get cid => CommunityIdentifier.fromPolkadart(value.cid);

  AssetToSpend get assetToSpend => fromVersionedLocatableAsset(value.assetId);

  XcmLocation get assetId => assetToSpend.assetId;

  @override
  double get allowance => Fmt.bigIntToDouble(value.assetAllowance, assetToSpend.decimals);

  @override
  double get rate => i64F64Parser.toDouble(value.rate!.bits) * pow(10, assetToSpend.decimals);

  @override
  double get ccLimit => allowance * rate;

  @override
  String get symbol => assetToSpend.symbol;

  @override
  int get decimals => assetToSpend.decimals;
}

NativeSwap mockNativeSwap(CommunityIdentifier cid) => NativeSwap(
      SwapNativeOption(
        cid: cid.toPolkadart(),
        nativeAllowance: BigInt.from(1.2 * pow(10, ertDecimals)),
        rate: fixedU128FromDouble(0.94 * pow(10, -ertDecimals)),
        doBurn: true,
      ),
    );

AssetSwap mockAssetSwap(CommunityIdentifier cid) => AssetSwap(
      SwapAssetOption(
        cid: cid.toPolkadart(),
        assetId: AssetToSpend.usdc.versionedLocatableAsset,
        assetAllowance: BigInt.from(1.2 * pow(10, AssetToSpend.usdc.decimals)),
        rate: fixedU128FromDouble(0.94 * pow(10, -AssetToSpend.usdc.decimals)),
        doBurn: true,
      ),
    );
