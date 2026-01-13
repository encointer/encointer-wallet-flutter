// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as _i4;
import 'package:substrate_metadata/substrate_metadata.dart' as _i2;

import '../types/encointer_kusama_runtime/runtime_call.dart' as _i7;
import '../types/pallet_membership/pallet/call.dart' as _i9;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i2.StorageValue<List<_i3.AccountId32>> _members = const _i2.StorageValue<List<_i3.AccountId32>>(
    prefix: 'Membership',
    storage: 'Members',
    valueCodec: _i4.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()),
  );

  final _i2.StorageValue<_i3.AccountId32> _prime = const _i2.StorageValue<_i3.AccountId32>(
    prefix: 'Membership',
    storage: 'Prime',
    valueCodec: _i3.AccountId32Codec(),
  );

  /// The current membership, stored as an ordered Vec.
  _i5.Future<List<_i3.AccountId32>> members({_i1.BlockHash? at}) async {
    final hashedKey = _members.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _members.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current prime member, if one exists.
  _i5.Future<_i3.AccountId32?> prime({_i1.BlockHash? at}) async {
    final hashedKey = _prime.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _prime.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `members`.
  _i6.Uint8List membersKey() {
    final hashedKey = _members.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `prime`.
  _i6.Uint8List primeKey() {
    final hashedKey = _prime.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Add a member `who` to the set.
  ///
  /// May only be called from `T::AddOrigin`.
  _i7.Membership addMember({required _i8.MultiAddress who}) {
    return _i7.Membership(_i9.AddMember(who: who));
  }

  /// Remove a member `who` from the set.
  ///
  /// May only be called from `T::RemoveOrigin`.
  _i7.Membership removeMember({required _i8.MultiAddress who}) {
    return _i7.Membership(_i9.RemoveMember(who: who));
  }

  /// Swap out one member `remove` for another `add`.
  ///
  /// May only be called from `T::SwapOrigin`.
  ///
  /// Prime membership is *not* passed from `remove` to `add`, if extant.
  _i7.Membership swapMember({
    required _i8.MultiAddress remove,
    required _i8.MultiAddress add,
  }) {
    return _i7.Membership(_i9.SwapMember(
      remove: remove,
      add: add,
    ));
  }

  /// Change the membership to a new set, disregarding the existing membership. Be nice and
  /// pass `members` pre-sorted.
  ///
  /// May only be called from `T::ResetOrigin`.
  _i7.Membership resetMembers({required List<_i3.AccountId32> members}) {
    return _i7.Membership(_i9.ResetMembers(members: members));
  }

  /// Swap out the sending member for some other key `new`.
  ///
  /// May only be called from `Signed` origin of a current member.
  ///
  /// Prime membership is passed from the origin account to `new`, if extant.
  _i7.Membership changeKey({required _i8.MultiAddress new_}) {
    return _i7.Membership(_i9.ChangeKey(new_: new_));
  }

  /// Set the prime member. Must be a current member.
  ///
  /// May only be called from `T::PrimeOrigin`.
  _i7.Membership setPrime({required _i8.MultiAddress who}) {
    return _i7.Membership(_i9.SetPrime(who: who));
  }

  /// Remove the prime member if it exists.
  ///
  /// May only be called from `T::PrimeOrigin`.
  _i7.Membership clearPrime() {
    return _i7.Membership(_i9.ClearPrime());
  }
}
