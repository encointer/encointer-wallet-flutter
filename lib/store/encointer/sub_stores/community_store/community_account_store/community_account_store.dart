import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/claim_of_attendance/claim_of_attendance.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

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
    Log.d("Set participant type: $participantType", 'CommunityAccountStore');
    this.participantType = type;
    writeToCache();
  }

  @action
  void purgeParticipantType() {
    if (participantType != null) {
      Log.d("Purging participantType.", 'CommunityAccountStore');
      this.participantType = null;
      writeToCache();
    }
  }

  @action
  void setMeetup(Meetup meetup) {
    Log.d("Set meetup: ${meetup.toJson()}", 'CommunityAccountStore');
    this.meetup = meetup;
    writeToCache();
  }

  @action
  void setMeetupCompleted() {
    Log.d("settingMeetupCompleted", 'CommunityAccountStore');
    meetupCompleted = true;
    writeToCache();
  }

  @action
  void clearMeetupCompleted() {
    Log.d("clearing meetupCompleted", 'CommunityAccountStore');
    meetupCompleted = false;
    writeToCache();
  }

  @action
  void purgeMeetup() {
    if (meetup != null) {
      Log.d("Purging meetup.", 'CommunityAccountStore');
      meetup = null;
      writeToCache();
    }
  }

  @action
  void purgeParticipantsClaims() {
    Log.d("Purging participantsClaims.", 'CommunityAccountStore');
    participantsClaims!.clear();
    writeToCache();
  }

  bool containsClaim(ClaimOfAttendance claim) {
    return participantsClaims![claim.claimantPublic] != null;
  }

  @action
  void addParticipantClaim(ClaimOfAttendance claim) {
    Log.d("adding participantsClaims.", 'CommunityAccountStore');
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
    this._cacheFn = cacheFn as Future<void> Function()?;
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value(null);
    }
  }
}
