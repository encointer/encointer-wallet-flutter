// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class CancelAttributesApprovalWitness {
  const CancelAttributesApprovalWitness({required this.accountAttributes});

  factory CancelAttributesApprovalWitness.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int accountAttributes;

  static const $CancelAttributesApprovalWitnessCodec codec = $CancelAttributesApprovalWitnessCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {'accountAttributes': accountAttributes};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelAttributesApprovalWitness && other.accountAttributes == accountAttributes;

  @override
  int get hashCode => accountAttributes.hashCode;
}

class $CancelAttributesApprovalWitnessCodec with _i1.Codec<CancelAttributesApprovalWitness> {
  const $CancelAttributesApprovalWitnessCodec();

  @override
  void encodeTo(
    CancelAttributesApprovalWitness obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.accountAttributes,
      output,
    );
  }

  @override
  CancelAttributesApprovalWitness decode(_i1.Input input) {
    return CancelAttributesApprovalWitness(accountAttributes: _i1.U32Codec.codec.decode(input));
  }

  @override
  int sizeHint(CancelAttributesApprovalWitness obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.accountAttributes);
    return size;
  }
}
