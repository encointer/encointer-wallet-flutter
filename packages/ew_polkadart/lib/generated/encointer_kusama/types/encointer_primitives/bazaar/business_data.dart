// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class BusinessData {
  const BusinessData({
    required this.url,
    required this.lastOid,
  });

  factory BusinessData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// PalletString
  final List<int> url;

  /// u32
  final int lastOid;

  static const $BusinessDataCodec codec = $BusinessDataCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'lastOid': lastOid,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BusinessData &&
          _i3.listsEqual(
            other.url,
            url,
          ) &&
          other.lastOid == lastOid;

  @override
  int get hashCode => Object.hash(
        url,
        lastOid,
      );
}

class $BusinessDataCodec with _i1.Codec<BusinessData> {
  const $BusinessDataCodec();

  @override
  void encodeTo(
    BusinessData obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.url,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.lastOid,
      output,
    );
  }

  @override
  BusinessData decode(_i1.Input input) {
    return BusinessData(
      url: _i1.U8SequenceCodec.codec.decode(input),
      lastOid: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(BusinessData obj) {
    int size = 0;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.url);
    size = size + _i1.U32Codec.codec.sizeHint(obj.lastOid);
    return size;
  }
}
