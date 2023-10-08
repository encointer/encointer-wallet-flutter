// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../primitive_types/h256.dart' as _i4;
import '../../sp_runtime/dispatch_error.dart' as _i5;

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

  Proposed proposed({
    required _i3.AccountId32 account,
    required int proposalIndex,
    required _i4.H256 proposalHash,
    required int threshold,
  }) {
    return Proposed(
      account: account,
      proposalIndex: proposalIndex,
      proposalHash: proposalHash,
      threshold: threshold,
    );
  }

  Voted voted({
    required _i3.AccountId32 account,
    required _i4.H256 proposalHash,
    required bool voted,
    required int yes,
    required int no,
  }) {
    return Voted(
      account: account,
      proposalHash: proposalHash,
      voted: voted,
      yes: yes,
      no: no,
    );
  }

  Approved approved({required _i4.H256 proposalHash}) {
    return Approved(
      proposalHash: proposalHash,
    );
  }

  Disapproved disapproved({required _i4.H256 proposalHash}) {
    return Disapproved(
      proposalHash: proposalHash,
    );
  }

  Executed executed({
    required _i4.H256 proposalHash,
    required _i1.Result<dynamic, _i5.DispatchError> result,
  }) {
    return Executed(
      proposalHash: proposalHash,
      result: result,
    );
  }

  MemberExecuted memberExecuted({
    required _i4.H256 proposalHash,
    required _i1.Result<dynamic, _i5.DispatchError> result,
  }) {
    return MemberExecuted(
      proposalHash: proposalHash,
      result: result,
    );
  }

  Closed closed({
    required _i4.H256 proposalHash,
    required int yes,
    required int no,
  }) {
    return Closed(
      proposalHash: proposalHash,
      yes: yes,
      no: no,
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
        return Proposed._decode(input);
      case 1:
        return Voted._decode(input);
      case 2:
        return Approved._decode(input);
      case 3:
        return Disapproved._decode(input);
      case 4:
        return Executed._decode(input);
      case 5:
        return MemberExecuted._decode(input);
      case 6:
        return Closed._decode(input);
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
      case Proposed:
        (value as Proposed).encodeTo(output);
        break;
      case Voted:
        (value as Voted).encodeTo(output);
        break;
      case Approved:
        (value as Approved).encodeTo(output);
        break;
      case Disapproved:
        (value as Disapproved).encodeTo(output);
        break;
      case Executed:
        (value as Executed).encodeTo(output);
        break;
      case MemberExecuted:
        (value as MemberExecuted).encodeTo(output);
        break;
      case Closed:
        (value as Closed).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Proposed:
        return (value as Proposed)._sizeHint();
      case Voted:
        return (value as Voted)._sizeHint();
      case Approved:
        return (value as Approved)._sizeHint();
      case Disapproved:
        return (value as Disapproved)._sizeHint();
      case Executed:
        return (value as Executed)._sizeHint();
      case MemberExecuted:
        return (value as MemberExecuted)._sizeHint();
      case Closed:
        return (value as Closed)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A motion (given hash) has been proposed (by given account) with a threshold (given
/// `MemberCount`).
class Proposed extends Event {
  const Proposed({
    required this.account,
    required this.proposalIndex,
    required this.proposalHash,
    required this.threshold,
  });

  factory Proposed._decode(_i1.Input input) {
    return Proposed(
      account: const _i1.U8ArrayCodec(32).decode(input),
      proposalIndex: _i1.U32Codec.codec.decode(input),
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      threshold: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i3.AccountId32 account;

  final int proposalIndex;

  final _i4.H256 proposalHash;

  final int threshold;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Proposed': {
          'account': account.toList(),
          'proposalIndex': proposalIndex,
          'proposalHash': proposalHash.toList(),
          'threshold': threshold,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(account);
    size = size + _i1.U32Codec.codec.sizeHint(proposalIndex);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    size = size + _i1.U32Codec.codec.sizeHint(threshold);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposalIndex,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      threshold,
      output,
    );
  }
}

/// A motion (given hash) has been voted on by given account, leaving
/// a tally (yes votes and no votes given respectively as `MemberCount`).
class Voted extends Event {
  const Voted({
    required this.account,
    required this.proposalHash,
    required this.voted,
    required this.yes,
    required this.no,
  });

  factory Voted._decode(_i1.Input input) {
    return Voted(
      account: const _i1.U8ArrayCodec(32).decode(input),
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      voted: _i1.BoolCodec.codec.decode(input),
      yes: _i1.U32Codec.codec.decode(input),
      no: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i3.AccountId32 account;

  final _i4.H256 proposalHash;

  final bool voted;

  final int yes;

  final int no;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Voted': {
          'account': account.toList(),
          'proposalHash': proposalHash.toList(),
          'voted': voted,
          'yes': yes,
          'no': no,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(account);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    size = size + _i1.BoolCodec.codec.sizeHint(voted);
    size = size + _i1.U32Codec.codec.sizeHint(yes);
    size = size + _i1.U32Codec.codec.sizeHint(no);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      voted,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      yes,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      no,
      output,
    );
  }
}

/// A motion was approved by the required threshold.
class Approved extends Event {
  const Approved({required this.proposalHash});

  factory Approved._decode(_i1.Input input) {
    return Approved(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i4.H256 proposalHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Approved': {'proposalHash': proposalHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
  }
}

/// A motion was not approved by the required threshold.
class Disapproved extends Event {
  const Disapproved({required this.proposalHash});

  factory Disapproved._decode(_i1.Input input) {
    return Disapproved(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  final _i4.H256 proposalHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Disapproved': {'proposalHash': proposalHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
  }
}

/// A motion was executed; result will be `Ok` if it returned without error.
class Executed extends Event {
  const Executed({
    required this.proposalHash,
    required this.result,
  });

  factory Executed._decode(_i1.Input input) {
    return Executed(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      result: const _i1.ResultCodec<dynamic, _i5.DispatchError>(
        _i1.NullCodec.codec,
        _i5.DispatchError.codec,
      ).decode(input),
    );
  }

  final _i4.H256 proposalHash;

  final _i1.Result<dynamic, _i5.DispatchError> result;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Executed': {
          'proposalHash': proposalHash.toList(),
          'result': result.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    size = size +
        const _i1.ResultCodec<dynamic, _i5.DispatchError>(
          _i1.NullCodec.codec,
          _i5.DispatchError.codec,
        ).sizeHint(result);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    const _i1.ResultCodec<dynamic, _i5.DispatchError>(
      _i1.NullCodec.codec,
      _i5.DispatchError.codec,
    ).encodeTo(
      result,
      output,
    );
  }
}

/// A single member did some action; result will be `Ok` if it returned without error.
class MemberExecuted extends Event {
  const MemberExecuted({
    required this.proposalHash,
    required this.result,
  });

  factory MemberExecuted._decode(_i1.Input input) {
    return MemberExecuted(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      result: const _i1.ResultCodec<dynamic, _i5.DispatchError>(
        _i1.NullCodec.codec,
        _i5.DispatchError.codec,
      ).decode(input),
    );
  }

  final _i4.H256 proposalHash;

  final _i1.Result<dynamic, _i5.DispatchError> result;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MemberExecuted': {
          'proposalHash': proposalHash.toList(),
          'result': result.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    size = size +
        const _i1.ResultCodec<dynamic, _i5.DispatchError>(
          _i1.NullCodec.codec,
          _i5.DispatchError.codec,
        ).sizeHint(result);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    const _i1.ResultCodec<dynamic, _i5.DispatchError>(
      _i1.NullCodec.codec,
      _i5.DispatchError.codec,
    ).encodeTo(
      result,
      output,
    );
  }
}

/// A proposal was closed because its threshold was reached or after its duration was up.
class Closed extends Event {
  const Closed({
    required this.proposalHash,
    required this.yes,
    required this.no,
  });

  factory Closed._decode(_i1.Input input) {
    return Closed(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      yes: _i1.U32Codec.codec.decode(input),
      no: _i1.U32Codec.codec.decode(input),
    );
  }

  final _i4.H256 proposalHash;

  final int yes;

  final int no;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Closed': {
          'proposalHash': proposalHash.toList(),
          'yes': yes,
          'no': no,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(proposalHash);
    size = size + _i1.U32Codec.codec.sizeHint(yes);
    size = size + _i1.U32Codec.codec.sizeHint(no);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      yes,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      no,
      output,
    );
  }
}
