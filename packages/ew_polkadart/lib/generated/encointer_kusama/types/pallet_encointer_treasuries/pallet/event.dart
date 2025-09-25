// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../encointer_primitives/communities/community_identifier.dart' as _i5;
import '../../polkadot_runtime_common/impls/versioned_locatable_asset.dart' as _i4;
import '../../sp_core/crypto/account_id32.dart' as _i3;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  SpentNative spentNative({
    required _i3.AccountId32 treasury,
    required _i3.AccountId32 beneficiary,
    required BigInt amount,
  }) {
    return SpentNative(
      treasury: treasury,
      beneficiary: beneficiary,
      amount: amount,
    );
  }

  SpentAsset spentAsset({
    required _i3.AccountId32 treasury,
    required _i3.AccountId32 beneficiary,
    required _i4.VersionedLocatableAsset assetId,
    required BigInt amount,
  }) {
    return SpentAsset(
      treasury: treasury,
      beneficiary: beneficiary,
      assetId: assetId,
      amount: amount,
    );
  }

  GrantedSwapNativeOption grantedSwapNativeOption({
    required _i5.CommunityIdentifier cid,
    required _i3.AccountId32 who,
  }) {
    return GrantedSwapNativeOption(
      cid: cid,
      who: who,
    );
  }

  GrantedSwapAssetOption grantedSwapAssetOption({
    required _i5.CommunityIdentifier cid,
    required _i3.AccountId32 who,
    required _i4.VersionedLocatableAsset assetId,
  }) {
    return GrantedSwapAssetOption(
      cid: cid,
      who: who,
      assetId: assetId,
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
        return SpentNative._decode(input);
      case 1:
        return SpentAsset._decode(input);
      case 2:
        return GrantedSwapNativeOption._decode(input);
      case 3:
        return GrantedSwapAssetOption._decode(input);
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
      case SpentNative:
        (value as SpentNative).encodeTo(output);
        break;
      case SpentAsset:
        (value as SpentAsset).encodeTo(output);
        break;
      case GrantedSwapNativeOption:
        (value as GrantedSwapNativeOption).encodeTo(output);
        break;
      case GrantedSwapAssetOption:
        (value as GrantedSwapAssetOption).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case SpentNative:
        return (value as SpentNative)._sizeHint();
      case SpentAsset:
        return (value as SpentAsset)._sizeHint();
      case GrantedSwapNativeOption:
        return (value as GrantedSwapNativeOption)._sizeHint();
      case GrantedSwapAssetOption:
        return (value as GrantedSwapAssetOption)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// treasury spent native tokens from community `cid` to `beneficiary` amounting `amount`
class SpentNative extends Event {
  const SpentNative({
    required this.treasury,
    required this.beneficiary,
    required this.amount,
  });

  factory SpentNative._decode(_i1.Input input) {
    return SpentNative(
      treasury: const _i1.U8ArrayCodec(32).decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 treasury;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SpentNative': {
          'treasury': treasury.toList(),
          'beneficiary': beneficiary.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(treasury);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      treasury,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpentNative &&
          _i6.listsEqual(
            other.treasury,
            treasury,
          ) &&
          _i6.listsEqual(
            other.beneficiary,
            beneficiary,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        treasury,
        beneficiary,
        amount,
      );
}

class SpentAsset extends Event {
  const SpentAsset({
    required this.treasury,
    required this.beneficiary,
    required this.assetId,
    required this.amount,
  });

  factory SpentAsset._decode(_i1.Input input) {
    return SpentAsset(
      treasury: const _i1.U8ArrayCodec(32).decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
      assetId: _i4.VersionedLocatableAsset.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 treasury;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  /// T::AssetKind
  final _i4.VersionedLocatableAsset assetId;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SpentAsset': {
          'treasury': treasury.toList(),
          'beneficiary': beneficiary.toList(),
          'assetId': assetId.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(treasury);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    size = size + _i4.VersionedLocatableAsset.codec.sizeHint(assetId);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      treasury,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
    _i4.VersionedLocatableAsset.codec.encodeTo(
      assetId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpentAsset &&
          _i6.listsEqual(
            other.treasury,
            treasury,
          ) &&
          _i6.listsEqual(
            other.beneficiary,
            beneficiary,
          ) &&
          other.assetId == assetId &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        treasury,
        beneficiary,
        assetId,
        amount,
      );
}

class GrantedSwapNativeOption extends Event {
  const GrantedSwapNativeOption({
    required this.cid,
    required this.who,
  });

  factory GrantedSwapNativeOption._decode(_i1.Input input) {
    return GrantedSwapNativeOption(
      cid: _i5.CommunityIdentifier.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// CommunityIdentifier
  final _i5.CommunityIdentifier cid;

  /// T::AccountId
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'GrantedSwapNativeOption': {
          'cid': cid.toJson(),
          'who': who.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.CommunityIdentifier.codec.sizeHint(cid);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i5.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is GrantedSwapNativeOption &&
          other.cid == cid &&
          _i6.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => Object.hash(
        cid,
        who,
      );
}

class GrantedSwapAssetOption extends Event {
  const GrantedSwapAssetOption({
    required this.cid,
    required this.who,
    required this.assetId,
  });

  factory GrantedSwapAssetOption._decode(_i1.Input input) {
    return GrantedSwapAssetOption(
      cid: _i5.CommunityIdentifier.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      assetId: _i4.VersionedLocatableAsset.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i5.CommunityIdentifier cid;

  /// T::AccountId
  final _i3.AccountId32 who;

  /// T::AssetKind
  final _i4.VersionedLocatableAsset assetId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'GrantedSwapAssetOption': {
          'cid': cid.toJson(),
          'who': who.toList(),
          'assetId': assetId.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.CommunityIdentifier.codec.sizeHint(cid);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i4.VersionedLocatableAsset.codec.sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i5.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i4.VersionedLocatableAsset.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is GrantedSwapAssetOption &&
          other.cid == cid &&
          _i6.listsEqual(
            other.who,
            who,
          ) &&
          other.assetId == assetId;

  @override
  int get hashCode => Object.hash(
        cid,
        who,
        assetId,
      );
}
