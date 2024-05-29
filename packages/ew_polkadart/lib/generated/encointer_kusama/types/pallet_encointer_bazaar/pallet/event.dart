// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../encointer_primitives/communities/community_identifier.dart'
    as _i3;
import '../../sp_core/crypto/account_id32.dart' as _i4;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, List<dynamic>> toJson();
}

class $Event {
  const $Event();

  BusinessCreated businessCreated(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
  ) {
    return BusinessCreated(
      value0,
      value1,
    );
  }

  BusinessUpdated businessUpdated(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
  ) {
    return BusinessUpdated(
      value0,
      value1,
    );
  }

  BusinessDeleted businessDeleted(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
  ) {
    return BusinessDeleted(
      value0,
      value1,
    );
  }

  OfferingCreated offeringCreated(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
    int value2,
  ) {
    return OfferingCreated(
      value0,
      value1,
      value2,
    );
  }

  OfferingUpdated offeringUpdated(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
    int value2,
  ) {
    return OfferingUpdated(
      value0,
      value1,
      value2,
    );
  }

  OfferingDeleted offeringDeleted(
    _i3.CommunityIdentifier value0,
    _i4.AccountId32 value1,
    int value2,
  ) {
    return OfferingDeleted(
      value0,
      value1,
      value2,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return BusinessCreated._decode(input);
      case 1:
        return BusinessUpdated._decode(input);
      case 2:
        return BusinessDeleted._decode(input);
      case 3:
        return OfferingCreated._decode(input);
      case 4:
        return OfferingUpdated._decode(input);
      case 5:
        return OfferingDeleted._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case BusinessCreated:
        (value as BusinessCreated).encodeTo(output);
        break;
      case BusinessUpdated:
        (value as BusinessUpdated).encodeTo(output);
        break;
      case BusinessDeleted:
        (value as BusinessDeleted).encodeTo(output);
        break;
      case OfferingCreated:
        (value as OfferingCreated).encodeTo(output);
        break;
      case OfferingUpdated:
        (value as OfferingUpdated).encodeTo(output);
        break;
      case OfferingDeleted:
        (value as OfferingDeleted).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case BusinessCreated:
        return (value as BusinessCreated)._sizeHint();
      case BusinessUpdated:
        return (value as BusinessUpdated)._sizeHint();
      case BusinessDeleted:
        return (value as BusinessDeleted)._sizeHint();
      case OfferingCreated:
        return (value as OfferingCreated)._sizeHint();
      case OfferingUpdated:
        return (value as OfferingUpdated)._sizeHint();
      case OfferingDeleted:
        return (value as OfferingDeleted)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Event emitted when a business is created. [community, who]
class BusinessCreated extends Event {
  const BusinessCreated(
    this.value0,
    this.value1,
  );

  factory BusinessCreated._decode(_i1.Input input) {
    return BusinessCreated(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'BusinessCreated': [
          value0.toJson(),
          value1.toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BusinessCreated &&
          other.value0 == value0 &&
          _i5.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Event emitted when a business is updated. [community, who]
class BusinessUpdated extends Event {
  const BusinessUpdated(
    this.value0,
    this.value1,
  );

  factory BusinessUpdated._decode(_i1.Input input) {
    return BusinessUpdated(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'BusinessUpdated': [
          value0.toJson(),
          value1.toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BusinessUpdated &&
          other.value0 == value0 &&
          _i5.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Event emitted when a business is deleted. [community, who]
class BusinessDeleted extends Event {
  const BusinessDeleted(
    this.value0,
    this.value1,
  );

  factory BusinessDeleted._decode(_i1.Input input) {
    return BusinessDeleted(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'BusinessDeleted': [
          value0.toJson(),
          value1.toList(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BusinessDeleted &&
          other.value0 == value0 &&
          _i5.listsEqual(
            other.value1,
            value1,
          );

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Event emitted when an offering is created. [community, who, oid]
class OfferingCreated extends Event {
  const OfferingCreated(
    this.value0,
    this.value1,
    this.value2,
  );

  factory OfferingCreated._decode(_i1.Input input) {
    return OfferingCreated(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  /// OfferingIdentifier
  final int value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'OfferingCreated': [
          value0.toJson(),
          value1.toList(),
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    size = size + _i1.U32Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OfferingCreated &&
          other.value0 == value0 &&
          _i5.listsEqual(
            other.value1,
            value1,
          ) &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// Event emitted when an offering is updated. [community, who, oid]
class OfferingUpdated extends Event {
  const OfferingUpdated(
    this.value0,
    this.value1,
    this.value2,
  );

  factory OfferingUpdated._decode(_i1.Input input) {
    return OfferingUpdated(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  /// OfferingIdentifier
  final int value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'OfferingUpdated': [
          value0.toJson(),
          value1.toList(),
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    size = size + _i1.U32Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OfferingUpdated &&
          other.value0 == value0 &&
          _i5.listsEqual(
            other.value1,
            value1,
          ) &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// Event emitted when an offering is deleted. [community, who, oid]
class OfferingDeleted extends Event {
  const OfferingDeleted(
    this.value0,
    this.value1,
    this.value2,
  );

  factory OfferingDeleted._decode(_i1.Input input) {
    return OfferingDeleted(
      _i3.CommunityIdentifier.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i3.CommunityIdentifier value0;

  /// T::AccountId
  final _i4.AccountId32 value1;

  /// OfferingIdentifier
  final int value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'OfferingDeleted': [
          value0.toJson(),
          value1.toList(),
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CommunityIdentifier.codec.sizeHint(value0);
    size = size + const _i4.AccountId32Codec().sizeHint(value1);
    size = size + _i1.U32Codec.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.CommunityIdentifier.codec.encodeTo(
      value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OfferingDeleted &&
          other.value0 == value0 &&
          _i5.listsEqual(
            other.value1,
            value1,
          ) &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}
