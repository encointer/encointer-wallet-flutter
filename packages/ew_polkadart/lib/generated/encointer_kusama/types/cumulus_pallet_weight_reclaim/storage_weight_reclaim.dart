// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i11;

import '../frame_metadata_hash_extension/check_metadata_hash.dart' as _i10;
import '../frame_system/extensions/check_genesis/check_genesis.dart' as _i5;
import '../frame_system/extensions/check_mortality/check_mortality.dart' as _i6;
import '../frame_system/extensions/check_non_zero_sender/check_non_zero_sender.dart' as _i2;
import '../frame_system/extensions/check_nonce/check_nonce.dart' as _i7;
import '../frame_system/extensions/check_spec_version/check_spec_version.dart' as _i3;
import '../frame_system/extensions/check_tx_version/check_tx_version.dart' as _i4;
import '../frame_system/extensions/check_weight/check_weight.dart' as _i8;
import '../pallet_asset_tx_payment/charge_asset_tx_payment.dart' as _i9;
import '../tuples_3.dart' as _i1;

typedef StorageWeightReclaim = _i1.Tuple9<
    _i2.CheckNonZeroSender,
    _i3.CheckSpecVersion,
    _i4.CheckTxVersion,
    _i5.CheckGenesis,
    _i6.CheckMortality,
    _i7.CheckNonce,
    _i8.CheckWeight,
    _i9.ChargeAssetTxPayment,
    _i10.CheckMetadataHash>;

class StorageWeightReclaimCodec with _i11.Codec<StorageWeightReclaim> {
  const StorageWeightReclaimCodec();

  @override
  StorageWeightReclaim decode(_i11.Input input) {
    return const _i1.Tuple9Codec<_i2.CheckNonZeroSender, _i3.CheckSpecVersion, _i4.CheckTxVersion, _i5.CheckGenesis,
        _i6.CheckMortality, _i7.CheckNonce, _i8.CheckWeight, _i9.ChargeAssetTxPayment, _i10.CheckMetadataHash>(
      _i2.CheckNonZeroSenderCodec(),
      _i3.CheckSpecVersionCodec(),
      _i4.CheckTxVersionCodec(),
      _i5.CheckGenesisCodec(),
      _i6.CheckMortalityCodec(),
      _i7.CheckNonceCodec(),
      _i8.CheckWeightCodec(),
      _i9.ChargeAssetTxPayment.codec,
      _i10.CheckMetadataHash.codec,
    ).decode(input);
  }

  @override
  void encodeTo(
    StorageWeightReclaim value,
    _i11.Output output,
  ) {
    const _i1.Tuple9Codec<_i2.CheckNonZeroSender, _i3.CheckSpecVersion, _i4.CheckTxVersion, _i5.CheckGenesis,
        _i6.CheckMortality, _i7.CheckNonce, _i8.CheckWeight, _i9.ChargeAssetTxPayment, _i10.CheckMetadataHash>(
      _i2.CheckNonZeroSenderCodec(),
      _i3.CheckSpecVersionCodec(),
      _i4.CheckTxVersionCodec(),
      _i5.CheckGenesisCodec(),
      _i6.CheckMortalityCodec(),
      _i7.CheckNonceCodec(),
      _i8.CheckWeightCodec(),
      _i9.ChargeAssetTxPayment.codec,
      _i10.CheckMetadataHash.codec,
    ).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(StorageWeightReclaim value) {
    return const _i1.Tuple9Codec<_i2.CheckNonZeroSender, _i3.CheckSpecVersion, _i4.CheckTxVersion, _i5.CheckGenesis,
        _i6.CheckMortality, _i7.CheckNonce, _i8.CheckWeight, _i9.ChargeAssetTxPayment, _i10.CheckMetadataHash>(
      _i2.CheckNonZeroSenderCodec(),
      _i3.CheckSpecVersionCodec(),
      _i4.CheckTxVersionCodec(),
      _i5.CheckGenesisCodec(),
      _i6.CheckMortalityCodec(),
      _i7.CheckNonceCodec(),
      _i8.CheckWeightCodec(),
      _i9.ChargeAssetTxPayment.codec,
      _i10.CheckMetadataHash.codec,
    ).sizeHint(value);
  }
}
