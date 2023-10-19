
/// This file has been manually created based on the `runtime_events.dart`.
///
/// Procedure:
/// * Copy paste file
/// * Refactor type name *Event -> *Error
/// * Update import paths ../event.dart -> error.dart
/// * Delete entries that don't contain errors.
/// * Search & Replace: .Event -> .Error
/// * Fix toJson(): Map<String, xxx> -> Map<String, String>
/// * Remove special handling CumulusXcm error

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'generated/encointer_kusama/types/cumulus_pallet_dmp_queue/pallet/error.dart' as _i11;
import 'generated/encointer_kusama/types/cumulus_pallet_parachain_system/pallet/error.dart' as _i4;
import 'generated/encointer_kusama/types/cumulus_pallet_xcmp_queue/pallet/error.dart' as _i8;
import 'generated/encointer_kusama/types/frame_system/pallet/error.dart' as _i3;
import 'generated/encointer_kusama/types/pallet_balances/pallet/error.dart' as _i5;
import 'generated/encointer_kusama/types/pallet_collective/pallet/error.dart' as _i16;
import 'generated/encointer_kusama/types/pallet_encointer_balances/pallet/error.dart' as _i21;
import 'generated/encointer_kusama/types/pallet_encointer_bazaar/pallet/error.dart' as _i22;
import 'generated/encointer_kusama/types/pallet_encointer_ceremonies/pallet/error.dart' as _i19;
import 'generated/encointer_kusama/types/pallet_encointer_communities/pallet/error.dart' as _i20;
import 'generated/encointer_kusama/types/pallet_encointer_faucet/pallet/error.dart' as _i24;
import 'generated/encointer_kusama/types/pallet_encointer_reputation_commitments/pallet/error.dart' as _i23;
import 'generated/encointer_kusama/types/pallet_encointer_scheduler/pallet/error.dart' as _i18;
import 'generated/encointer_kusama/types/pallet_membership/pallet/error.dart' as _i17;
import 'generated/encointer_kusama/types/pallet_proxy/pallet/error.dart' as _i14;
import 'generated/encointer_kusama/types/pallet_scheduler/pallet/error.dart' as _i15;
import 'generated/encointer_kusama/types/pallet_treasury/pallet/error.dart' as _i13;
import 'generated/encointer_kusama/types/pallet_utility/pallet/error.dart' as _i12;
import 'generated/encointer_kusama/types/pallet_xcm/pallet/error.dart' as _i9;

abstract class RuntimeError {
  const RuntimeError();

  factory RuntimeError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Decode with help of the module variant index, and the encoded
  /// pallet error.
  ///
  /// This method was added by Encointer because the dispatch error
  /// is of the following format:
  /// `{dispatchError: {Module: {index: 61, error: [7, 0, 0, 0]}}`
  factory RuntimeError.decodeWithIndex(int index, List<int> input) {
    return decodeWithIndex(index, _i1.Input.fromBytes(input));
  }

  static const $RuntimeErrorCodec codec = $RuntimeErrorCodec();

  static const $RuntimeError values = $RuntimeError();

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

class $RuntimeError {
  const $RuntimeError();

  System system(_i3.Error value0) {
    return System(value0);
  }

  ParachainSystem parachainSystem(_i4.Error value0) {
    return ParachainSystem(value0);
  }

  Balances balances(_i5.Error value0) {
    return Balances(value0);
  }

  XcmpQueue xcmpQueue(_i8.Error value0) {
    return XcmpQueue(value0);
  }

  PolkadotXcm polkadotXcm(_i9.Error value0) {
    return PolkadotXcm(value0);
  }

  DmpQueue dmpQueue(_i11.Error value0) {
    return DmpQueue(value0);
  }

  Utility utility(_i12.Error value0) {
    return Utility(value0);
  }

  Treasury treasury(_i13.Error value0) {
    return Treasury(value0);
  }

  Proxy proxy(_i14.Error value0) {
    return Proxy(value0);
  }

  Scheduler scheduler(_i15.Error value0) {
    return Scheduler(value0);
  }

  Collective collective(_i16.Error value0) {
    return Collective(value0);
  }

  Membership membership(_i17.Error value0) {
    return Membership(value0);
  }

  EncointerScheduler encointerScheduler(_i18.Error value0) {
    return EncointerScheduler(value0);
  }

  EncointerCeremonies encointerCeremonies(_i19.Error value0) {
    return EncointerCeremonies(value0);
  }

  EncointerCommunities encointerCommunities(_i20.Error value0) {
    return EncointerCommunities(value0);
  }

  EncointerBalances encointerBalances(_i21.Error value0) {
    return EncointerBalances(value0);
  }

