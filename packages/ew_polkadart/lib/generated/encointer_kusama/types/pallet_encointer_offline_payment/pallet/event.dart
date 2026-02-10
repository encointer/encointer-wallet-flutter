// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../encointer_primitives/communities/community_identifier.dart' as _i4;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../substrate_fixed/fixed_u128.dart' as _i5;

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

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  OfflineIdentityRegistered offlineIdentityRegistered({
    required _i3.AccountId32 who,
    required List<int> commitment,
  }) {
    return OfflineIdentityRegistered(
      who: who,
      commitment: commitment,
    );
  }

  OfflinePaymentSettled offlinePaymentSettled({
    required _i3.AccountId32 sender,
    required _i3.AccountId32 recipient,
    required _i4.CommunityIdentifier cid,
    required _i5.FixedU128 amount,
    required List<int> nullifier,
  }) {
    return OfflinePaymentSettled(
      sender: sender,
      recipient: recipient,
      cid: cid,
      amount: amount,
      nullifier: nullifier,
    );
  }

  VerificationKeySet verificationKeySet() {
    return VerificationKeySet();
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return OfflineIdentityRegistered._decode(input);
      case 1:
        return OfflinePaymentSettled._decode(input);
      case 2:
        return const VerificationKeySet();
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
      case OfflineIdentityRegistered:
        (value as OfflineIdentityRegistered).encodeTo(output);
        break;
      case OfflinePaymentSettled:
        (value as OfflinePaymentSettled).encodeTo(output);
        break;
      case VerificationKeySet:
        (value as VerificationKeySet).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case OfflineIdentityRegistered:
        return (value as OfflineIdentityRegistered)._sizeHint();
      case OfflinePaymentSettled:
        return (value as OfflinePaymentSettled)._sizeHint();
      case VerificationKeySet:
        return 1;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Offline identity registered for an account
class OfflineIdentityRegistered extends Event {
  const OfflineIdentityRegistered({
    required this.who,
    required this.commitment,
  });

  factory OfflineIdentityRegistered._decode(_i1.Input input) {
    return OfflineIdentityRegistered(
      who: const _i1.U8ArrayCodec(32).decode(input),
      commitment: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// [u8; 32]
  final List<int> commitment;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'OfflineIdentityRegistered': {
          'who': who.toList(),
          'commitment': commitment.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(commitment);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      commitment,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OfflineIdentityRegistered &&
          _i6.listsEqual(
            other.who,
            who,
          ) &&
          _i6.listsEqual(
            other.commitment,
            commitment,
          );

  @override
  int get hashCode => Object.hash(
        who,
        commitment,
      );
}

/// Offline payment settled successfully
class OfflinePaymentSettled extends Event {
  const OfflinePaymentSettled({
    required this.sender,
    required this.recipient,
    required this.cid,
    required this.amount,
    required this.nullifier,
  });

  factory OfflinePaymentSettled._decode(_i1.Input input) {
    return OfflinePaymentSettled(
      sender: const _i1.U8ArrayCodec(32).decode(input),
      recipient: const _i1.U8ArrayCodec(32).decode(input),
      cid: _i4.CommunityIdentifier.codec.decode(input),
      amount: _i5.FixedU128.codec.decode(input),
      nullifier: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 sender;

  /// T::AccountId
  final _i3.AccountId32 recipient;

  /// CommunityIdentifier
  final _i4.CommunityIdentifier cid;

  /// BalanceType
  final _i5.FixedU128 amount;

  /// [u8; 32]
  final List<int> nullifier;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OfflinePaymentSettled': {
          'sender': sender.toList(),
          'recipient': recipient.toList(),
          'cid': cid.toJson(),
          'amount': amount.toJson(),
          'nullifier': nullifier.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(sender);
    size = size + const _i3.AccountId32Codec().sizeHint(recipient);
    size = size + _i4.CommunityIdentifier.codec.sizeHint(cid);
    size = size + _i5.FixedU128.codec.sizeHint(amount);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(nullifier);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sender,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      recipient,
      output,
    );
    _i4.CommunityIdentifier.codec.encodeTo(
      cid,
      output,
    );
    _i5.FixedU128.codec.encodeTo(
      amount,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      nullifier,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OfflinePaymentSettled &&
          _i6.listsEqual(
            other.sender,
            sender,
          ) &&
          _i6.listsEqual(
            other.recipient,
            recipient,
          ) &&
          other.cid == cid &&
          other.amount == amount &&
          _i6.listsEqual(
            other.nullifier,
            nullifier,
          );

  @override
  int get hashCode => Object.hash(
        sender,
        recipient,
        cid,
        amount,
        nullifier,
      );
}

/// Verification key was set
class VerificationKeySet extends Event {
  const VerificationKeySet();

  @override
  Map<String, dynamic> toJson() => {'VerificationKeySet': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is VerificationKeySet;

  @override
  int get hashCode => runtimeType.hashCode;
}
