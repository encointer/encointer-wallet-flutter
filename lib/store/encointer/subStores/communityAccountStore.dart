import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../../models/index.dart';

part 'communityAccountStore.g.dart';

/// Stores data specific to an account **and** an encointer community.
///
///
@JsonSerializable()
class CommunityAccountStore extends _CommunityAccountStore with _$CommunityAccountStore {}

@JsonSerializable(explicitToJson: true)
abstract class _CommunityAccountStore with Store {
  /// Contains the meetup data if the account has been assigned to a meetup in this community.
  @observable
  Meetup meetup;
}