  EncointerBazaar encointerBazaar(_i22.Error value0) {
    return EncointerBazaar(value0);
  }

  EncointerReputationCommitments encointerReputationCommitments(_i23.Error value0) {
    return EncointerReputationCommitments(value0);
  }

  EncointerFaucet encointerFaucet(_i24.Error value0) {
    return EncointerFaucet(value0);
  }
}

class $RuntimeErrorCodec with _i1.Codec<RuntimeError> {
  const $RuntimeErrorCodec();

  @override
  RuntimeError decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    return decodeWithIndex(index, input);
  }

  @override
  void encodeTo(
    RuntimeError value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case System:
        (value as System).encodeTo(output);
        break;
      case ParachainSystem:
        (value as ParachainSystem).encodeTo(output);
        break;
      case Balances:
        (value as Balances).encodeTo(output);
        break;
      case XcmpQueue:
        (value as XcmpQueue).encodeTo(output);
        break;
      case PolkadotXcm:
        (value as PolkadotXcm).encodeTo(output);
        break;
      case DmpQueue:
        (value as DmpQueue).encodeTo(output);
        break;
      case Utility:
        (value as Utility).encodeTo(output);
        break;
      case Treasury:
        (value as Treasury).encodeTo(output);
        break;
      case Proxy:
        (value as Proxy).encodeTo(output);
        break;
      case Scheduler:
        (value as Scheduler).encodeTo(output);
        break;
      case Collective:
        (value as Collective).encodeTo(output);
        break;
      case Membership:
        (value as Membership).encodeTo(output);
        break;
      case EncointerScheduler:
        (value as EncointerScheduler).encodeTo(output);
        break;
      case EncointerCeremonies:
        (value as EncointerCeremonies).encodeTo(output);
        break;
      case EncointerCommunities:
        (value as EncointerCommunities).encodeTo(output);
        break;
      case EncointerBalances:
        (value as EncointerBalances).encodeTo(output);
        break;
      case EncointerBazaar:
        (value as EncointerBazaar).encodeTo(output);
        break;
      case EncointerReputationCommitments:
        (value as EncointerReputationCommitments).encodeTo(output);
        break;
      case EncointerFaucet:
        (value as EncointerFaucet).encodeTo(output);
        break;
      default:
        throw Exception('RuntimeEvent: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeError value) {
    switch (value.runtimeType) {
      case System:
        return (value as System)._sizeHint();
      case ParachainSystem:
        return (value as ParachainSystem)._sizeHint();
      case Balances:
        return (value as Balances)._sizeHint();
      case XcmpQueue:
        return (value as XcmpQueue)._sizeHint();
      case PolkadotXcm:
        return (value as PolkadotXcm)._sizeHint();
      case DmpQueue:
        return (value as DmpQueue)._sizeHint();
      case Utility:
        return (value as Utility)._sizeHint();
      case Treasury:
        return (value as Treasury)._sizeHint();
      case Proxy:
        return (value as Proxy)._sizeHint();
      case Scheduler:
        return (value as Scheduler)._sizeHint();
      case Collective:
        return (value as Collective)._sizeHint();
      case Membership:
        return (value as Membership)._sizeHint();
      case EncointerScheduler:
        return (value as EncointerScheduler)._sizeHint();
      case EncointerCeremonies:
        return (value as EncointerCeremonies)._sizeHint();
      case EncointerCommunities:
        return (value as EncointerCommunities)._sizeHint();
      case EncointerBalances:
        return (value as EncointerBalances)._sizeHint();
      case EncointerBazaar:
        return (value as EncointerBazaar)._sizeHint();
      case EncointerReputationCommitments:
        return (value as EncointerReputationCommitments)._sizeHint();
      case EncointerFaucet:
        return (value as EncointerFaucet)._sizeHint();
      default:
        throw Exception('RuntimeEvent: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

RuntimeError decodeWithIndex(int index, _i1.Input input) {
  switch (index) {
    case 0:
      return System._decode(input);
    case 1:
      return ParachainSystem._decode(input);
    case 10:
      return Balances._decode(input);
    case 30:
      return XcmpQueue._decode(input);
    case 31:
      return PolkadotXcm._decode(input);
    case 33:
      return DmpQueue._decode(input);
    case 40:
      return Utility._decode(input);
    case 43:
      return Treasury._decode(input);
    case 44:
      return Proxy._decode(input);
    case 48:
      return Scheduler._decode(input);
    case 50:
      return Collective._decode(input);
    case 51:
      return Membership._decode(input);
    case 60:
      return EncointerScheduler._decode(input);
    case 61:
      return EncointerCeremonies._decode(input);
    case 62:
      return EncointerCommunities._decode(input);
    case 63:
      return EncointerBalances._decode(input);
    case 64:
      return EncointerBazaar._decode(input);
    case 65:
      return EncointerReputationCommitments._decode(input);
    case 66:
      return EncointerFaucet._decode(input);
    default:
      throw Exception('RuntimeEvent: Invalid variant index: "$index"');
  }
}

class System extends RuntimeError {
  const System(this.value0);

  factory System._decode(_i1.Input input) {
    return System(_i3.Error.codec.decode(input));
  }

  /// frame_system::Event<Runtime>
  final _i3.Error value0;

  @override
  Map<String, String> toJson() => {'System': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Error.codec.encodeTo(
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
      other is System && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ParachainSystem extends RuntimeError {
  const ParachainSystem(this.value0);

  factory ParachainSystem._decode(_i1.Input input) {
    return ParachainSystem(_i4.Error.codec.decode(input));
  }

  /// cumulus_pallet_parachain_system::Event<Runtime>
  final _i4.Error value0;

  @override
  Map<String, String> toJson() => {'ParachainSystem': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.Error.codec.encodeTo(
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
      other is ParachainSystem && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Balances extends RuntimeError {
  const Balances(this.value0);

  factory Balances._decode(_i1.Input input) {
    return Balances(_i5.Error.codec.decode(input));
  }

  /// pallet_balances::Event<Runtime>
  final _i5.Error value0;

  @override
  Map<String, String> toJson() => {'Balances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i5.Error.codec.encodeTo(
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
      other is Balances && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}


class XcmpQueue extends RuntimeError {
  const XcmpQueue(this.value0);

  factory XcmpQueue._decode(_i1.Input input) {
    return XcmpQueue(_i8.Error.codec.decode(input));
  }

  /// cumulus_pallet_xcmp_queue::Event<Runtime>
  final _i8.Error value0;

  @override
  Map<String, String> toJson() => {'XcmpQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i8.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i8.Error.codec.encodeTo(
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
      other is XcmpQueue && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PolkadotXcm extends RuntimeError {
  const PolkadotXcm(this.value0);

  factory PolkadotXcm._decode(_i1.Input input) {
    return PolkadotXcm(_i9.Error.codec.decode(input));
  }

  /// pallet_xcm::Event<Runtime>
  final _i9.Error value0;

  @override
  Map<String, String> toJson() => {'PolkadotXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i9.Error.codec.encodeTo(
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
      other is PolkadotXcm && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class DmpQueue extends RuntimeError {
  const DmpQueue(this.value0);

  factory DmpQueue._decode(_i1.Input input) {
    return DmpQueue(_i11.Error.codec.decode(input));
  }

  /// cumulus_pallet_dmp_queue::Event<Runtime>
  final _i11.Error value0;

  @override
  Map<String, String> toJson() => {'DmpQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
    _i11.Error.codec.encodeTo(
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
      other is DmpQueue && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Utility extends RuntimeError {
  const Utility(this.value0);

  factory Utility._decode(_i1.Input input) {
    return Utility(_i12.Error.codec.decode(input));
  }

  /// pallet_utility::Event
  final _i12.Error value0;

  @override
  Map<String, String> toJson() => {'Utility': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i12.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i12.Error.codec.encodeTo(
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
      other is Utility && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Treasury extends RuntimeError {
  const Treasury(this.value0);

  factory Treasury._decode(_i1.Input input) {
    return Treasury(_i13.Error.codec.decode(input));
  }

  /// pallet_treasury::Event<Runtime>
  final _i13.Error value0;

  @override
  Map<String, String> toJson() => {'Treasury': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      43,
      output,
    );
    _i13.Error.codec.encodeTo(
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
      other is Treasury && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Proxy extends RuntimeError {
  const Proxy(this.value0);

  factory Proxy._decode(_i1.Input input) {
    return Proxy(_i14.Error.codec.decode(input));
  }

  /// pallet_proxy::Event<Runtime>
  final _i14.Error value0;

  @override
  Map<String, String> toJson() => {'Proxy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i14.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      44,
      output,
    );
    _i14.Error.codec.encodeTo(
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
      other is Proxy && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Scheduler extends RuntimeError {
  const Scheduler(this.value0);

  factory Scheduler._decode(_i1.Input input) {
    return Scheduler(_i15.Error.codec.decode(input));
  }

  /// pallet_scheduler::Event<Runtime>
  final _i15.Error value0;

  @override
  Map<String, String> toJson() => {'Scheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i15.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      48,
      output,
    );
    _i15.Error.codec.encodeTo(
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
      other is Scheduler && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Collective extends RuntimeError {
  const Collective(this.value0);

  factory Collective._decode(_i1.Input input) {
    return Collective(_i16.Error.codec.decode(input));
  }

  /// pallet_collective::Event<Runtime, pallet_collective::Instance1>
  final _i16.Error value0;

  @override
  Map<String, String> toJson() => {'Collective': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i16.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      50,
      output,
    );
    _i16.Error.codec.encodeTo(
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
      other is Collective && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Membership extends RuntimeError {
  const Membership(this.value0);

  factory Membership._decode(_i1.Input input) {
    return Membership(_i17.Error.codec.decode(input));
  }

  /// pallet_membership::Event<Runtime, pallet_membership::Instance1>
  final _i17.Error value0;

  @override
  Map<String, String> toJson() => {'Membership': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i17.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      51,
      output,
    );
    _i17.Error.codec.encodeTo(
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
      other is Membership && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerScheduler extends RuntimeError {
  const EncointerScheduler(this.value0);

  factory EncointerScheduler._decode(_i1.Input input) {
    return EncointerScheduler(_i18.Error.codec.decode(input));
  }

  /// pallet_encointer_scheduler::Event
  final _i18.Error value0;

  @override
  Map<String, String> toJson() => {'EncointerScheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      60,
      output,
    );
    _i18.Error.codec.encodeTo(
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
      other is EncointerScheduler && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerCeremonies extends RuntimeError {
  const EncointerCeremonies(this.value0);

  factory EncointerCeremonies._decode(_i1.Input input) {
    return EncointerCeremonies(_i19.Error.codec.decode(input));
  }

  /// pallet_encointer_ceremonies::Event<Runtime>
  final _i19.Error value0;

  @override
  Map<String, String> toJson() => {'EncointerCeremonies': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i19.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      61,
      output,
    );
    _i19.Error.codec.encodeTo(
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
      other is EncointerCeremonies && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerCommunities extends RuntimeError {
  const EncointerCommunities(this.value0);

  factory EncointerCommunities._decode(_i1.Input input) {
    return EncointerCommunities(_i20.Error.codec.decode(input));
  }

  /// pallet_encointer_communities::Event<Runtime>
  final _i20.Error value0;

  @override
  Map<String, String> toJson() => {'EncointerCommunities': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i20.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      62,
      output,
    );
    _i20.Error.codec.encodeTo(
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
      other is EncointerCommunities && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerBalances extends RuntimeError {
  const EncointerBalances(this.value0);

  factory EncointerBalances._decode(_i1.Input input) {
    return EncointerBalances(_i21.Error.codec.decode(input));
  }

  /// pallet_encointer_balances::Event<Runtime>
  final _i21.Error value0;

  @override
  Map<String, String> toJson() => {'EncointerBalances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i21.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      63,
      output,
    );
    _i21.Error.codec.encodeTo(
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
      other is EncointerBalances && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerBazaar extends RuntimeError {
  const EncointerBazaar(this.value0);

  factory EncointerBazaar._decode(_i1.Input input) {
    return EncointerBazaar(_i22.Error.codec.decode(input));
  }

  /// pallet_encointer_bazaar::Event<Runtime>
  final _i22.Error value0;

  @override
  Map<String, String> toJson() => {'EncointerBazaar': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i22.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      64,
      output,
    );
    _i22.Error.codec.encodeTo(
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
      other is EncointerBazaar && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerReputationCommitments extends RuntimeError {
  const EncointerReputationCommitments(this.value0);

  factory EncointerReputationCommitments._decode(_i1.Input input) {
    return EncointerReputationCommitments(_i23.Error.codec.decode(input));
  }

  /// pallet_encointer_reputation_commitments::Event<Runtime>
  final _i23.Error value0;

  @override
  Map<String, String> toJson() => {'EncointerReputationCommitments': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i23.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      65,
      output,
    );
    _i23.Error.codec.encodeTo(
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
      other is EncointerReputationCommitments && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerFaucet extends RuntimeError {
  const EncointerFaucet(this.value0);

  factory EncointerFaucet._decode(_i1.Input input) {
    return EncointerFaucet(_i24.Error.codec.decode(input));
  }

  /// pallet_encointer_faucet::Event<Runtime>
  final _i24.Error value0;

  @override
  Map<String, String> toJson() => {'EncointerFaucet': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i24.Error.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      66,
      output,
    );
    _i24.Error.codec.encodeTo(
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
      other is EncointerFaucet && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
