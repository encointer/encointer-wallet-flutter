// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import '../cow.dart' as _i2;
import 'dart:typed_data' as _i3;
import '../tuples.dart' as _i4;

class RuntimeVersion {
  const RuntimeVersion({
    required this.specName,
    required this.implName,
    required this.authoringVersion,
    required this.specVersion,
    required this.implVersion,
    required this.apis,
    required this.transactionVersion,
    required this.stateVersion,
  });

  factory RuntimeVersion.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String specName;

  final String implName;

  final int authoringVersion;

  final int specVersion;

  final int implVersion;

  final _i2.Cow apis;

  final int transactionVersion;

  final int stateVersion;

  static const $RuntimeVersionCodec codec = $RuntimeVersionCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'specName': specName,
        'implName': implName,
        'authoringVersion': authoringVersion,
        'specVersion': specVersion,
        'implVersion': implVersion,
        'apis': apis
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                ])
            .toList(),
        'transactionVersion': transactionVersion,
        'stateVersion': stateVersion,
      };
}

class $RuntimeVersionCodec with _i1.Codec<RuntimeVersion> {
  const $RuntimeVersionCodec();

  @override
  void encodeTo(
    RuntimeVersion obj,
    _i1.Output output,
  ) {
    _i1.StrCodec.codec.encodeTo(
      obj.specName,
      output,
    );
    _i1.StrCodec.codec.encodeTo(
      obj.implName,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.authoringVersion,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.specVersion,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.implVersion,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<List<int>, int>>(
        _i4.Tuple2Codec<List<int>, int>(
      _i1.U8ArrayCodec(8),
      _i1.U32Codec.codec,
    )).encodeTo(
      obj.apis,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.transactionVersion,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      obj.stateVersion,
      output,
    );
  }

  @override
  RuntimeVersion decode(_i1.Input input) {
    return RuntimeVersion(
      specName: _i1.StrCodec.codec.decode(input),
      implName: _i1.StrCodec.codec.decode(input),
      authoringVersion: _i1.U32Codec.codec.decode(input),
      specVersion: _i1.U32Codec.codec.decode(input),
      implVersion: _i1.U32Codec.codec.decode(input),
      apis: const _i1.SequenceCodec<_i4.Tuple2<List<int>, int>>(
          _i4.Tuple2Codec<List<int>, int>(
        _i1.U8ArrayCodec(8),
        _i1.U32Codec.codec,
      )).decode(input),
      transactionVersion: _i1.U32Codec.codec.decode(input),
      stateVersion: _i1.U8Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(RuntimeVersion obj) {
    int size = 0;
    size = size + _i1.StrCodec.codec.sizeHint(obj.specName);
    size = size + _i1.StrCodec.codec.sizeHint(obj.implName);
    size = size + _i1.U32Codec.codec.sizeHint(obj.authoringVersion);
    size = size + _i1.U32Codec.codec.sizeHint(obj.specVersion);
    size = size + _i1.U32Codec.codec.sizeHint(obj.implVersion);
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<List<int>, int>>(
            _i4.Tuple2Codec<List<int>, int>(
          _i1.U8ArrayCodec(8),
          _i1.U32Codec.codec,
        )).sizeHint(obj.apis);
    size = size + _i1.U32Codec.codec.sizeHint(obj.transactionVersion);
    size = size + _i1.U8Codec.codec.sizeHint(obj.stateVersion);
    return size;
  }
}
