import 'dart:convert';

import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../../../../models/index.dart';

part 'communityAccountStore.g.dart';

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
  Future<void> Function() cacheFn;

  /// The network this store belongs to.
  final String network;

  /// The community this store belongs to.
  final CommunityIdentifier cid;

  /// The account (SS58) this store belongs to.
  final String address;

  /// Participant type if the account has registered for the next meetup.
  ParticipantType participantType;

  /// Contains the meetup data if the account has been assigned to a meetup in this community.
  @observable
  Meetup meetup;

  /// `ClaimOfAttendances` that were scanned during a meetup.
  ///
  /// Map: claimantPublicKey -> ClaimOfAttendance
  @observable
  ObservableMap<String, ClaimOfAttendance> participantsClaims = new ObservableMap();

  @computed
  get scannedClaimsCount => participantsClaims.length;

  @computed
  bool get isAssigned => meetup != null;

  @computed
  bool get isRegistered => participantType != null;

  @action
  void setMeetup(Meetup meetup) {
    _log("Set meetup: ${meetup.toJson()}");
    this.meetup = meetup;
    writeToCache();
  }

  @action
  void purgeMeetup() {
    if (meetup != null) {
      _log("Purging meetup.");
      meetup = null;
      writeToCache();
    }
  }

  @action
  void purgeParticipantsClaims() {
    _log("Purging participantsClaims.");
    participantsClaims.clear();
    writeToCache();
  }

  bool containsClaim(ClaimOfAttendance claim) {
    return participantsClaims[claim.claimantPublic] != null;
  }

  @action
  void addParticipantClaim(ClaimOfAttendance claim) {
    _log("adding participantsClaims.");
    participantsClaims[claim.claimantPublic] = claim;
    writeToCache();
  }

  /// Purges state that is only relevant for one Ceremony.
  ///
  /// This should be called when a transition to the next ceremony happens.
  @action
  void purgeCeremonySpecificState() {
    purgeParticipantsClaims();
    purgeMeetup();
  }

  void setCacheFn(Function cacheFn) {
    this.cacheFn = cacheFn;
  }

  Future<void> writeToCache() {
    if (cacheFn != null) {
      return cacheFn();
    } else {
      return null;
    }
  }
}

_log(String msg) {
  print("[CommunityAccountStore] $msg");
}
