// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import 'multiasset/multi_assets.dart' as _i3;
import '../../tuples_1.dart' as _i4;
import 'traits/error.dart' as _i5;
import 'pallet_info.dart' as _i6;
import 'maybe_error_code.dart' as _i7;
import 'multiasset/multi_asset.dart' as _i8;

abstract class Response {
  const Response();

  factory Response.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ResponseCodec codec = $ResponseCodec();

  static const $Response values = $Response();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Response {
  const $Response();

  Null null_() {
    return const Null();
  }

  Assets assets({required _i3.MultiAssets value0}) {
    return Assets(
      value0: value0,
    );
  }

  ExecutionResult executionResult({_i4.Tuple2<int, _i5.Error>? value0}) {
    return ExecutionResult(
      value0: value0,
    );
  }

  Version version({required int value0}) {
    return Version(
      value0: value0,
    );
  }

  PalletsInfo palletsInfo({required List<_i6.PalletInfo> value0}) {
    return PalletsInfo(
      value0: value0,
    );
  }

  DispatchResult dispatchResult({required _i7.MaybeErrorCode value0}) {
    return DispatchResult(
      value0: value0,
    );
  }
}

class $ResponseCodec with _i1.Codec<Response> {
  const $ResponseCodec();

  @override
  Response decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Null();
      case 1:
        return Assets._decode(input);
      case 2:
        return ExecutionResult._decode(input);
      case 3:
        return Version._decode(input);
      case 4:
        return PalletsInfo._decode(input);
      case 5:
        return DispatchResult._decode(input);
      default:
        throw Exception('Response: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Response value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Null:
        (value as Null).encodeTo(output);
        break;
      case Assets:
        (value as Assets).encodeTo(output);
        break;
      case ExecutionResult:
        (value as ExecutionResult).encodeTo(output);
        break;
      case Version:
        (value as Version).encodeTo(output);
        break;
      case PalletsInfo:
        (value as PalletsInfo).encodeTo(output);
        break;
      case DispatchResult:
        (value as DispatchResult).encodeTo(output);
        break;
      default:
        throw Exception('Response: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Response value) {
    switch (value.runtimeType) {
      case Null:
        return 1;
      case Assets:
        return (value as Assets)._sizeHint();
      case ExecutionResult:
        return (value as ExecutionResult)._sizeHint();
      case Version:
        return (value as Version)._sizeHint();
      case PalletsInfo:
        return (value as PalletsInfo)._sizeHint();
      case DispatchResult:
        return (value as DispatchResult)._sizeHint();
      default:
        throw Exception('Response: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Null extends Response {
  const Null();

  @override
  Map<String, dynamic> toJson() => {'Null': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }
}

class Assets extends Response {
  const Assets({required this.value0});

  factory Assets._decode(_i1.Input input) {
    return Assets(
      value0: const _i1.SequenceCodec<_i8.MultiAsset>(_i8.MultiAsset.codec).decode(input),
    );
  }

  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'Assets': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i8.MultiAsset>(_i8.MultiAsset.codec).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.SequenceCodec<_i8.MultiAsset>(_i8.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }
}

class ExecutionResult extends Response {
  const ExecutionResult({this.value0});

  factory ExecutionResult._decode(_i1.Input input) {
    return ExecutionResult(
      value0: const _i1.OptionCodec<_i4.Tuple2<int, _i5.Error>>(_i4.Tuple2Codec<int, _i5.Error>(
        _i1.U32Codec.codec,
        _i5.Error.codec,
      )).decode(input),
    );
  }

  final _i4.Tuple2<int, _i5.Error>? value0;

  @override
  Map<String, List<dynamic>?> toJson() => {
        'ExecutionResult': [
          value0?.value0,
          value0?.value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i4.Tuple2<int, _i5.Error>>(_i4.Tuple2Codec<int, _i5.Error>(
          _i1.U32Codec.codec,
          _i5.Error.codec,
        )).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.OptionCodec<_i4.Tuple2<int, _i5.Error>>(_i4.Tuple2Codec<int, _i5.Error>(
      _i1.U32Codec.codec,
      _i5.Error.codec,
    )).encodeTo(
      value0,
      output,
    );
  }
}

class Version extends Response {
  const Version({required this.value0});

  factory Version._decode(_i1.Input input) {
    return Version(
      value0: _i1.U32Codec.codec.decode(input),
    );
  }

  final int value0;

  @override
  Map<String, int> toJson() => {'Version': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }
}

class PalletsInfo extends Response {
  const PalletsInfo({required this.value0});

  factory PalletsInfo._decode(_i1.Input input) {
    return PalletsInfo(
      value0: const _i1.SequenceCodec<_i6.PalletInfo>(_i6.PalletInfo.codec).decode(input),
    );
  }

  final List<_i6.PalletInfo> value0;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {'PalletsInfo': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.SequenceCodec<_i6.PalletInfo>(_i6.PalletInfo.codec).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.SequenceCodec<_i6.PalletInfo>(_i6.PalletInfo.codec).encodeTo(
      value0,
      output,
    );
  }
}

class DispatchResult extends Response {
  const DispatchResult({required this.value0});

  factory DispatchResult._decode(_i1.Input input) {
    return DispatchResult(
      value0: _i7.MaybeErrorCode.codec.decode(input),
    );
  }

  final _i7.MaybeErrorCode value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'DispatchResult': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i7.MaybeErrorCode.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i7.MaybeErrorCode.codec.encodeTo(
      value0,
      output,
    );
  }
}
