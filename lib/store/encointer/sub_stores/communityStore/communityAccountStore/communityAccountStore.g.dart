// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communityAccountStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityAccountStore _$CommunityAccountStoreFromJson(Map<String, dynamic> json) {
  return CommunityAccountStore(
    network: json['network'] as String,
    cid: json['cid'] == null ? null : CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
    account: json['account'] as String,
  )..meetup = json['meetup'] == null ? null : Meetup.fromJson(json['meetup'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommunityAccountStoreToJson(CommunityAccountStore instance) => <String, dynamic>{
      'network': instance.network,
      'cid': instance.cid?.toJson(),
      'account': instance.account,
      'meetup': instance.meetup?.toJson(),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommunityAccountStore on _CommunityAccountStore, Store {
  final _$meetupAtom = Atom(name: '_CommunityAccountStore.meetup');

  @override
  Meetup get meetup {
    _$meetupAtom.reportRead();
    return super.meetup;
  }

  @override
  set meetup(Meetup value) {
    _$meetupAtom.reportWrite(value, super.meetup, () {
      super.meetup = value;
    });
  }

  final _$_CommunityAccountStoreActionController = ActionController(name: '_CommunityAccountStore');

  @override
  void setMeetup(Meetup meetup, {dynamic shouldCache = true}) {
    final _$actionInfo = _$_CommunityAccountStoreActionController.startAction(name: '_CommunityAccountStore.setMeetup');
    try {
      return super.setMeetup(meetup, shouldCache: shouldCache);
    } finally {
      _$_CommunityAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
meetup: ${meetup}
    ''';
  }
}
