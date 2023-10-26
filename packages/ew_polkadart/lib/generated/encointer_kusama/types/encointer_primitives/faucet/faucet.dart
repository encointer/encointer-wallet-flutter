// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../communities/community_identifier.dart' as _i2;

class Faucet {
  const Faucet({
    required this.name,
    required this.purposeId,
    this.whitelist,
    required this.dripAmount,
    required this.creator,
  });

  factory Faucet.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// FaucetNameType
  final List<int> name;

  /// PurposeIdType
  final BigInt purposeId;

  /// Option<WhiteListType>
  final List<_i2.CommunityIdentifier>? whitelist;

  /// Balance
  final BigInt dripAmount;

  /// AccountId
  final _i3.AccountId32 creator;

  static const $FaucetCodec codec = $FaucetCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'purposeId': purposeId,
        'whitelist': whitelist?.map((value) => value.toJson()).toList(),
        'dripAmount': dripAmount,
        'creator': creator.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Faucet &&
          _i5.listsEqual(
            other.name,
            name,
          ) &&
          other.purposeId == purposeId &&
          other.whitelist == whitelist &&
          other.dripAmount == dripAmount &&
          _i5.listsEqual(
            other.creator,
            creator,
          );

  @override
  int get hashCode => Object.hash(
        name,
        purposeId,
        whitelist,
        dripAmount,
        creator,
      );
}

class $FaucetCodec with _i1.Codec<Faucet> {
  const $FaucetCodec();

  @override
  void encodeTo(
    Faucet obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.name,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.purposeId,
      output,
    );
    const _i1.OptionCodec<List<_i2.CommunityIdentifier>>(
            _i1.SequenceCodec<_i2.CommunityIdentifier>(_i2.CommunityIdentifier.codec))
        .encodeTo(
      obj.whitelist,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.dripAmount,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.creator,
      output,
    );
  }

  @override
  Faucet decode(_i1.Input input) {
    return Faucet(
      name: _i1.U8SequenceCodec.codec.decode(input),
      purposeId: _i1.U64Codec.codec.decode(input),
      whitelist: const _i1.OptionCodec<List<_i2.CommunityIdentifier>>(
              _i1.SequenceCodec<_i2.CommunityIdentifier>(_i2.CommunityIdentifier.codec))
          .decode(input),
      dripAmount: _i1.U128Codec.codec.decode(input),
      creator: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(Faucet obj) {
    int size = 0;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.name);
    size = size + _i1.U64Codec.codec.sizeHint(obj.purposeId);
    size = size +
        const _i1.OptionCodec<List<_i2.CommunityIdentifier>>(
                _i1.SequenceCodec<_i2.CommunityIdentifier>(_i2.CommunityIdentifier.codec))
            .sizeHint(obj.whitelist);
    size = size + _i1.U128Codec.codec.sizeHint(obj.dripAmount);
    size = size + const _i3.AccountId32Codec().sizeHint(obj.creator);
    return size;
  }
}
