import 'dart:convert';

import 'package:encointer_wallet/models/claim_of_attendance/claim_of_attendance.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'community_account_store.g.dart';

/// Stores data specific to an account **and** an encointer community.
///
///
@JsonSerializable(explicitToJson: true)
class CommunityAccountStore extends _CommunityAccountStore with _$CommunityAccountStore {
  CommunityAccountStore(String network, CommunityIdentifier cid, String address) : super(network, cid, address);

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CommunityAccountStore.fromJson(Map<String, dynamic> json) => _$CommunityAccountStoreFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityAccountStoreToJson(this);
}

abstract class _CommunityAccountStore with Store {
  _CommunityAccountStore(this.network, this.cid, this.address);

  /// Function that writes the store to local storage.
  @JsonKey(ignore: true)
  Future<void> Function()? _cacheFn;

  /// The network this store belongs to.
  final String network;

  /// The community this store belongs to.
  final CommunityIdentifier cid;

  /// The account (SS58) this store belongs to.
  final String address;

  /// Participant type if the account has registered for the next meetup.
  @observable
  ParticipantType? participantType;

  /// Contains the meetup data if the account has been assigned to a meetup in this community.
  @observable
  Meetup? meetup;

  /// `ClaimOfAttendances` that were scanned during a meetup.
  ///
  /// Map: claimantPublicKey -> ClaimOfAttendance
  @observable
  ObservableMap<String, ClaimOfAttendance>? participantsClaims = ObservableMap();

  /// This should be set to true once the attestations have been sent to chain.
  @observable
  bool? meetupCompleted = false;

  @computed
  get scannedClaimsCount => participantsClaims?.length ?? 0;

  @computed
  bool get isAssigned => meetup != null;

  @computed
  bool get isRegistered => participantType != null;

  @action
  void setParticipantType([ParticipantType? type]) {
    _log('Set participant type: ${participantType.toString()}');
    participantType = type;
    writeToCache();
  }

  @action
  void purgeParticipantType() {
    if (participantType != null) {
      _log('Purging participantType.');
      participantType = null;
      writeToCache();
    }
  }

  @action
  void setMeetup(Meetup meetup) {
    _log('Set meetup: ${meetup.toJson()}');
    this.meetup = meetup;
    writeToCache();
  }

  @action
  void setMeetupCompleted() {
    _log('settingMeetupCompleted');
    meetupCompleted = true;
    writeToCache();
  }

  @action
  void clearMeetupCompleted() {
    _log('clearing meetupCompleted');
    meetupCompleted = false;
    writeToCache();
  }

  @action
  void purgeMeetup() {
    if (meetup != null) {
      _log('Purging meetup.');
      meetup = null;
      writeToCache();
    }
  }

  @action
  void purgeParticipantsClaims() {
    _log('Purging participantsClaims.');
    participantsClaims!.clear();
    writeToCache();
  }

  bool containsClaim(ClaimOfAttendance claim) {
    return participantsClaims![claim.claimantPublic] != null;
  }

  @action
  void addParticipantClaim(ClaimOfAttendance claim) {
    _log('adding participantsClaims.');
    participantsClaims![claim.claimantPublic!] = claim;
    writeToCache();
  }

  /// Purges state that is only relevant for one Ceremony.
  ///
  /// This should be called when a transition to the next ceremony happens.
  @action
  void purgeCeremonySpecificState() {
    purgeParticipantsClaims();
    purgeParticipantType();
    purgeMeetup();
    clearMeetupCompleted();
  }

  void initStore(Function? cacheFn) {
    _cacheFn = cacheFn as Future<void> Function()?;
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value(null);
    }
  }
}

_log(String msg) {
  print('[CommunityAccountStore] $msg');
}
