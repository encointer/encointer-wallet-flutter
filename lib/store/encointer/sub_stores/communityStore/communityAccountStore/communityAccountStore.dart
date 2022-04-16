import 'dart:convert';

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

  @computed
  bool get isAssigned => meetup != null;

  @computed
  bool get isRegistered => participantType != null;

  @action
  void setMeetup(Meetup meetup) {
    this.meetup = meetup;

    if (cacheFn != null) {
      cacheFn();
    }
  }

  @action
  void clearMeetup() {
    meetup = null;
  }

  void setCacheFn(Function cacheFn) {
    this.cacheFn = cacheFn;
  }
}
