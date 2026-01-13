// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import '../frame_support/dispatch/dispatch_class.dart' as _i3;
import '../frame_support/dispatch/pays.dart' as _i4;
import '../sp_weights/weight_v2/weight.dart' as _i2;

class DispatchEventInfo {
  const DispatchEventInfo({
    required this.weight,
    required this.class_,
    required this.paysFee,
  });

  factory DispatchEventInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Weight
  final _i2.Weight weight;

  /// DispatchClass
  final _i3.DispatchClass class_;

  /// Pays
  final _i4.Pays paysFee;

  static const $DispatchEventInfoCodec codec = $DispatchEventInfoCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'weight': weight.toJson(),
        'class': class_.toJson(),
        'paysFee': paysFee.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DispatchEventInfo && other.weight == weight && other.class_ == class_ && other.paysFee == paysFee;

  @override
  int get hashCode => Object.hash(
        weight,
        class_,
        paysFee,
      );
}

class $DispatchEventInfoCodec with _i1.Codec<DispatchEventInfo> {
  const $DispatchEventInfoCodec();

  @override
  void encodeTo(
    DispatchEventInfo obj,
    _i1.Output output,
  ) {
    _i2.Weight.codec.encodeTo(
      obj.weight,
      output,
    );
    _i3.DispatchClass.codec.encodeTo(
      obj.class_,
      output,
    );
    _i4.Pays.codec.encodeTo(
      obj.paysFee,
      output,
    );
  }

  @override
  DispatchEventInfo decode(_i1.Input input) {
    return DispatchEventInfo(
      weight: _i2.Weight.codec.decode(input),
      class_: _i3.DispatchClass.codec.decode(input),
      paysFee: _i4.Pays.codec.decode(input),
    );
  }

  @override
  int sizeHint(DispatchEventInfo obj) {
    int size = 0;
    size = size + _i2.Weight.codec.sizeHint(obj.weight);
    size = size + _i3.DispatchClass.codec.sizeHint(obj.class_);
    size = size + _i4.Pays.codec.sizeHint(obj.paysFee);
    return size;
  }

  @override
  bool isSizeZero() =>
      _i2.Weight.codec.isSizeZero() && _i3.DispatchClass.codec.isSizeZero() && _i4.Pays.codec.isSizeZero();
}
