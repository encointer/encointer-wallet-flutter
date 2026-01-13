// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;

import 'asset_filter.dart' as _i3;

abstract class AssetTransferFilter {
  const AssetTransferFilter();

  factory AssetTransferFilter.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AssetTransferFilterCodec codec = $AssetTransferFilterCodec();

  static const $AssetTransferFilter values = $AssetTransferFilter();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $AssetTransferFilter {
  const $AssetTransferFilter();

  Teleport teleport(_i3.AssetFilter value0) {
    return Teleport(value0);
  }

  ReserveDeposit reserveDeposit(_i3.AssetFilter value0) {
    return ReserveDeposit(value0);
  }

  ReserveWithdraw reserveWithdraw(_i3.AssetFilter value0) {
    return ReserveWithdraw(value0);
  }
}

class $AssetTransferFilterCodec with _i1.Codec<AssetTransferFilter> {
  const $AssetTransferFilterCodec();

  @override
  AssetTransferFilter decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Teleport._decode(input);
      case 1:
        return ReserveDeposit._decode(input);
      case 2:
        return ReserveWithdraw._decode(input);
      default:
        throw Exception('AssetTransferFilter: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AssetTransferFilter value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Teleport:
        (value as Teleport).encodeTo(output);
        break;
      case ReserveDeposit:
        (value as ReserveDeposit).encodeTo(output);
        break;
      case ReserveWithdraw:
        (value as ReserveWithdraw).encodeTo(output);
        break;
      default:
        throw Exception('AssetTransferFilter: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AssetTransferFilter value) {
    switch (value.runtimeType) {
      case Teleport:
        return (value as Teleport)._sizeHint();
      case ReserveDeposit:
        return (value as ReserveDeposit)._sizeHint();
      case ReserveWithdraw:
        return (value as ReserveWithdraw)._sizeHint();
      default:
        throw Exception('AssetTransferFilter: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  bool isSizeZero() => false;
}

class Teleport extends AssetTransferFilter {
  const Teleport(this.value0);

  factory Teleport._decode(_i1.Input input) {
    return Teleport(_i3.AssetFilter.codec.decode(input));
  }

  /// AssetFilter
  final _i3.AssetFilter value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Teleport': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.AssetFilter.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.AssetFilter.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Teleport && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ReserveDeposit extends AssetTransferFilter {
  const ReserveDeposit(this.value0);

  factory ReserveDeposit._decode(_i1.Input input) {
    return ReserveDeposit(_i3.AssetFilter.codec.decode(input));
  }

  /// AssetFilter
  final _i3.AssetFilter value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'ReserveDeposit': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.AssetFilter.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.AssetFilter.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReserveDeposit && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ReserveWithdraw extends AssetTransferFilter {
  const ReserveWithdraw(this.value0);

  factory ReserveWithdraw._decode(_i1.Input input) {
    return ReserveWithdraw(_i3.AssetFilter.codec.decode(input));
  }

  /// AssetFilter
  final _i3.AssetFilter value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'ReserveWithdraw': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.AssetFilter.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.AssetFilter.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReserveWithdraw && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
