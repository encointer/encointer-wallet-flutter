import 'dart:math';

import 'package:encointer_wallet/config/consts.dart' show ertDecimals;
import 'package:encointer_wallet/page-encointer/democracy/utils/asset_id.dart';
import 'package:encointer_wallet/utils/format.dart' show Fmt;
import 'package:ew_polkadart/ew_polkadart.dart'
    show SwapNativeOption, SwapAssetOption;
import 'package:ew_substrate_fixed/substrate_fixed.dart' show i64F64Parser;

sealed class SwapOption {
  const SwapOption();

  bool get isNative;

  double get rate;

  double get allowance;
}

final class NativeSwap extends SwapOption {
  const NativeSwap(this.value);

  final SwapNativeOption value;

  @override
  double get allowance => Fmt.bigIntToDouble(value.nativeAllowance, ertDecimals);

  @override
  bool get isNative => true;

  @override
  double get rate => i64F64Parser.toDouble(value.rate!.bits) * pow(10, ertDecimals);
}

final class AssetSwap extends SwapOption {
  const AssetSwap(this.value);

  final SwapAssetOption value;

  AssetToSpend get assetToSpend => fromVersionedLocatableAsset(value.assetId);

  @override
  double get allowance =>  Fmt.bigIntToDouble(value.assetAllowance, ertDecimals);

  @override
  bool get isNative => false;

  @override
  double get rate => i64F64Parser.toDouble(value.rate!.bits) * pow(10, ertDecimals);
}
