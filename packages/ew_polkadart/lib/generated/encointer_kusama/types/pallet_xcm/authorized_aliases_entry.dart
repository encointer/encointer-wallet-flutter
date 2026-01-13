// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../frame_support/traits/tokens/fungible/hold_consideration.dart' as _i3;
import '../xcm_runtime_apis/authorized_aliases/origin_aliaser.dart' as _i2;

class AuthorizedAliasesEntry {
  const AuthorizedAliasesEntry({
    required this.aliasers,
    required this.ticket,
  });

  factory AuthorizedAliasesEntry.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BoundedVec<OriginAliaser, MAX>
  final List<_i2.OriginAliaser> aliasers;

  /// Ticket
  final _i3.HoldConsideration ticket;

  static const $AuthorizedAliasesEntryCodec codec = $AuthorizedAliasesEntryCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'aliasers': aliasers.map((value) => value.toJson()).toList(),
        'ticket': ticket,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AuthorizedAliasesEntry &&
          _i5.listsEqual(
            other.aliasers,
            aliasers,
          ) &&
          other.ticket == ticket;

  @override
  int get hashCode => Object.hash(
        aliasers,
        ticket,
      );
}

class $AuthorizedAliasesEntryCodec with _i1.Codec<AuthorizedAliasesEntry> {
  const $AuthorizedAliasesEntryCodec();

  @override
  void encodeTo(
    AuthorizedAliasesEntry obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.OriginAliaser>(_i2.OriginAliaser.codec).encodeTo(
      obj.aliasers,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.ticket,
      output,
    );
  }

  @override
  AuthorizedAliasesEntry decode(_i1.Input input) {
    return AuthorizedAliasesEntry(
      aliasers: const _i1.SequenceCodec<_i2.OriginAliaser>(_i2.OriginAliaser.codec).decode(input),
      ticket: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AuthorizedAliasesEntry obj) {
    int size = 0;
    size = size + const _i1.SequenceCodec<_i2.OriginAliaser>(_i2.OriginAliaser.codec).sizeHint(obj.aliasers);
    size = size + const _i3.HoldConsiderationCodec().sizeHint(obj.ticket);
    return size;
  }

  @override
  bool isSizeZero() =>
      const _i1.SequenceCodec<_i2.OriginAliaser>(_i2.OriginAliaser.codec).isSizeZero() &&
      const _i3.HoldConsiderationCodec().isSizeZero();
}
