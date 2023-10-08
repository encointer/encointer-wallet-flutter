// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;
import 'dart:typed_data' as _i2;
import '../frame_system/pallet/call.dart' as _i3;
import '../cumulus_pallet_parachain_system/pallet/call.dart' as _i4;
import '../pallet_timestamp/pallet/call.dart' as _i5;
import '../pallet_balances/pallet/call.dart' as _i6;
import '../cumulus_pallet_xcmp_queue/pallet/call.dart' as _i7;
import '../pallet_xcm/pallet/call.dart' as _i8;
import '../cumulus_pallet_dmp_queue/pallet/call.dart' as _i9;
import '../pallet_utility/pallet/call.dart' as _i10;
import '../pallet_treasury/pallet/call.dart' as _i11;
import '../pallet_proxy/pallet/call.dart' as _i12;
import '../pallet_scheduler/pallet/call.dart' as _i13;
import '../pallet_collective/pallet/call.dart' as _i14;
import '../pallet_membership/pallet/call.dart' as _i15;
import '../pallet_encointer_scheduler/pallet/call.dart' as _i16;
import '../pallet_encointer_ceremonies/pallet/call.dart' as _i17;
import '../pallet_encointer_communities/pallet/call.dart' as _i18;
import '../pallet_encointer_balances/pallet/call.dart' as _i19;
import '../pallet_encointer_bazaar/pallet/call.dart' as _i20;
import '../pallet_encointer_reputation_commitments/pallet/call.dart' as _i21;
import '../pallet_encointer_faucet/pallet/call.dart' as _i22;

abstract class RuntimeCall {
  const RuntimeCall();

  factory RuntimeCall.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeCallCodec codec = $RuntimeCallCodec();

  static const $RuntimeCall values = $RuntimeCall();

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

class $RuntimeCall {
  const $RuntimeCall();

  System system({required _i3.Call value0}) {
    return System(
      value0: value0,
    );
  }

  ParachainSystem parachainSystem({required _i4.Call value0}) {
    return ParachainSystem(
      value0: value0,
    );
  }

  Timestamp timestamp({required _i5.Call value0}) {
    return Timestamp(
      value0: value0,
    );
  }

  Balances balances({required _i6.Call value0}) {
    return Balances(
      value0: value0,
    );
  }

  XcmpQueue xcmpQueue({required _i7.Call value0}) {
    return XcmpQueue(
      value0: value0,
    );
  }

  PolkadotXcm polkadotXcm({required _i8.Call value0}) {
    return PolkadotXcm(
      value0: value0,
    );
  }

  DmpQueue dmpQueue({required _i9.Call value0}) {
    return DmpQueue(
      value0: value0,
    );
  }

  Utility utility({required _i10.Call value0}) {
    return Utility(
      value0: value0,
    );
  }

  Treasury treasury({required _i11.Call value0}) {
    return Treasury(
      value0: value0,
    );
  }

  Proxy proxy({required _i12.Call value0}) {
    return Proxy(
      value0: value0,
    );
  }

  Scheduler scheduler({required _i13.Call value0}) {
    return Scheduler(
      value0: value0,
    );
  }

  Collective collective({required _i14.Call value0}) {
    return Collective(
      value0: value0,
    );
  }

  Membership membership({required _i15.Call value0}) {
    return Membership(
      value0: value0,
    );
  }

  EncointerScheduler encointerScheduler({required _i16.Call value0}) {
    return EncointerScheduler(
      value0: value0,
    );
  }

  EncointerCeremonies encointerCeremonies({required _i17.Call value0}) {
    return EncointerCeremonies(
      value0: value0,
    );
  }

  EncointerCommunities encointerCommunities({required _i18.Call value0}) {
    return EncointerCommunities(
      value0: value0,
    );
  }

  EncointerBalances encointerBalances({required _i19.Call value0}) {
    return EncointerBalances(
      value0: value0,
    );
  }

  EncointerBazaar encointerBazaar({required _i20.Call value0}) {
    return EncointerBazaar(
      value0: value0,
    );
  }

  EncointerReputationCommitments encointerReputationCommitments({required _i21.Call value0}) {
    return EncointerReputationCommitments(
      value0: value0,
    );
  }

  EncointerFaucet encointerFaucet({required _i22.Call value0}) {
    return EncointerFaucet(
      value0: value0,
    );
  }
}

class $RuntimeCallCodec with _i1.Codec<RuntimeCall> {
  const $RuntimeCallCodec();

