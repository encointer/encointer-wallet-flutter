// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../frame_system/pallet/event.dart' as _i3;
import '../pallet_asset_tx_payment/pallet/event.dart' as _i7;
import '../pallet_balances/pallet/event.dart' as _i5;
import '../pallet_encointer_balances/pallet/event.dart' as _i16;
import '../pallet_encointer_bazaar/pallet/event.dart' as _i17;
import '../pallet_encointer_ceremonies/pallet/event.dart' as _i14;
import '../pallet_encointer_communities/pallet/event.dart' as _i15;
import '../pallet_encointer_democracy/pallet/event.dart' as _i20;
import '../pallet_encointer_faucet/pallet/event.dart' as _i19;
import '../pallet_encointer_reputation_commitments/pallet/event.dart' as _i18;
import '../pallet_encointer_scheduler/pallet/event.dart' as _i13;
import '../pallet_encointer_treasuries/pallet/event.dart' as _i21;
import '../pallet_grandpa/pallet/event.dart' as _i8;
import '../pallet_proxy/pallet/event.dart' as _i10;
import '../pallet_scheduler/pallet/event.dart' as _i11;
import '../pallet_sudo/pallet/event.dart' as _i4;
import '../pallet_transaction_payment/pallet/event.dart' as _i6;
import '../pallet_treasury/pallet/event.dart' as _i12;
import '../pallet_utility/pallet/event.dart' as _i9;

abstract class RuntimeEvent {
  const RuntimeEvent();

  factory RuntimeEvent.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeEventCodec codec = $RuntimeEventCodec();

  static const $RuntimeEvent values = $RuntimeEvent();

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

class $RuntimeEvent {
  const $RuntimeEvent();

  System system(_i3.Event value0) {
    return System(value0);
  }

  Sudo sudo(_i4.Event value0) {
    return Sudo(value0);
  }

  Balances balances(_i5.Event value0) {
    return Balances(value0);
  }

  TransactionPayment transactionPayment(_i6.Event value0) {
    return TransactionPayment(value0);
  }

  AssetTxPayment assetTxPayment(_i7.Event value0) {
    return AssetTxPayment(value0);
  }

  Grandpa grandpa(_i8.Event value0) {
    return Grandpa(value0);
  }

  Utility utility(_i9.Event value0) {
    return Utility(value0);
  }

  Proxy proxy(_i10.Event value0) {
    return Proxy(value0);
  }

  Scheduler scheduler(_i11.Event value0) {
    return Scheduler(value0);
  }

  Treasury treasury(_i12.Event value0) {
    return Treasury(value0);
  }

  EncointerScheduler encointerScheduler(_i13.Event value0) {
    return EncointerScheduler(value0);
  }

  EncointerCeremonies encointerCeremonies(_i14.Event value0) {
    return EncointerCeremonies(value0);
  }

  EncointerCommunities encointerCommunities(_i15.Event value0) {
    return EncointerCommunities(value0);
  }

  EncointerBalances encointerBalances(_i16.Event value0) {
    return EncointerBalances(value0);
  }

  EncointerBazaar encointerBazaar(_i17.Event value0) {
    return EncointerBazaar(value0);
  }

  EncointerReputationCommitments encointerReputationCommitments(_i18.Event value0) {
    return EncointerReputationCommitments(value0);
  }

  EncointerFaucet encointerFaucet(_i19.Event value0) {
    return EncointerFaucet(value0);
  }

  EncointerDemocracy encointerDemocracy(_i20.Event value0) {
    return EncointerDemocracy(value0);
  }

  EncointerTreasuries encointerTreasuries(_i21.Event value0) {
    return EncointerTreasuries(value0);
  }
}

class $RuntimeEventCodec with _i1.Codec<RuntimeEvent> {
  const $RuntimeEventCodec();

