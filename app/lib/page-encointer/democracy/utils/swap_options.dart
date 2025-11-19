import 'dart:math';

import 'package:encointer_wallet/config/consts.dart' show ertDecimals;
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page-encointer/democracy/utils/asset_id.dart';
import 'package:encointer_wallet/utils/format.dart' show Fmt;
import 'package:ew_polkadart/ew_polkadart.dart' show SwapNativeOption, SwapAssetOption, XcmLocation;
import 'package:ew_substrate_fixed/substrate_fixed.dart' show i64F64Parser;

sealed class SwapOption {
  const SwapOption();

  CommunityIdentifier get cid;

  double get rate;

  double get allowance;
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
}
