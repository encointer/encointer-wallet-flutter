// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../primitive_types/h256.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  ReportBridgeStatus reportBridgeStatus({
    required _i3.H256 bridgeId,
    required bool isCongested,
  }) {
    return ReportBridgeStatus(
      bridgeId: bridgeId,
      isCongested: isCongested,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ReportBridgeStatus._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case ReportBridgeStatus:
        (value as ReportBridgeStatus).encodeTo(output);
        break;
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ReportBridgeStatus:
        return (value as ReportBridgeStatus)._sizeHint();
      default:
        throw Exception('Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Notification about congested bridge queue.
class ReportBridgeStatus extends Call {
  const ReportBridgeStatus({
    required this.bridgeId,
    required this.isCongested,
  });

  factory ReportBridgeStatus._decode(_i1.Input input) {
    return ReportBridgeStatus(
      bridgeId: const _i1.U8ArrayCodec(32).decode(input),
      isCongested: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// H256
  final _i3.H256 bridgeId;

  /// bool
  final bool isCongested;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'report_bridge_status': {
          'bridgeId': bridgeId.toList(),
          'isCongested': isCongested,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(bridgeId);
    size = size + _i1.BoolCodec.codec.sizeHint(isCongested);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      bridgeId,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      isCongested,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReportBridgeStatus &&
          _i4.listsEqual(
            other.bridgeId,
            bridgeId,
          ) &&
          other.isCongested == isCongested;

  @override
  int get hashCode => Object.hash(
        bridgeId,
        isCongested,
      );
}