  @override
  RuntimeCall decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return System._decode(input);
      case 1:
        return ParachainSystem._decode(input);
      case 3:
        return Timestamp._decode(input);
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
        throw Exception('RuntimeCall: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeCall value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case System:
        (value as System).encodeTo(output);
        break;
      case ParachainSystem:
        (value as ParachainSystem).encodeTo(output);
        break;
      case Timestamp:
        (value as Timestamp).encodeTo(output);
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
        throw Exception('RuntimeCall: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeCall value) {
    switch (value.runtimeType) {
      case System:
        return (value as System)._sizeHint();
      case ParachainSystem:
        return (value as ParachainSystem)._sizeHint();
      case Timestamp:
        return (value as Timestamp)._sizeHint();
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
        throw Exception('RuntimeCall: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class System extends RuntimeCall {
  const System({required this.value0});

  factory System._decode(_i1.Input input) {
    return System(
      value0: _i3.Call.codec.decode(input),
    );
  }

  final _i3.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'System': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class ParachainSystem extends RuntimeCall {
  const ParachainSystem({required this.value0});

  factory ParachainSystem._decode(_i1.Input input) {
    return ParachainSystem(
      value0: _i4.Call.codec.decode(input),
    );
  }

  final _i4.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'ParachainSystem': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Timestamp extends RuntimeCall {
  const Timestamp({required this.value0});

  factory Timestamp._decode(_i1.Input input) {
    return Timestamp(
      value0: _i5.Call.codec.decode(input),
    );
  }

  final _i5.Call value0;

  @override
  Map<String, Map<String, Map<String, BigInt>>> toJson() => {'Timestamp': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i5.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Balances extends RuntimeCall {
  const Balances({required this.value0});

  factory Balances._decode(_i1.Input input) {
    return Balances(
      value0: _i6.Call.codec.decode(input),
    );
  }

  final _i6.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Balances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i6.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class XcmpQueue extends RuntimeCall {
  const XcmpQueue({required this.value0});

  factory XcmpQueue._decode(_i1.Input input) {
    return XcmpQueue(
      value0: _i7.Call.codec.decode(input),
    );
  }

  final _i7.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'XcmpQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i7.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i7.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class PolkadotXcm extends RuntimeCall {
  const PolkadotXcm({required this.value0});

  factory PolkadotXcm._decode(_i1.Input input) {
    return PolkadotXcm(
      value0: _i8.Call.codec.decode(input),
    );
  }

  final _i8.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'PolkadotXcm': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i8.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i8.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class DmpQueue extends RuntimeCall {
  const DmpQueue({required this.value0});

  factory DmpQueue._decode(_i1.Input input) {
    return DmpQueue(
      value0: _i9.Call.codec.decode(input),
    );
  }

  final _i9.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'DmpQueue': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
    _i9.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Utility extends RuntimeCall {
  const Utility({required this.value0});

  factory Utility._decode(_i1.Input input) {
    return Utility(
      value0: _i10.Call.codec.decode(input),
    );
  }

  final _i10.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Utility': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i10.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i10.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Treasury extends RuntimeCall {
  const Treasury({required this.value0});

  factory Treasury._decode(_i1.Input input) {
    return Treasury(
      value0: _i11.Call.codec.decode(input),
    );
  }

  final _i11.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Treasury': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      43,
      output,
    );
    _i11.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Proxy extends RuntimeCall {
  const Proxy({required this.value0});

  factory Proxy._decode(_i1.Input input) {
    return Proxy(
      value0: _i12.Call.codec.decode(input),
    );
  }

  final _i12.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Proxy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i12.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      44,
      output,
    );
    _i12.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Scheduler extends RuntimeCall {
  const Scheduler({required this.value0});

  factory Scheduler._decode(_i1.Input input) {
    return Scheduler(
      value0: _i13.Call.codec.decode(input),
    );
  }

  final _i13.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Scheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      48,
      output,
    );
    _i13.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Collective extends RuntimeCall {
  const Collective({required this.value0});

  factory Collective._decode(_i1.Input input) {
    return Collective(
      value0: _i14.Call.codec.decode(input),
    );
  }

  final _i14.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Collective': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i14.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      50,
      output,
    );
    _i14.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class Membership extends RuntimeCall {
  const Membership({required this.value0});

  factory Membership._decode(_i1.Input input) {
    return Membership(
      value0: _i15.Call.codec.decode(input),
    );
  }

  final _i15.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Membership': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i15.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      51,
      output,
    );
    _i15.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class EncointerScheduler extends RuntimeCall {
  const EncointerScheduler({required this.value0});

  factory EncointerScheduler._decode(_i1.Input input) {
    return EncointerScheduler(
      value0: _i16.Call.codec.decode(input),
    );
  }

  final _i16.Call value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'EncointerScheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i16.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      60,
      output,
    );
    _i16.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class EncointerCeremonies extends RuntimeCall {
  const EncointerCeremonies({required this.value0});

  factory EncointerCeremonies._decode(_i1.Input input) {
    return EncointerCeremonies(
      value0: _i17.Call.codec.decode(input),
    );
  }

  final _i17.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerCeremonies': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i17.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      61,
      output,
    );
    _i17.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class EncointerCommunities extends RuntimeCall {
  const EncointerCommunities({required this.value0});

  factory EncointerCommunities._decode(_i1.Input input) {
    return EncointerCommunities(
      value0: _i18.Call.codec.decode(input),
    );
  }

  final _i18.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerCommunities': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      62,
      output,
    );
    _i18.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class EncointerBalances extends RuntimeCall {
  const EncointerBalances({required this.value0});

  factory EncointerBalances._decode(_i1.Input input) {
    return EncointerBalances(
      value0: _i19.Call.codec.decode(input),
    );
  }

  final _i19.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerBalances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i19.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      63,
      output,
    );
    _i19.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class EncointerBazaar extends RuntimeCall {
  const EncointerBazaar({required this.value0});

  factory EncointerBazaar._decode(_i1.Input input) {
    return EncointerBazaar(
      value0: _i20.Call.codec.decode(input),
    );
  }

  final _i20.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerBazaar': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i20.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      64,
      output,
    );
    _i20.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class EncointerReputationCommitments extends RuntimeCall {
  const EncointerReputationCommitments({required this.value0});

  factory EncointerReputationCommitments._decode(_i1.Input input) {
    return EncointerReputationCommitments(
      value0: _i21.Call.codec.decode(input),
    );
  }

  final _i21.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerReputationCommitments': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i21.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      65,
      output,
    );
    _i21.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}

class EncointerFaucet extends RuntimeCall {
  const EncointerFaucet({required this.value0});

  factory EncointerFaucet._decode(_i1.Input input) {
    return EncointerFaucet(
      value0: _i22.Call.codec.decode(input),
    );
  }

  final _i22.Call value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerFaucet': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i22.Call.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      66,
      output,
    );
    _i22.Call.codec.encodeTo(
      value0,
      output,
    );
  }
}
