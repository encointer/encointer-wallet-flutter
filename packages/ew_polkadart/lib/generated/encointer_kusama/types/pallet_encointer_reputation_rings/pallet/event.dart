// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../encointer_primitives/communities/community_identifier.dart' as _i4;
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

  BandersnatchKeyRegistered bandersnatchKeyRegistered({
    required _i3.AccountId32 account,
    required List<int> key,
  }) {
    return BandersnatchKeyRegistered(
      account: account,
      key: key,
    );
  }

  RingComputationStarted ringComputationStarted({
    required _i4.CommunityIdentifier community,
    required int ceremonyIndex,
  }) {
    return RingComputationStarted(
      community: community,
      ceremonyIndex: ceremonyIndex,
    );
  }

  RingPublished ringPublished({
    required _i4.CommunityIdentifier community,
    required int ceremonyIndex,
    required int reputationLevel,
    required int subRingIndex,
    required int memberCount,
  }) {
    return RingPublished(
      community: community,
      ceremonyIndex: ceremonyIndex,
      reputationLevel: reputationLevel,
      subRingIndex: subRingIndex,
      memberCount: memberCount,
    );
  }

  RingComputationCompleted ringComputationCompleted({
    required _i4.CommunityIdentifier community,
    required int ceremonyIndex,
  }) {
    return RingComputationCompleted(
      community: community,
      ceremonyIndex: ceremonyIndex,
    );
  }

  MemberCollectionProgress memberCollectionProgress({
    required _i4.CommunityIdentifier community,
    required int ceremonyIndex,
    required int ceremoniesScanned,
  }) {
    return MemberCollectionProgress(
      community: community,
      ceremonyIndex: ceremonyIndex,
      ceremoniesScanned: ceremoniesScanned,
    );
  }

  AutomaticRingComputationQueued automaticRingComputationQueued({
    required int ceremonyIndex,
    required int communityCount,
  }) {
    return AutomaticRingComputationQueued(
      ceremonyIndex: ceremonyIndex,
      communityCount: communityCount,
    );
  }

  RingRegistryPurged ringRegistryPurged({required int ceremonyIndex}) {
    return RingRegistryPurged(ceremonyIndex: ceremonyIndex);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return BandersnatchKeyRegistered._decode(input);
      case 1:
        return RingComputationStarted._decode(input);
      case 2:
        return RingPublished._decode(input);
      case 3:
        return RingComputationCompleted._decode(input);
      case 4:
        return MemberCollectionProgress._decode(input);
      case 5:
        return AutomaticRingComputationQueued._decode(input);
      case 6:
        return RingRegistryPurged._decode(input);
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
      case BandersnatchKeyRegistered:
        (value as BandersnatchKeyRegistered).encodeTo(output);
        break;
      case RingComputationStarted:
        (value as RingComputationStarted).encodeTo(output);
        break;
      case RingPublished:
        (value as RingPublished).encodeTo(output);
        break;
      case RingComputationCompleted:
        (value as RingComputationCompleted).encodeTo(output);
        break;
      case MemberCollectionProgress:
        (value as MemberCollectionProgress).encodeTo(output);
        break;
      case AutomaticRingComputationQueued:
        (value as AutomaticRingComputationQueued).encodeTo(output);
        break;
      case RingRegistryPurged:
        (value as RingRegistryPurged).encodeTo(output);
        break;
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case BandersnatchKeyRegistered:
        return (value as BandersnatchKeyRegistered)._sizeHint();
      case RingComputationStarted:
        return (value as RingComputationStarted)._sizeHint();
      case RingPublished:
        return (value as RingPublished)._sizeHint();
      case RingComputationCompleted:
        return (value as RingComputationCompleted)._sizeHint();
      case MemberCollectionProgress:
        return (value as MemberCollectionProgress)._sizeHint();
      case AutomaticRingComputationQueued:
        return (value as AutomaticRingComputationQueued)._sizeHint();
      case RingRegistryPurged:
        return (value as RingRegistryPurged)._sizeHint();
      default:
        throw Exception('Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A Bandersnatch key was registered or updated.
class BandersnatchKeyRegistered extends Event {
  const BandersnatchKeyRegistered({
    required this.account,
    required this.key,
  });

  factory BandersnatchKeyRegistered._decode(_i1.Input input) {
    return BandersnatchKeyRegistered(
      account: const _i1.U8ArrayCodec(32).decode(input),
      key: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 account;

  /// BandersnatchPublicKey
  final List<int> key;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'BandersnatchKeyRegistered': {
          'account': account.toList(),
          'key': key.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(account);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(key);
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
    const _i1.U8ArrayCodec(32).encodeTo(
      key,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BandersnatchKeyRegistered &&
          _i5.listsEqual(
            other.account,
            account,
          ) &&
          _i5.listsEqual(
            other.key,
            key,
          );

  @override
  int get hashCode => Object.hash(
        account,
        key,
      );
}

/// Ring computation started for a community at a ceremony index.
class RingComputationStarted extends Event {
  const RingComputationStarted({
    required this.community,
    required this.ceremonyIndex,
  });

  factory RingComputationStarted._decode(_i1.Input input) {
    return RingComputationStarted(
      community: _i4.CommunityIdentifier.codec.decode(input),
      ceremonyIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i4.CommunityIdentifier community;

  /// CeremonyIndexType
  final int ceremonyIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'RingComputationStarted': {
          'community': community.toJson(),
          'ceremonyIndex': ceremonyIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.CommunityIdentifier.codec.sizeHint(community);
    size = size + _i1.U32Codec.codec.sizeHint(ceremonyIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.CommunityIdentifier.codec.encodeTo(
      community,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ceremonyIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RingComputationStarted && other.community == community && other.ceremonyIndex == ceremonyIndex;

  @override
  int get hashCode => Object.hash(
        community,
        ceremonyIndex,
      );
}

/// A sub-ring was published for a specific reputation level.
class RingPublished extends Event {
  const RingPublished({
    required this.community,
    required this.ceremonyIndex,
    required this.reputationLevel,
    required this.subRingIndex,
    required this.memberCount,
  });

  factory RingPublished._decode(_i1.Input input) {
    return RingPublished(
      community: _i4.CommunityIdentifier.codec.decode(input),
      ceremonyIndex: _i1.U32Codec.codec.decode(input),
      reputationLevel: _i1.U8Codec.codec.decode(input),
      subRingIndex: _i1.U32Codec.codec.decode(input),
      memberCount: _i1.U32Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i4.CommunityIdentifier community;

  /// CeremonyIndexType
  final int ceremonyIndex;

  /// u8
  final int reputationLevel;

  /// u32
  final int subRingIndex;

  /// u32
  final int memberCount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'RingPublished': {
          'community': community.toJson(),
          'ceremonyIndex': ceremonyIndex,
          'reputationLevel': reputationLevel,
          'subRingIndex': subRingIndex,
          'memberCount': memberCount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.CommunityIdentifier.codec.sizeHint(community);
    size = size + _i1.U32Codec.codec.sizeHint(ceremonyIndex);
    size = size + _i1.U8Codec.codec.sizeHint(reputationLevel);
    size = size + _i1.U32Codec.codec.sizeHint(subRingIndex);
    size = size + _i1.U32Codec.codec.sizeHint(memberCount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i4.CommunityIdentifier.codec.encodeTo(
      community,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ceremonyIndex,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      reputationLevel,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      subRingIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      memberCount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RingPublished &&
          other.community == community &&
          other.ceremonyIndex == ceremonyIndex &&
          other.reputationLevel == reputationLevel &&
          other.subRingIndex == subRingIndex &&
          other.memberCount == memberCount;

  @override
  int get hashCode => Object.hash(
        community,
        ceremonyIndex,
        reputationLevel,
        subRingIndex,
        memberCount,
      );
}

/// All 5 rings for a community/ceremony have been computed.
class RingComputationCompleted extends Event {
  const RingComputationCompleted({
    required this.community,
    required this.ceremonyIndex,
  });

  factory RingComputationCompleted._decode(_i1.Input input) {
    return RingComputationCompleted(
      community: _i4.CommunityIdentifier.codec.decode(input),
      ceremonyIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i4.CommunityIdentifier community;

  /// CeremonyIndexType
  final int ceremonyIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'RingComputationCompleted': {
          'community': community.toJson(),
          'ceremonyIndex': ceremonyIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.CommunityIdentifier.codec.sizeHint(community);
    size = size + _i1.U32Codec.codec.sizeHint(ceremonyIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i4.CommunityIdentifier.codec.encodeTo(
      community,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ceremonyIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RingComputationCompleted && other.community == community && other.ceremonyIndex == ceremonyIndex;

  @override
  int get hashCode => Object.hash(
        community,
        ceremonyIndex,
      );
}

/// A chunk of member collection was processed.
class MemberCollectionProgress extends Event {
  const MemberCollectionProgress({
    required this.community,
    required this.ceremonyIndex,
    required this.ceremoniesScanned,
  });

  factory MemberCollectionProgress._decode(_i1.Input input) {
    return MemberCollectionProgress(
      community: _i4.CommunityIdentifier.codec.decode(input),
      ceremonyIndex: _i1.U32Codec.codec.decode(input),
      ceremoniesScanned: _i1.U8Codec.codec.decode(input),
    );
  }

  /// CommunityIdentifier
  final _i4.CommunityIdentifier community;

  /// CeremonyIndexType
  final int ceremonyIndex;

  /// u8
  final int ceremoniesScanned;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MemberCollectionProgress': {
          'community': community.toJson(),
          'ceremonyIndex': ceremonyIndex,
          'ceremoniesScanned': ceremoniesScanned,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.CommunityIdentifier.codec.sizeHint(community);
    size = size + _i1.U32Codec.codec.sizeHint(ceremonyIndex);
    size = size + _i1.U8Codec.codec.sizeHint(ceremoniesScanned);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i4.CommunityIdentifier.codec.encodeTo(
      community,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ceremonyIndex,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      ceremoniesScanned,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MemberCollectionProgress &&
          other.community == community &&
          other.ceremonyIndex == ceremonyIndex &&
          other.ceremoniesScanned == ceremoniesScanned;

  @override
  int get hashCode => Object.hash(
        community,
        ceremonyIndex,
        ceremoniesScanned,
      );
}

/// Automatic ring computation queue was populated after ceremony completion.
class AutomaticRingComputationQueued extends Event {
  const AutomaticRingComputationQueued({
    required this.ceremonyIndex,
    required this.communityCount,
  });

  factory AutomaticRingComputationQueued._decode(_i1.Input input) {
    return AutomaticRingComputationQueued(
      ceremonyIndex: _i1.U32Codec.codec.decode(input),
      communityCount: _i1.U32Codec.codec.decode(input),
    );
  }

  /// CeremonyIndexType
  final int ceremonyIndex;

  /// u32
  final int communityCount;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AutomaticRingComputationQueued': {
          'ceremonyIndex': ceremonyIndex,
          'communityCount': communityCount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(ceremonyIndex);
    size = size + _i1.U32Codec.codec.sizeHint(communityCount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ceremonyIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      communityCount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AutomaticRingComputationQueued &&
          other.ceremonyIndex == ceremonyIndex &&
          other.communityCount == communityCount;

  @override
  int get hashCode => Object.hash(
        ceremonyIndex,
        communityCount,
      );
}

/// Ring registry purged for a ceremony index.
class RingRegistryPurged extends Event {
  const RingRegistryPurged({required this.ceremonyIndex});

  factory RingRegistryPurged._decode(_i1.Input input) {
    return RingRegistryPurged(ceremonyIndex: _i1.U32Codec.codec.decode(input));
  }

  /// CeremonyIndexType
  final int ceremonyIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'RingRegistryPurged': {'ceremonyIndex': ceremonyIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(ceremonyIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ceremonyIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RingRegistryPurged && other.ceremonyIndex == ceremonyIndex;

  @override
  int get hashCode => ceremonyIndex.hashCode;
}
