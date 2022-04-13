// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communityAccountStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityAccountStore _$CommunityAccountStoreFromJson(Map<String, dynamic> json) {
  return CommunityAccountStore()
    ..meetup = json['meetup'] == null ? null : Meetup.fromJson(json['meetup'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommunityAccountStoreToJson(CommunityAccountStore instance) => <String, dynamic>{
      'meetup': instance.meetup,
    };

_CommunityAccountStore _$_CommunityAccountStoreFromJson(Map<String, dynamic> json) {
  return _CommunityAccountStore()
    ..meetup = json['meetup'] == null ? null : Meetup.fromJson(json['meetup'] as Map<String, dynamic>);
}

Map<String, dynamic> _$_CommunityAccountStoreToJson(_CommunityAccountStore instance) => <String, dynamic>{
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

  @override
  String toString() {
    return '''
meetup: ${meetup}
    ''';
  }
}