  @override
  RuntimeEvent decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return System._decode(input);
      case 5:
        return Sudo._decode(input);
      case 10:
        return Balances._decode(input);
      case 11:
        return TransactionPayment._decode(input);
      case 12:
        return AssetTxPayment._decode(input);
      case 25:
        return Grandpa._decode(input);
      case 40:
        return Utility._decode(input);
      case 44:
        return Proxy._decode(input);
      case 48:
        return Scheduler._decode(input);
      case 49:
        return Treasury._decode(input);
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
      case 67:
        return EncointerDemocracy._decode(input);
      case 68:
        return EncointerTreasuries._decode(input);
      default:
        throw Exception('RuntimeEvent: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeEvent value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case System:
        (value as System).encodeTo(output);
        break;
      case Sudo:
        (value as Sudo).encodeTo(output);
        break;
      case Balances:
        (value as Balances).encodeTo(output);
        break;
      case TransactionPayment:
        (value as TransactionPayment).encodeTo(output);
        break;
      case AssetTxPayment:
        (value as AssetTxPayment).encodeTo(output);
        break;
      case Grandpa:
        (value as Grandpa).encodeTo(output);
        break;
      case Utility:
        (value as Utility).encodeTo(output);
        break;
      case Proxy:
        (value as Proxy).encodeTo(output);
        break;
      case Scheduler:
        (value as Scheduler).encodeTo(output);
        break;
      case Treasury:
        (value as Treasury).encodeTo(output);
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
      case EncointerDemocracy:
        (value as EncointerDemocracy).encodeTo(output);
        break;
      case EncointerTreasuries:
        (value as EncointerTreasuries).encodeTo(output);
        break;
      default:
        throw Exception('RuntimeEvent: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeEvent value) {
    switch (value.runtimeType) {
      case System:
        return (value as System)._sizeHint();
      case Sudo:
        return (value as Sudo)._sizeHint();
      case Balances:
        return (value as Balances)._sizeHint();
      case TransactionPayment:
        return (value as TransactionPayment)._sizeHint();
      case AssetTxPayment:
        return (value as AssetTxPayment)._sizeHint();
      case Grandpa:
        return (value as Grandpa)._sizeHint();
      case Utility:
        return (value as Utility)._sizeHint();
      case Proxy:
        return (value as Proxy)._sizeHint();
      case Scheduler:
        return (value as Scheduler)._sizeHint();
      case Treasury:
        return (value as Treasury)._sizeHint();
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
      case EncointerDemocracy:
        return (value as EncointerDemocracy)._sizeHint();
      case EncointerTreasuries:
        return (value as EncointerTreasuries)._sizeHint();
      default:
        throw Exception('RuntimeEvent: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class System extends RuntimeEvent {
  const System(this.value0);

  factory System._decode(_i1.Input input) {
    return System(_i3.Event.codec.decode(input));
  }

  /// frame_system::Event<Runtime>
  final _i3.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'System': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Event.codec.encodeTo(
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

class Sudo extends RuntimeEvent {
  const Sudo(this.value0);

  factory Sudo._decode(_i1.Input input) {
    return Sudo(_i4.Event.codec.decode(input));
  }

  /// pallet_sudo::Event<Runtime>
  final _i4.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Sudo': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i4.Event.codec.encodeTo(
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
      other is Sudo && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Balances extends RuntimeEvent {
  const Balances(this.value0);

  factory Balances._decode(_i1.Input input) {
    return Balances(_i5.Event.codec.decode(input));
  }

  /// pallet_balances::Event<Runtime>
  final _i5.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Balances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i5.Event.codec.encodeTo(
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

class TransactionPayment extends RuntimeEvent {
  const TransactionPayment(this.value0);

  factory TransactionPayment._decode(_i1.Input input) {
    return TransactionPayment(_i6.Event.codec.decode(input));
  }

  /// pallet_transaction_payment::Event<Runtime>
  final _i6.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'TransactionPayment': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i6.Event.codec.encodeTo(
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
      other is TransactionPayment && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class AssetTxPayment extends RuntimeEvent {
  const AssetTxPayment(this.value0);

  factory AssetTxPayment._decode(_i1.Input input) {
    return AssetTxPayment(_i7.Event.codec.decode(input));
  }

  /// pallet_asset_tx_payment::Event<Runtime>
  final _i7.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'AssetTxPayment': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i7.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i7.Event.codec.encodeTo(
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
      other is AssetTxPayment && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Grandpa extends RuntimeEvent {
  const Grandpa(this.value0);

  factory Grandpa._decode(_i1.Input input) {
    return Grandpa(_i8.Event.codec.decode(input));
  }

  /// pallet_grandpa::Event
  final _i8.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Grandpa': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i8.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i8.Event.codec.encodeTo(
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
      other is Grandpa && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Utility extends RuntimeEvent {
  const Utility(this.value0);

  factory Utility._decode(_i1.Input input) {
    return Utility(_i9.Event.codec.decode(input));
  }

  /// pallet_utility::Event
  final _i9.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Utility': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i9.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      40,
      output,
    );
    _i9.Event.codec.encodeTo(
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

class Proxy extends RuntimeEvent {
  const Proxy(this.value0);

  factory Proxy._decode(_i1.Input input) {
    return Proxy(_i10.Event.codec.decode(input));
  }

  /// pallet_proxy::Event<Runtime>
  final _i10.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Proxy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i10.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      44,
      output,
    );
    _i10.Event.codec.encodeTo(
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

class Scheduler extends RuntimeEvent {
  const Scheduler(this.value0);

  factory Scheduler._decode(_i1.Input input) {
    return Scheduler(_i11.Event.codec.decode(input));
  }

  /// pallet_scheduler::Event<Runtime>
  final _i11.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Scheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i11.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      48,
      output,
    );
    _i11.Event.codec.encodeTo(
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

class Treasury extends RuntimeEvent {
  const Treasury(this.value0);

  factory Treasury._decode(_i1.Input input) {
    return Treasury(_i12.Event.codec.decode(input));
  }

  /// pallet_treasury::Event<Runtime>
  final _i12.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'Treasury': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i12.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      49,
      output,
    );
    _i12.Event.codec.encodeTo(
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

class EncointerScheduler extends RuntimeEvent {
  const EncointerScheduler(this.value0);

  factory EncointerScheduler._decode(_i1.Input input) {
    return EncointerScheduler(_i13.Event.codec.decode(input));
  }

  /// pallet_encointer_scheduler::Event
  final _i13.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'EncointerScheduler': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i13.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      60,
      output,
    );
    _i13.Event.codec.encodeTo(
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

class EncointerCeremonies extends RuntimeEvent {
  const EncointerCeremonies(this.value0);

  factory EncointerCeremonies._decode(_i1.Input input) {
    return EncointerCeremonies(_i14.Event.codec.decode(input));
  }

  /// pallet_encointer_ceremonies::Event<Runtime>
  final _i14.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'EncointerCeremonies': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i14.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      61,
      output,
    );
    _i14.Event.codec.encodeTo(
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

class EncointerCommunities extends RuntimeEvent {
  const EncointerCommunities(this.value0);

  factory EncointerCommunities._decode(_i1.Input input) {
    return EncointerCommunities(_i15.Event.codec.decode(input));
  }

  /// pallet_encointer_communities::Event<Runtime>
  final _i15.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'EncointerCommunities': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i15.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      62,
      output,
    );
    _i15.Event.codec.encodeTo(
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

class EncointerBalances extends RuntimeEvent {
  const EncointerBalances(this.value0);

  factory EncointerBalances._decode(_i1.Input input) {
    return EncointerBalances(_i16.Event.codec.decode(input));
  }

  /// pallet_encointer_balances::Event<Runtime>
  final _i16.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'EncointerBalances': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i16.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      63,
      output,
    );
    _i16.Event.codec.encodeTo(
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

class EncointerBazaar extends RuntimeEvent {
  const EncointerBazaar(this.value0);

  factory EncointerBazaar._decode(_i1.Input input) {
    return EncointerBazaar(_i17.Event.codec.decode(input));
  }

  /// pallet_encointer_bazaar::Event<Runtime>
  final _i17.Event value0;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() => {'EncointerBazaar': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i17.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      64,
      output,
    );
    _i17.Event.codec.encodeTo(
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

class EncointerReputationCommitments extends RuntimeEvent {
  const EncointerReputationCommitments(this.value0);

  factory EncointerReputationCommitments._decode(_i1.Input input) {
    return EncointerReputationCommitments(_i18.Event.codec.decode(input));
  }

  /// pallet_encointer_reputation_commitments::Event<Runtime>
  final _i18.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'EncointerReputationCommitments': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i18.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      65,
      output,
    );
    _i18.Event.codec.encodeTo(
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

class EncointerFaucet extends RuntimeEvent {
  const EncointerFaucet(this.value0);

  factory EncointerFaucet._decode(_i1.Input input) {
    return EncointerFaucet(_i19.Event.codec.decode(input));
  }

  /// pallet_encointer_faucet::Event<Runtime>
  final _i19.Event value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'EncointerFaucet': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i19.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      66,
      output,
    );
    _i19.Event.codec.encodeTo(
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

class EncointerDemocracy extends RuntimeEvent {
  const EncointerDemocracy(this.value0);

  factory EncointerDemocracy._decode(_i1.Input input) {
    return EncointerDemocracy(_i20.Event.codec.decode(input));
  }

  /// pallet_encointer_democracy::Event<Runtime>
  final _i20.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerDemocracy': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i20.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      67,
      output,
    );
    _i20.Event.codec.encodeTo(
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
      other is EncointerDemocracy && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class EncointerTreasuries extends RuntimeEvent {
  const EncointerTreasuries(this.value0);

  factory EncointerTreasuries._decode(_i1.Input input) {
    return EncointerTreasuries(_i21.Event.codec.decode(input));
  }

  /// pallet_encointer_treasuries::Event<Runtime>
  final _i21.Event value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {'EncointerTreasuries': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i21.Event.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      68,
      output,
    );
    _i21.Event.codec.encodeTo(
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
      other is EncointerTreasuries && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
