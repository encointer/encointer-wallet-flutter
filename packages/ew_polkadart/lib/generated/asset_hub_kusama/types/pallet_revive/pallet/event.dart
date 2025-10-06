// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../primitive_types/h160.dart' as _i3;
import '../../primitive_types/h256.dart' as _i4;

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

  Map<String, Map<String, List<dynamic>>> toJson();
}

class $Event {
  const $Event();

  ContractEmitted contractEmitted({
    required _i3.H160 contract,
    required List<int> data,
    required List<_i4.H256> topics,
  }) {
    return ContractEmitted(
      contract: contract,
      data: data,
      topics: topics,
    );
  }

  Instantiated instantiated({
    required _i3.H160 deployer,
    required _i3.H160 contract,
  }) {
    return Instantiated(
      deployer: deployer,
      contract: contract,
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
        return ContractEmitted._decode(input);
      case 1:
        return Instantiated._decode(input);
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
      case ContractEmitted:
        (value as ContractEmitted).encodeTo(output);
        break;
      case Instantiated:
        (value as Instantiated).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case ContractEmitted:
        return (value as ContractEmitted)._sizeHint();
      case Instantiated:
        return (value as Instantiated)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A custom event emitted by the contract.
class ContractEmitted extends Event {
  const ContractEmitted({
    required this.contract,
    required this.data,
    required this.topics,
  });

  factory ContractEmitted._decode(_i1.Input input) {
    return ContractEmitted(
      contract: const _i1.U8ArrayCodec(20).decode(input),
      data: _i1.U8SequenceCodec.codec.decode(input),
      topics: const _i1.SequenceCodec<_i4.H256>(_i4.H256Codec()).decode(input),
    );
  }

  /// H160
  /// The contract that emitted the event.
  final _i3.H160 contract;

  /// Vec<u8>
  /// Data supplied by the contract. Metadata generated during contract compilation
  /// is needed to decode it.
  final List<int> data;

  /// Vec<H256>
  /// A list of topics used to index the event.
  /// Number of topics is capped by [`limits::NUM_EVENT_TOPICS`].
  final List<_i4.H256> topics;

  @override
  Map<String, Map<String, List<dynamic>>> toJson() => {
        'ContractEmitted': {
          'contract': contract.toList(),
          'data': data,
          'topics': topics.map((value) => value.toList()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H160Codec().sizeHint(contract);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(data);
    size = size + const _i1.SequenceCodec<_i4.H256>(_i4.H256Codec()).sizeHint(topics);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      contract,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      data,
      output,
    );
    const _i1.SequenceCodec<_i4.H256>(_i4.H256Codec()).encodeTo(
      topics,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ContractEmitted &&
          _i5.listsEqual(
            other.contract,
            contract,
          ) &&
          _i5.listsEqual(
            other.data,
            data,
          ) &&
          _i5.listsEqual(
            other.topics,
            topics,
          );

  @override
  int get hashCode => Object.hash(
        contract,
        data,
        topics,
      );
}

/// Contract deployed by deployer at the specified address.
class Instantiated extends Event {
  const Instantiated({
    required this.deployer,
    required this.contract,
  });

  factory Instantiated._decode(_i1.Input input) {
    return Instantiated(
      deployer: const _i1.U8ArrayCodec(20).decode(input),
      contract: const _i1.U8ArrayCodec(20).decode(input),
    );
  }

  /// H160
  final _i3.H160 deployer;

  /// H160
  final _i3.H160 contract;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Instantiated': {
          'deployer': deployer.toList(),
          'contract': contract.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H160Codec().sizeHint(deployer);
    size = size + const _i3.H160Codec().sizeHint(contract);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      deployer,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      contract,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Instantiated &&
          _i5.listsEqual(
            other.deployer,
            deployer,
          ) &&
          _i5.listsEqual(
            other.contract,
            contract,
          );

  @override
  int get hashCode => Object.hash(
        deployer,
        contract,
      );
}
